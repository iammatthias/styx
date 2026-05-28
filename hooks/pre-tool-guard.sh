#!/usr/bin/env bash
#
# styx PreToolUse guard hook (Claude Code), matcher: Bash.
#
# Makes the base soul's "careful" safety primitive enforced instead of
# advisory. Reads the proposed Bash command from stdin (JSON) and blocks the
# obviously-irreversible ones with exit code 2, which returns the message to
# the agent so it can confirm with the user before re-running.
#
# This is a backstop, not a policy engine. It catches the classic foot-guns;
# judgment still lives in the soul.

set -euo pipefail

cmd="$(python3 -c 'import json,sys; d=json.load(sys.stdin); print(d.get("tool_input",{}).get("command",""))' 2>/dev/null || true)"

[ -z "$cmd" ] && exit 0

block() {
  echo "careful: $1" >&2
  echo "styx guard blocked this command. If it's intended, tell the user what it does and confirm before re-running." >&2
  exit 2
}

# Irreversible / destructive patterns.
case "$cmd" in
  *"rm -rf /"*|*"rm -rf ~"*|*"rm -fr /"*)            block "recursive delete of a root/home path" ;;
  *"git push --force"*|*"git push -f "*|*"git push --force-with-lease"*) block "force-push — rewrites remote history" ;;
  *"git reset --hard"*)                              block "hard reset — discards uncommitted work" ;;
  *"DROP TABLE"*|*"DROP DATABASE"*|*"TRUNCATE "*)    block "destructive SQL (DROP/TRUNCATE)" ;;
  *"mkfs"*|*"dd if="*"of=/dev/"*)                    block "disk-level write — can wipe a device" ;;
  *":(){ :|:& };:"*)                                 block "fork bomb" ;;
esac

# Piping a remote payload straight into a shell.
if printf '%s' "$cmd" | grep -Eq '(curl|wget)[^|]*\|[[:space:]]*(sudo[[:space:]]+)?(ba)?sh'; then
  block "piping a downloaded script directly into a shell — inspect it first"
fi

# Plaintext secrets being committed/echoed (best-effort).
if printf '%s' "$cmd" | grep -Eq '(AKIA[0-9A-Z]{16}|sk-[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{36})'; then
  block "a credential-shaped string in the command — don't expose secrets"
fi

exit 0
