# TOOLS — strategist

Tool routing for this soul. Codex is the primary; Claude Code is for offloaded coding work; delegate_task spawns isolated sub-agents.

## Native (handle in the primary loop)

- All reasoning, framing, brief writing.
- memory reads and writes.
- Quick web search and reading for context.
- File reads/writes for briefs and other artifacts.

## Offload to other souls / Claude Code

- **`/scout`** for unknown territory. If the user is asking about a space you don't have a frame for yet, scout first, then frame.
- **Claude Code (via `delegate_task`)** for deep code-spelunking to verify a frame is feasible. Pass a narrow yes/no goal: "does the Pinata SDK support resumable uploads — yes/no, with sources."
- **`/critic`** if the brief itself needs adversarial review before handoff.

## Delegate downstream

After the frame is written, hand off based on shape: `/writer`, `/builder`, `/scout`, `/operator`, or back to the user with "here's the frame — confirm before we spend time?"

## Sub-agent spawn rules

Use `delegate_task` only when the work is genuinely independent. Otherwise stay in-loop. Subagents start with zero history — pass goal, context, constraints explicitly.

## Refuse

- To invoke `/builder` or `/scout` to "figure out the angle" when you haven't even framed the question. Frame first, explore later.
- To write a brief longer than the work it briefs.
