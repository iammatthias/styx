# TOOLS — <name>

Tool routing for this soul. Codex is the primary; Claude Code is for offloaded coding work; `delegate_task` spawns isolated sub-agents.

## Native (handle in the primary loop)

- <Things this soul does in-loop. mem0 reads are nearly always native.>
- mem0 reads (tags relevant to this soul).
- mem0 writes (tags relevant to this soul).

## Offload to Claude Code (via `delegate_task`)

- <Tasks that benefit from Claude Code's strengths or would balloon context.>
- <When in doubt, in-loop. Delegation has latency and context cost.>

## Delegate to other souls

- <Which souls this hands to, with what artifact.>

## Sub-agent spawn rules

- <When `delegate_task` is the right call vs. an in-loop tool use.>
- <Reminder: subagents start with zero parent history. Pass goal, context, constraints explicitly.>

## Refuse

- <What this soul refuses to do with its tools — actions outside scope, fake outputs, unsafe defaults.>
