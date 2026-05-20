# styx

A library of agent souls. Drop one into [Hermes](https://github.com/NousResearch/hermes-agent), Claude Code, or any LLM that takes a system prompt. The agent inherits an identity, a wake-up routine, and a place to remember things.

The default soul handles whatever shows up. The crew sharpens for specific shapes of work: framing, words, code, exploration, review, shipping, reflection.

## Quickstart

Hermes, five commands, working in five minutes.

```bash
git clone <styx-remote> ~/code/styx && cd ~/code/styx

ln -s "$(pwd)/SOUL.md" ~/.hermes/SOUL.md           # base identity
ln -s "$(pwd)/souls"   ~/.hermes/skills/styx       # crew as Hermes skills
hermes bundles create styx strategist writer builder scout critic operator reflector
# restart Hermes
```

You now have `/strategist`, `/writer`, `/builder`, `/scout`, `/critic`, `/operator`, `/reflector`, and the base soul active by default.

Not using Hermes? Skip the symlinks. Paste the soul's `SOUL.md` and `HEARTBEAT.md` into your runtime's system prompt and mount its folder writable so `MEMORY.md` updates persist. `souls/<name>/` is also a valid paperclip `$AGENT_HOME`.

## The crew

Seven souls. Pick the one whose shape matches the work.

| Soul | Invoke when |
|---|---|
| [`/strategist`](./souls/strategist) | Framing new work. Worth doing, for whom, what's "done"? |
| [`/writer`](./souls/writer) | Anything text-shaped. Prose, messages, notes, docs, creative writing. |
| [`/builder`](./souls/builder) | Making things that run. Code, scripts, demos, debugging. |
| [`/scout`](./souls/scout) | Curiosity-driven exploration. Go look, return field notes. |
| [`/critic`](./souls/critic) | Stress-testing before ship. Drafts, code, claims, decisions. |
| [`/operator`](./souls/operator) | Getting work out the door. Publish, send, schedule, hand off. |
| [`/reflector`](./souls/reflector) | Weekly retro. Surface patterns, prune memory, write rules. |

The default soul announces switches in one line so you see the posture change. For multi-step work that runs the loop end-to-end, see [`TEAM.md`](./TEAM.md). For most work, one soul is plenty.

## Layout

```
styx/
├── SOUL.md            # base identity, lives at ~/.hermes/SOUL.md
├── TEAM.md            # how the crew composes for multi-step work
├── souls/
│   ├── strategist/    # frame
│   ├── writer/        # words
│   ├── builder/       # make
│   ├── scout/         # explore
│   ├── critic/        # stress-test
│   ├── operator/      # ship
│   ├── reflector/     # reflect
│   └── _template/     # scaffold for spawning new souls
```

Each soul folder is five files:

| File | What it does |
|---|---|
| `SOUL.md` | Identity, posture, what the soul refuses, deliverable shape |
| `HEARTBEAT.md` | Per-invocation checklist. Read at wake. |
| `SKILL.md` | [agentskills.io](https://agentskills.io) frontmatter so Hermes can discover it via progressive disclosure |
| `TOOLS.md` | What runs natively vs. delegates to Claude Code via `delegate_task` |
| `MEMORY.md` | Seed file. Live memory lives in mem0. |

## Invoking a soul

Three ways, in increasing isolation:

1. **`/<name>`** — load as a Hermes skill. The soul's `SKILL.md` description sits in the Level-0 metadata list (~3k tokens for the crew); full content loads on demand. Best for one-shot work.
2. **`/personality <name>`** — overlay the soul as the active identity for the session. Best when the whole conversation is the soul's work.
3. **`delegate_task` pointed at the soul** — spawn an isolated sub-agent wearing the soul. Best for independent work you don't want consuming this conversation's context. Subagents start with zero history; pass goal, context, and constraints explicitly.

## Memory

Two layers.

**mem0** is the live layer. Each soul reads its tags at orient (`writer:voice`, `builder:gotcha`, `scout:thread`, etc.) and writes new facts at exit. mem0 handles consolidation when it fills.

**`MEMORY.md`** is the seed layer. Durable rules, banned-words lists, stack defaults, recurring contexts. What a fresh mem0 instance should boot with — not a journal.

Cross-reference entities with `[[wikilinks]]`: `[[pinata]]`, `[[client-acme]]`, `[[ship-2026-05-15]]`. mem0 picks these up for graph-style queries. `/reflector` prunes both layers on cadence.

## Adding a soul

Spawn a new soul when a recurring shape of work keeps not fitting the existing crew. The default soul has a standing instruction to recognize this and act on it.

1. `cp -r souls/_template souls/<name>`
2. Fill `SOUL.md` in second person. Concrete posture, explicit refusals, named deliverable.
3. Fill `HEARTBEAT.md` as a checklist — bullets, not paragraphs.
4. Fill `SKILL.md`. `name` matches the directory. `description` is one tight sentence in third person, written the way you'd want an agent to read it when deciding whether to load you.
5. Fill `TOOLS.md` — what runs natively, what delegates.
6. Leave `MEMORY.md` lean. Seed only.
7. Add a row to the crew table in this README and the root `SOUL.md`. Add to `TEAM.md` if it joins the loop.
8. Tell the user the soul exists and what it's for.

Don't spawn speculatively. A soul that hasn't earned its existence is clutter. `/reflector` prunes souls that go quiet — be willing to be pruned.

## Notes for agents

If you're an agent landing here for the first time:

- `SOUL.md` (root) is your base identity. Read it first.
- This README and `TEAM.md` are next, in that order. Don't read every soul's `SOUL.md` eagerly — Hermes's progressive disclosure exists for a reason. Load a soul when you decide to switch into it.
- mem0 is your memory. Read it at orient, write at record. `MEMORY.md` files are seeds, not journals.
- Wikilinks (`[[name]]`) are tags. Use them so `/reflector` can prune by topic.
- Announce posture switches in one line. The user can't see your thinking; they can see your output.
- When in doubt about external action, use the safety primitives in the root soul (careful, freeze, guard). Internal action — reading, organizing, learning — moves boldly.

## Lineage

styx is a distillation, not an invention:

- **`SOUL` / `HEARTBEAT` / `MEMORY` three-file convention** — [paperclip](https://github.com/paperclipai/paperclip)
- **Forcing questions, investigate mode, safety primitives, the sprint loop** — [gstack](https://github.com/garrytan/gstack)
- **Markdown memory in git, wikilink edges** — [gbrain](https://github.com/garrytan/gbrain)
- **Skill discovery, mem0 layering, `delegate_task`, `/personality` overlays** — [Hermes](https://github.com/NousResearch/hermes-agent)

The synthesis is what's here. Each upstream does much more. Read them.
