---
name: handoff
description: Packages work to hand across a boundary — a future session, another soul, a subagent, or a person. Self-contained context-save so nothing's lost. Use before exiting non-trivial work.
---

# /handoff

Work that crosses a boundary loses context unless you pack it. A new session wakes up blank. A subagent starts with zero history. A person wasn't in the room. `/handoff` writes a self-contained record so the receiver can pick up cold. This formalizes the base soul's context-save mode into a skill you can run on purpose.

## When to use

- Non-trivial work that may span sessions — write the save before you exit.
- Spawning a subagent with `delegate_task` — the prompt *is* the handoff.
- Handing a thread to another soul, or to a person who wasn't here.
- Before a long pause, where future-you is effectively a stranger.

## When NOT to use

- A trivial one-shot that finishes in the session.
- A live soul→soul pass *inside* an active loop — that's the lightweight artifact handoff in [`TEAM.md`](../../TEAM.md) (brief, draft, review notes). Use `/handoff` when the receiver has **no** shared context.

## Workflow

1. **Name the boundary and receiver.** Future session, a named soul, a fresh subagent, or a person. The receiver sets the detail level: a subagent or a person needs everything spelled out; a soul already shares the base identity and memory.
2. **Capture state, honestly:**
   - **Goal** — what we're actually trying to do.
   - **Done** — what's finished and verified.
   - **Decided** — choices made and *why* (so the receiver doesn't relitigate them).
   - **Open** — what's unresolved, with the live questions.
   - **Next** — the one concrete move to make first.
   - **Gotchas** — dead ends, traps, things that surprised you.
   - **Artifacts** — paths, branch, links, slugs. Where the work physically lives.
3. **Tag with `[[wikilinks]]`** to the briefs, drafts, or souls involved, so memory's graph and `/reflector` can find it later.
4. **Write it where the receiver will look.** memory `context-save:<slug>` for a future session; the `delegate_task` prompt for a subagent; a message or doc for a person.
5. **Tell the user the slug** so they can resume with `/context-restore <slug>` (or just by reminding you).

## Output

```
context-save: <slug>
Goal:      [what we're trying to do]
Done:      [finished + verified]
Decided:   [choice — why]
Open:      [unresolved + the live question]
Next:      [the first concrete move]
Gotchas:   [dead ends, traps]
Artifacts: [paths / branch / links]
Links:     [[brief]] [[draft]] [[soul]]
```

## Refusals

- Don't hand off a rosier state than is true. "Tests not yet run" beats a silent gap the receiver discovers the hard way.
- Don't assume shared context the receiver lacks. A subagent and a person start from zero — write for them.
- Don't bury the next move. Lead the receiver to the first action.
- Don't skip the slug. An unannounced save is one nobody restores.
