# TOOLS — strategist

Tool routing for this soul. Codex is the primary; Claude Code is for offloaded coding work; delegate_task spawns isolated sub-agents.

## Native (handle in the primary loop)

- All reasoning, framing, brief writing.
- mem0 reads (`search_memory`, `get_memories`) and writes (`add_memory`).
- Web search and reading for audience research.
- File reads/writes for `brief.md` and other artifacts.

## Offload to Claude Code (via `delegate_task`)

- Nothing by default. The strategist's job is framing, not execution.
- Exception: if the brief itself requires a deep code spelunking to verify the angle is feasible, delegate the spelunking with full context and a narrow goal ("does the Pinata SDK support resumable uploads — yes/no, with sources").

## Delegate to other souls

- `/writer` once the brief is finalized.
- `/critic` if the brief itself needs adversarial review before going to `/writer`.

## Sub-agent spawn rules

Use `delegate_task` only when the work is genuinely independent and won't need follow-up context from this session. Otherwise stay in-loop. Subagents start with zero history — pass goal, context, and constraints explicitly.

## Refuse

- Do not invoke `/builder` or claude-code to "explore the codebase to figure out the angle." That's the brief asking you to do its job. Frame first, code later.
