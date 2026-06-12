#!/usr/bin/env bash
#
# styx installer — wire the soul library into a Hermes agent.
#
# Idempotent and safe to re-run for updates. Modes:
#   ./install.sh            install or update (pull, wire, build bundles)
#   ./install.sh sync       alias for install
#   ./install.sh doctor     check for dangling links / missing checkout and repair
#   ./install.sh hooks      merge the Claude Code hooks into ~/.claude/settings.json
#
# Flags:
#   --no-pull               skip "git pull" during install/sync
#   --no-bundles            skip "hermes bundles create"
#   --force                 wire even from an ephemeral checkout path
#
# Env:
#   HERMES_HOME             defaults to ~/.hermes
#   STYX_ALLOW_EPHEMERAL=1  same as --force

set -euo pipefail

# The checkout root is wherever this script lives. Everything wires from here,
# so this path must persist for the agent's lifetime (see ephemeral check).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
SKILLS_DIR="$HERMES_HOME/skills"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"

NO_PULL=0
NO_BUNDLES=0
FORCE="${STYX_ALLOW_EPHEMERAL:-0}"
MODE="install"

for arg in "$@"; do
  case "$arg" in
    install|sync) MODE="install" ;;
    doctor)       MODE="doctor" ;;
    hooks)        MODE="hooks" ;;
    --no-pull)    NO_PULL=1 ;;
    --no-bundles) NO_BUNDLES=1 ;;
    --force)      FORCE=1 ;;
    *) echo "unknown argument: $arg" >&2; exit 2 ;;
  esac
done

# --- output helpers ----------------------------------------------------------
if [ -t 1 ]; then
  B=$'\033[1m'; G=$'\033[32m'; Y=$'\033[33m'; R=$'\033[31m'; X=$'\033[0m'
else
  B=""; G=""; Y=""; R=""; X=""
fi
ok()   { printf "%s  ok%s   %s\n"   "$G" "$X" "$1"; }
warn() { printf "%s  warn%s %s\n"   "$Y" "$X" "$1"; }
err()  { printf "%s  err%s  %s\n"   "$R" "$X" "$1" >&2; }
step() { printf "%s%s%s\n" "$B" "$1" "$X"; }

# Path TO, expressed relative to directory FROM. Relative links survive the
# whole tree moving as a unit (e.g. a remounted ~/.hermes).
relpath() {
  python3 -c 'import os,sys; print(os.path.relpath(sys.argv[2], sys.argv[1]))' "$1" "$2" 2>/dev/null \
    || realpath --relative-to="$1" "$2"
}

# Reject checkout locations that get wiped on container recreate / cleanup. A
# dangling SOUL.md link doesn't just disable styx — it crashes Hermes config
# loading, so the checkout has to live somewhere persistent.
is_ephemeral() {
  case "$1" in
    */projects/*|*/workspace/*|*/scratch/*|/tmp/*|/var/tmp/*|*/.cache/*) return 0 ;;
    *) return 1 ;;
  esac
}

# Recreate $1 (a dir under skills/) as a relative symlink to $2 in the checkout.
link_relative() {
  local link="$1" target="$2" rel
  mkdir -p "$(dirname "$link")"
  rel="$(relpath "$(dirname "$link")" "$target")"
  rm -rf "$link"
  ln -s "$rel" "$link"
}

# --- the SOUL.md invariant ---------------------------------------------------
# SOUL.md is copied as a REAL FILE, never symlinked. It is the one file whose
# absence is catastrophic: Hermes' _ensure_default_soul_md() write_text()s
# through a dangling link, hits FileNotFoundError, and config loading crashes —
# the agent then falls back to an empty model and every request 403s. A real
# copy can't dangle. The cost is re-copying on the rare upstream change, which
# `./install.sh sync` handles.
copy_soul() {
  mkdir -p "$HERMES_HOME"
  cp -f "$SCRIPT_DIR/SOUL.md" "$HERMES_HOME/SOUL.md"
}

bundle_args() {
  # Build the "styx" bundle from one --skill per soul (skip the template).
  # This Hermes wants: bundles create <name> --skill A --skill B ... --force
  printf "styx"
  for d in "$SCRIPT_DIR"/souls/*/; do
    name="$(basename "$d")"
    [ "$name" = "_template" ] && continue
    printf " --skill %s" "$name"
  done
  printf " --force\n"
}

# =============================================================================
do_install() {
  step "styx → $HERMES_HOME"
  echo "  checkout: $SCRIPT_DIR"

  if is_ephemeral "$SCRIPT_DIR" && [ "$FORCE" != "1" ]; then
    err "checkout is on what looks like an ephemeral path:"
    err "  $SCRIPT_DIR"
    err "Paths under projects/, workspace/, scratch/, tmp/, or .cache/ get wiped"
    err "on container cleanup, which dangles every link and can take the agent"
    err "down. Re-clone somewhere persistent (recommended: ~/.hermes/styx):"
    err "  git clone <styx-remote> ~/.hermes/styx && cd ~/.hermes/styx && ./install.sh"
    err "Or re-run with --force if this path really does persist."
    exit 1
  fi

  if [ "$NO_PULL" != "1" ] && [ -d "$SCRIPT_DIR/.git" ]; then
    step "updating checkout"
    if git -C "$SCRIPT_DIR" pull --ff-only 2>/dev/null; then
      ok "pulled latest"
    else
      warn "git pull failed (offline or non-ff) — wiring current checkout"
    fi
  fi

  step "wiring"
  mkdir -p "$SKILLS_DIR"

  # SOUL.md: real file, never a symlink.
  [ -L "$HERMES_HOME/SOUL.md" ] && rm -f "$HERMES_HOME/SOUL.md"
  copy_soul
  ok "SOUL.md (real file copy)"

  link_relative "$SKILLS_DIR/styx-souls"  "$SCRIPT_DIR/souls"
  ok "skills/styx-souls → $(relpath "$SKILLS_DIR" "$SCRIPT_DIR/souls")"
  link_relative "$SKILLS_DIR/styx-skills" "$SCRIPT_DIR/skills"
  ok "skills/styx-skills → $(relpath "$SKILLS_DIR" "$SCRIPT_DIR/skills")"

  if [ "$NO_BUNDLES" != "1" ]; then
    step "building bundles"
    if command -v hermes >/dev/null 2>&1; then
      # shellcheck disable=SC2046
      hermes bundles create $(bundle_args)
      ok "bundle created"
    else
      warn "hermes not on PATH — skipping. Run this when it is:"
      echo "    hermes bundles create $(bundle_args)"
    fi
  fi

  step "done — restart Hermes to load the crew"
}

# =============================================================================
do_doctor() {
  step "styx doctor"
  echo "  checkout:   $SCRIPT_DIR"
  echo "  hermes home: $HERMES_HOME"
  local problems=0 repaired=0

  # Checkout itself.
  if [ ! -f "$SCRIPT_DIR/SOUL.md" ]; then
    err "checkout looks incomplete — SOUL.md missing at $SCRIPT_DIR"
    problems=$((problems + 1))
  elif is_ephemeral "$SCRIPT_DIR" && [ "$FORCE" != "1" ]; then
    warn "checkout is on an ephemeral path — it may vanish on container cleanup:"
    warn "  $SCRIPT_DIR"
    warn "Move it to a persistent location (e.g. ~/.hermes/styx) and re-run install."
    problems=$((problems + 1))
  else
    ok "checkout present and persistent"
  fi

  # SOUL.md: must exist, must be a real file (not a symlink).
  local soul="$HERMES_HOME/SOUL.md"
  if [ -L "$soul" ]; then
    warn "SOUL.md is a symlink — should be a real file (a dangle here crashes Hermes)"
    if [ -f "$SCRIPT_DIR/SOUL.md" ]; then
      rm -f "$soul"; copy_soul
      ok "repaired: replaced SOUL.md link with a real copy"
      repaired=$((repaired + 1))
    else
      problems=$((problems + 1))
    fi
  elif [ ! -f "$soul" ]; then
    warn "SOUL.md missing at $soul"
    if [ -f "$SCRIPT_DIR/SOUL.md" ]; then
      copy_soul; ok "repaired: copied SOUL.md"; repaired=$((repaired + 1))
    else
      problems=$((problems + 1))
    fi
  else
    ok "SOUL.md is a real file"
  fi

  # souls / skills links.
  local name target
  for entry in "styx-souls:$SCRIPT_DIR/souls" "styx-skills:$SCRIPT_DIR/skills"; do
    name="${entry%%:*}"; target="${entry#*:}"
    local link="$SKILLS_DIR/$name"
    if [ -e "$link" ] && [ ! -L "$link" ]; then
      ok "$name present (not a symlink)"
    elif [ -L "$link" ] && [ -e "$link" ]; then
      ok "$name link healthy"
    else
      warn "$name missing or dangling"
      if [ -d "$target" ]; then
        link_relative "$link" "$target"
        ok "repaired: $name → $(relpath "$SKILLS_DIR" "$target")"
        repaired=$((repaired + 1))
      else
        err "  cannot repair — $target does not exist"
        problems=$((problems + 1))
      fi
    fi
  done

  echo
  if [ "$problems" -gt 0 ]; then
    err "$problems problem(s) need attention ($repaired repaired)"
    exit 1
  elif [ "$repaired" -gt 0 ]; then
    step "repaired $repaired item(s) — restart Hermes"
  else
    step "all healthy"
  fi
}

# =============================================================================
# Merge the styx Claude Code hooks into ~/.claude/settings.json. Idempotent:
# drops any prior styx hook entries (matched by the stable hook-script path,
# so stale entries from a moved checkout are caught too) and re-adds the
# current ones, leaving the user's other hooks untouched. Backs up first.
do_hooks() {
  step "styx hooks → $CLAUDE_HOME/settings.json"

  if ! command -v python3 >/dev/null 2>&1; then
    err "python3 required to merge JSON safely — not found"
    exit 1
  fi

  local settings="$CLAUDE_HOME/settings.json"
  local src="$SCRIPT_DIR/hooks/hooks.json"
  mkdir -p "$CLAUDE_HOME"

  if [ -f "$settings" ]; then
    cp -f "$settings" "$settings.bak.$(date +%Y%m%d%H%M%S)"
    ok "backed up existing settings.json"
  fi

  STYX_DIR="$SCRIPT_DIR" SETTINGS="$settings" SRC="$src" python3 - <<'PY'
import json, os, sys

styx = os.environ["STYX_DIR"]
settings_path = os.environ["SETTINGS"]
src_path = os.environ["SRC"]

with open(src_path) as f:
    incoming = json.load(f)["hooks"]
# Substitute the absolute checkout path into the command strings.
for event, groups in incoming.items():
    for g in groups:
        for h in g.get("hooks", []):
            h["command"] = h["command"].replace("__STYX_DIR__", styx)

settings = {}
if os.path.exists(settings_path):
    with open(settings_path) as f:
        try:
            settings = json.load(f)
        except json.JSONDecodeError:
            print("  existing settings.json is not valid JSON — aborting", file=sys.stderr)
            sys.exit(1)

hooks = settings.setdefault("hooks", {})

def is_styx(group):
    # Match on the stable hook-script suffix, not the absolute checkout path, so
    # a moved-then-reinstalled checkout's stale entries (which still carry the
    # old path) are recognized and replaced instead of left dangling.
    markers = ("/hooks/session-start.sh", "/hooks/pre-tool-guard.sh")
    return any(
        any(h.get("command", "").endswith(m) for m in markers)
        for h in group.get("hooks", [])
    )

for event, groups in incoming.items():
    existing = [g for g in hooks.get(event, []) if not is_styx(g)]
    hooks[event] = existing + groups

with open(settings_path, "w") as f:
    json.dump(settings, f, indent=2)
    f.write("\n")
print("  merged SessionStart + PreToolUse(Bash) hooks")
PY

  ok "hooks installed — restart Claude Code to load them"
  echo "  remove: delete the styx entries from $settings, or restore a .bak"
}

case "$MODE" in
  install) do_install ;;
  doctor)  do_doctor ;;
  hooks)   do_hooks ;;
esac
