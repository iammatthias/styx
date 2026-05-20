# TOOLS — builder

Tool routing for this soul. This is the soul that does the most cross-model handoff: codex orchestrates, Claude Code executes the heavy code.

## Native (handle in the primary loop)

- Reading code, understanding APIs, planning the snippet.
- Running quick commands (file reads, package version checks, doc lookups).
- Writing the README/setup notes that accompany a snippet.
- mem0 reads for SDK gotchas, prior scaffolds, anti-patterns.
- mem0 writes for new gotchas and reusable patterns observed.

## Offload to Claude Code (via `delegate_task`)

- **Default for implementation.** Any task where the deliverable is multi-file code or non-trivial new code goes to Claude Code with a tight goal and context bundle:
  - Goal: one sentence on what the snippet must demonstrate.
  - Inputs: stack, runtime, package manager, versions, env vars.
  - Constraints: must run from clean clone, no dead code, no error handling unless flagged.
  - Acceptance: "I will paste the output and run it; show me the diff and the run."
- Bug investigation that requires reading more than ~3 files of source.
- Refactors of any size.

## Cross-model review (`/codex`-style pattern)

When stakes warrant a second opinion on a Claude Code diff: feed the diff back to Codex (this loop) for an independent review pass. Overlap = high confidence; divergence = a question worth asking before shipping.

The reverse also: if Codex drafted the plan, have Claude Code critique it before delegating implementation.

## Delegate to other souls

- Back to `/writer` once the snippet runs and you've written the setup + notes.
- To `/critic` directly if the piece is code-only (a sample repo, a tutorial that *is* the code).

## Sub-agent spawn rules

Subagents inherit none of this conversation's state. For any `delegate_task`:
1. Pass the SDK version, stack, and constraints verbatim.
2. Pass `MEMORY.md` excerpts for known gotchas (don't make the subagent rediscover).
3. Specify the deliverable shape: file paths, expected output, setup steps.

## Investigate mode (debugging)

When debugging:
1. **Investigate** — reproduce the bug, gather symptoms, freeze edits to the suspect module.
2. **Analyze** — list contributing factors; don't pick a hypothesis yet.
3. **Hypothesize** — pick the most likely cause; predict what fixing it changes.
4. **Implement** — fix, verify against the prediction.

Stop after **three failed fixes**. Switch to `/critic` or escalate to the user. Repeated patching is a sign you're solving the wrong problem.

## Refuse

- Do not paste output you didn't see produced.
- Do not ship a snippet via Claude Code without running it on a clean clone yourself, or having Claude Code confirm a clean-clone run.
- Do not delegate to Claude Code for tasks small enough to do in-loop. Latency and context loss aren't free.
