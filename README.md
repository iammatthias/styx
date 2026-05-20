# styx

A small, opinionated library of agent souls for DevRel, marketing, and developer-tooling work. Built primarily to feed [Hermes](https://github.com/NousResearch/hermes-agent), but the souls are runtime-agnostic — any LLM with a system prompt can wear one.

## Layout

```
styx/
├── SOUL.md            # default identity (this is what lives at ~/.hermes/SOUL.md)
├── TEAM.md            # how the crew composes into a loop
├── souls/
│   ├── strategist/    # Think — briefs, positioning, narrative
│   ├── writer/        # Plan/Build — long-form content, docs
│   ├── builder/       # Build — code samples, demos, DX checks
│   ├── critic/        # Review — editorial, fact-check, voice
│   ├── operator/      # Ship — distribution, scheduling, monitoring
│   └── _template/     # scaffold for spawning new souls
```

The root `SOUL.md` is the base identity. The crew in `souls/*` are specialty personas that overlay or replace it for shaped work. The default soul knows when to switch — and when to spawn a new one.

## Lineage

Three-file convention for each soul, lifted from [paperclip](https://github.com/paperclipai/paperclip):

- `SOUL.md` — who the agent is. Identity, posture, what it cares about, how it talks.
- `HEARTBEAT.md` — what the agent does on each wake. The checklist.
- `MEMORY.md` — durable facts to carry across sessions.

The five-soul crew and its loop are distilled from [gstack](https://github.com/garrytan/gstack)'s `Think → Plan → Build → Review → Ship → Reflect` cycle, translated from "ship code" to "ship content and DX." [gbrain](https://github.com/garrytan/gbrain)'s contribution is the convention that memory is markdown in git — versioned, diff-able, portable. The loading model and base-soul-in-`$HERMES_HOME` pattern come from [Hermes](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/personality.md).

## The crew

Five souls. They compose into a loop, but each works standalone.

| Soul | Role | Loop position |
|---|---|---|
| [`strategist`](./souls/strategist) | Positioning, narrative, "why this matters" | Think |
| [`writer`](./souls/writer) | Long-form technical content, docs, tutorials | Plan / Build |
| [`builder`](./souls/builder) | Code samples, demos, integrations, DX feedback | Build |
| [`critic`](./souls/critic) | Editorial review, fact-check, voice and brand discipline | Review |
| [`operator`](./souls/operator) | Distribution, scheduling, community, the unglamorous ship work | Ship |

See [`TEAM.md`](./TEAM.md) for the loop and the handoffs.

## Using a soul

**With Hermes (primary target).** Hermes loads its base identity from `$HERMES_HOME/SOUL.md`. Symlink (or copy) the root soul there:

```bash
ln -s "$(pwd)/SOUL.md" ~/.hermes/SOUL.md
```

Overlay a specialty soul for a session with `/personality writer` (or `builder`, `critic`, etc.). The root soul's "crew" section tells Hermes when to suggest a switch itself.

**With Claude Code / Cursor / a plain LLM.** Include the desired `SOUL.md` + `HEARTBEAT.md` in the system prompt; mount the soul folder as writable so `MEMORY.md` updates persist.

**With paperclip.** Each soul folder maps directly to a paperclip agent home. Point `$AGENT_HOME` at the soul.

A soul should be self-explanatory after one read. If it needs more than a paragraph of out-of-band setup, fix the soul, not the docs.

## Adding a soul (and emergence)

The default soul has a standing instruction to recognize and spawn new souls when the existing crew handles a recurring shape of work awkwardly. The mechanics:

1. Copy `souls/_template/` to `souls/<name>/`.
2. Rewrite `SOUL.md` in second person. Specific posture, voice, refusals, deliverable.
3. Write `HEARTBEAT.md` as a checklist.
4. Leave `MEMORY.md` mostly empty.
5. Add the soul to the crew table in the root `SOUL.md` with a clear "invoke when" trigger.
6. Add a row to `TEAM.md` if it belongs in the loop.
7. Tell the user.

Prune as readily as you spawn. A soul that hasn't been invoked in months and isn't load-bearing is clutter.

## Non-goals

- No orchestration runtime. Use Hermes / paperclip / your own.
- No budgets, governance, or org charts. This is a library, not a company.
- No skill files. Skills live in your runtime; souls describe who's holding the skill.
