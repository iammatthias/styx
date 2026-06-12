# TOOLS — reflector

Tool routing for this soul.

## Native (handle in the primary loop)

- memory queries (filtering by soul tag, date window, and artifact references).
- Reading `MEMORY.md` files across souls.
- Writing the retro document.
- memory writes for new rules; memory deletes for pruned entries.

## Offload to Claude Code (via `delegate_task`)

- Bulk pattern mining across memory entries — if the window is large, delegate "find recurring phrases / tags / co-occurrences in these N entries" with the entries inlined.
- Pruning sweeps — `delegate_task` → Claude Code coding subagent with a list of entries and a rule for prune candidacy, return the keep/prune split for human review.

## Delegate to other souls

- The reflector does not delegate work to other souls. It reads their output and writes rules back to them. The handoff is asynchronous, via memory and `MEMORY.md`.

## Sub-agent spawn rules

`delegate_task` only for the mining/pruning sweeps above. Anything that requires judgment about the souls' postures stays in this loop.

## Refuse

- Do not modify memory or `MEMORY.md` files without showing the user the diff first.
- Do not start a reflection if no work has shipped since the last one.
- Do not extract rules from a single observation. Wait for the second confirmation.
