# hooks/

Optional **Claude Code** hooks that wire two of styx's ideas into the harness so they happen automatically instead of relying on the agent to remember.

Hermes doesn't use these — it gets the same behavior from each soul's `HEARTBEAT.md` (orientation at wake) and the base soul's safety primitives. Hooks are for hosts that run a hook lifecycle. Today that's Claude Code.

## What they do

| Hook | Event | What it does |
|---|---|---|
| `session-start.sh` | `SessionStart` | Prints styx orientation and surfaces the newest `/handoff` breadcrumb so a blank session can offer to restore it. Closes the `/handoff` → context-restore loop. |
| `pre-tool-guard.sh` | `PreToolUse` (Bash) | Blocks the classic irreversible commands (`rm -rf /`, force-push, `DROP TABLE`, `curl … \| sh`, exposed secrets) with exit code 2, returning a "careful" message so the agent confirms before re-running. Makes the base soul's **careful** primitive enforced, not advisory. |

`session-start.sh` reads breadcrumbs from `$STYX_HANDOFF_DIR` (default `~/.hermes/handoffs/`). For the loop to close, `/handoff` should drop a `<slug>.md` there in addition to writing the memory entry — see [`skills/handoff`](../skills/handoff).

## Install

```bash
./install.sh hooks          # merge into ~/.claude/settings.json (backs up first)
```

Idempotent — re-running replaces styx's entries without touching your other hooks. The merge substitutes the absolute checkout path into `hooks.json`, but detects its own entries by the hook-script path (`…/hooks/session-start.sh`, `…/hooks/pre-tool-guard.sh`), not the full checkout path. So a re-run survives a `git pull` and, after moving the checkout, cleans up the stale entry too (re-run once after the move).

To remove them, delete the styx `SessionStart`/`PreToolUse` command entries from `~/.claude/settings.json`, or restore the timestamped backup the installer wrote next to it.

## Tune

- `STYX_HANDOFF_DIR` — where `session-start.sh` looks for breadcrumbs.
- The guard is a backstop, not a policy engine. Edit the `case` patterns in `pre-tool-guard.sh` to fit your risk tolerance; judgment still lives in the soul.
