#!/usr/bin/env bash
#
# styx SessionStart hook (Claude Code).
#
# Closes the /handoff loop: when a session wakes up blank, surface styx's
# orientation and the most recent context-save breadcrumb so the agent can
# offer to restore it instead of starting cold. /handoff writes these
# breadcrumbs; this hook reads the newest one.
#
# Output on stdout is added to the session's context.

set -euo pipefail

HANDOFF_DIR="${STYX_HANDOFF_DIR:-$HOME/.hermes/handoffs}"

echo "styx is loaded. Base identity is SOUL.md; the crew lives in souls/, skills in skills/."
echo "Read SOUL.md first, then TEAM.md. Don't eagerly read every soul — load one when you switch into it."

# Newest handoff breadcrumb, if any.
if [ -d "$HANDOFF_DIR" ]; then
  latest="$(ls -t "$HANDOFF_DIR"/*.md 2>/dev/null | head -1 || true)"
  if [ -n "${latest:-}" ]; then
    slug="$(basename "$latest" .md)"
    echo
    echo "A context-save breadcrumb exists: context-save:$slug"
    echo "Ask the user whether to restore it before starting new work. Preview:"
    echo "---"
    sed -n '1,20p' "$latest"
    echo "---"
  fi
fi
