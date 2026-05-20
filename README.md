# styx

A small, opinionated library of agent souls for a capable, curious general-purpose assistant. Built primarily to feed [Hermes](https://github.com/NousResearch/hermes-agent), but the souls are runtime-agnostic — any LLM with a system prompt can wear one.

The default soul handles whatever lands. The crew sharpens for specific shapes of work — framing decisions, writing words, building things, scouting unknown territory, stress-testing what's done, shipping what's ready, reflecting on the whole.

## Layout

```
styx/
├── SOUL.md            # default identity (symlink to ~/.hermes/SOUL.md)
├── TEAM.md            # how the crew composes into a loop
├── souls/
│   ├── strategist/    # Frame — what's worth doing, for whom, what's done
│   ├── writer/        # Words — prose, messages, notes, docs, creative
│   ├── builder/       # Make — code, scripts, configs, demos, debugging
│   ├── scout/         # Explore — curiosity, research, field notes
│   ├── critic/        # Stress-test — drafts, code, claims, decisions
│   ├── operator/      # Ship — publish, send, schedule, hand off
│   ├── reflector/     # Reflect — weekly retro, pattern mining, pruning
│   └── _template/     # scaffold for spawning new souls
```

Each soul folder contains:
- `SOUL.md` — identity, posture, refusals, deliverable shape
- `HEARTBEAT.md` — per-wake checklist
- `SKILL.md` — agentskills.io frontmatter so Hermes can discover and load it on demand
- `TOOLS.md` — codex vs claude-code-via-delegate_task routing rules
- `MEMORY.md` — seed file with durable rules (live memory lives in mem0)

The root `SOUL.md` is the base identity. The crew in `souls/*` are specialty personas, discoverable via Hermes's native skill system. The default soul knows when to switch — and when to spawn a new one.

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

## Quickstart (Hermes, 5 minutes)

```bash
# 1. Clone styx (or wherever you keep it)
git clone <styx-remote> ~/code/styx && cd ~/code/styx

# 2. Wire the base soul as Hermes's identity
ln -s "$(pwd)/SOUL.md" ~/.hermes/SOUL.md

# 3. Register the crew as skills (one of these two)
#    a) symlink — keeps styx editable in place
ln -s "$(pwd)/souls" ~/.hermes/skills/styx
#    b) or add an external skills dir in ~/.hermes/config.yaml
#       skills:
#         external_dirs:
#           - ~/code/styx/souls

# 4. (Optional) bundle them under a single command
hermes bundles create styx strategist writer builder scout critic operator reflector

# 5. Restart Hermes. You should now have /strategist, /writer, /builder,
#    /scout, /critic, /operator, /reflector — plus the base SOUL.md active.
```

That's it. First-success target is ≤5 minutes; if it took longer, open an issue against this README.

## Using a soul

Three Hermes-native ways to invoke a soul, in increasing isolation:

1. **`/<name>`** — load as a skill via progressive disclosure. Hermes injects the soul's description into the Level-0 list, loads full content on demand. Best for one-shot work.
2. **`/personality <name>`** — overlay the soul as the active identity for the session. Best when the whole conversation is about that soul's work.
3. **`delegate_task` with the soul's path** — spawn an isolated sub-agent wearing the soul, fresh context. Best when the work is independent and you don't want it consuming this conversation's context.

The default soul (`SOUL.md` at root) knows when to switch and announces the change ("switching into writer for the draft") so you can see the posture shift.

### With other runtimes

- **Claude Code / Cursor / plain LLM** — include the desired `SOUL.md` + `HEARTBEAT.md` in the system prompt; mount the soul folder writable so seed `MEMORY.md` updates persist.
- **paperclip** — each soul folder maps directly to a paperclip agent home. Point `$AGENT_HOME` at the soul.

## Memory and mem0

Two layers, intentionally:

- **mem0** holds the live, dynamic memory — read at orient, written at record. Each soul writes with a tag prefix (`writer:voice`, `builder:gotcha`, etc.) so queries stay scoped.
- **`MEMORY.md`** (per soul) is the seed file. Durable rules, banned-words lists, recurring-client conventions. What a fresh mem0 instance should boot with.

Cross-reference entities with `[[wikilinks]]` (`[[pinata]]`, `[[client-acme]]`, `[[ship-2026-05-15-jwt]]`). mem0 picks these up for graph-style lookups. `/reflector` prunes both layers on cadence.

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
