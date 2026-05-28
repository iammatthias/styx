# styx

A library of agent souls and skills. Drop a soul into [Hermes](https://github.com/NousResearch/hermes-agent), Claude Code, or any LLM that takes a system prompt — the agent inherits an identity, a wake-up routine, and a place to remember things. Skills are reusable multi-step procedures any soul can invoke.

The default soul handles whatever shows up. The crew sharpens for specific shapes of work: framing, words, code, design, exploration, review, shipping, reflection. Skills extend reach: real browser, scraping, cross-model review, codebase health, voice checks, design audits, monitors.

## Quickstart

Hermes, two commands, working in five minutes.

```bash
git clone <styx-remote> ~/.hermes/styx && cd ~/.hermes/styx
./install.sh        # copies SOUL.md, links the crew + toolbox, builds bundles
# restart Hermes
```

**The checkout must persist.** Everything wires back to wherever you cloned, so
that path has to outlive a session. On a containerized Hermes it also has to sit
on a **mounted** path. Don't drop it in a workspace/projects dir that gets wiped
on container recreate — `install.sh` refuses those paths for this reason.
`~/.hermes/styx` is the safe default: it's persistent and already mounted.

`install.sh` is idempotent and safe to re-run — it's also how you update:

```bash
cd ~/.hermes/styx && ./install.sh        # git pull + re-wire + rebuild bundles
./install.sh doctor                       # detect & repair dangling links
```

`SOUL.md` is copied in as a real file, never a symlink — a dangling `SOUL.md`
doesn't just disable styx, it crashes Hermes config loading and takes the whole
agent down. Souls and skills are linked (a dangling skill link just fails to
load, which is harmless). If anything breaks, `./install.sh doctor` repairs it.

You now have the eight souls (`/strategist`, `/writer`, `/builder`, `/designer`, `/scout`, `/critic`, `/operator`, `/reflector`), twenty-four skills (`/browse`, `/friction`, `/scrape`, `/skillify`, `/codex`, `/document-release`, `/health`, `/voice-check`, `/pulse`, `/watch`, `/taste`, `/refactor-ui`, `/design-review`, `/layers`, `/skill-cleaner`, `/pr-review`, `/cli-design`, `/domains`, `/to-markdown`, `/triage`, `/image-gen`, `/wrangler`, `/cache-audit`, `/handoff`), and the base soul active by default.

Not using Hermes? Skip the symlinks. Paste the soul's `SOUL.md` and `HEARTBEAT.md` into your runtime's system prompt and mount its folder writable so `MEMORY.md` updates persist. `souls/<name>/` is also a valid paperclip `$AGENT_HOME`.

## The crew

Eight souls. Pick the one whose shape matches the work.

| Soul | Invoke when |
|---|---|
| [`/strategist`](./souls/strategist) | Framing new work. Worth doing, for whom, what's "done"? |
| [`/writer`](./souls/writer) | Anything text-shaped. Prose, messages, notes, docs, creative writing. |
| [`/builder`](./souls/builder) | Making things that run. Code, scripts, demos, debugging. |
| [`/designer`](./souls/designer) | How it looks and feels. Visual hierarchy, type, color, spacing, restraint. |
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
│   ├── designer/      # look + feel
│   ├── scout/         # explore
│   ├── critic/        # stress-test
│   ├── operator/      # ship
│   ├── reflector/     # reflect
│   └── _template/
├── skills/
│   ├── browse/             # real Chromium
│   ├── friction/           # walk a UX, report what hurts
│   ├── scrape/             # structured data → JSON
│   ├── skillify/           # one-off → reusable skill
│   ├── codex/              # second opinion from the other model
│   ├── document-release/   # sync docs after a ship
│   ├── health/             # codebase quality snapshot
│   ├── voice-check/        # banned phrases / AI-tells pass
│   ├── pulse/              # what people are saying about X
│   ├── watch/              # recurring monitor for X
│   ├── taste/              # AI design tells pass
│   ├── refactor-ui/        # apply design fundamentals
│   ├── design-review/      # scored UI audit
│   ├── layers/             # find the broken layer
│   ├── skill-cleaner/      # audit skills + souls for budget, dupes, drift
│   ├── pr-review/          # deep PR/issue review contract
│   ├── cli-design/         # spec a CLI before building it
│   ├── domains/            # Cloudflare domains + DNS
│   ├── to-markdown/        # any file/URL → markdown
│   ├── triage/             # prioritize an issue/PR queue
│   ├── image-gen/          # generate/edit images via API
│   ├── wrangler/           # deploy Cloudflare Workers
│   ├── cache-audit/        # find + fix broken prompt caching
│   ├── handoff/            # pack work across a boundary
│   └── _template/
```

Each soul folder is five files:

| File | What it does |
|---|---|
| `SOUL.md` | Identity, posture, what the soul refuses, deliverable shape |
| `HEARTBEAT.md` | Per-invocation checklist. Read at wake. |
| `SKILL.md` | [agentskills.io](https://agentskills.io) frontmatter so Hermes can discover it via progressive disclosure |
| `TOOLS.md` | What runs natively vs. delegates to Claude Code via `delegate_task` |
| `MEMORY.md` | Seed file. Live memory lives in the memory layer. |

## Souls vs. skills

Souls are *who*. Skills are *how*.

A soul is an identity — posture, voice, refusals. You wear it. A skill is a multi-step procedure. You run it. The `/writer` soul might run `/voice-check` before handing to `/critic`. The `/designer` soul runs `/taste` before adding to a design and `/design-review` before shipping it. The `/critic` might run `/codex` on high-stakes pieces. The `/scout` might run `/scrape` and then `/skillify` if the result was worth keeping. See [`skills/README.md`](./skills) for the full skill list.

## Invoking a soul

Three ways, in increasing isolation:

1. **`/<name>`** — load as a Hermes skill. The soul's `SKILL.md` description sits in the Level-0 metadata list (~3k tokens for the crew); full content loads on demand. Best for one-shot work.
2. **`/personality <name>`** — overlay the soul as the active identity for the session. Best when the whole conversation is the soul's work.
3. **`delegate_task` pointed at the soul** — spawn an isolated sub-agent wearing the soul. Best for independent work you don't want consuming this conversation's context. Subagents start with zero history; pass goal, context, and constraints explicitly.

## Memory

Two layers.

**Memory** is the live layer. Each soul reads its tags at orient (`writer:voice`, `builder:gotcha`, `scout:thread`, etc.) and writes new facts at exit. The memory layer handles consolidation when it fills.

**`MEMORY.md`** is the seed layer. Durable rules, banned-words lists, stack defaults, recurring contexts. What a fresh memory store should boot with — not a journal.

Cross-reference entities with `[[wikilinks]]`: `[[pinata]]`, `[[client-acme]]`, `[[ship-2026-05-15]]`. The memory layer picks these up for graph-style queries. `/reflector` prunes both layers on cadence.

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
- Memory is the live layer. Read it at orient, write at record. `MEMORY.md` files are seeds, not journals.
- Wikilinks (`[[name]]`) are tags. Use them so `/reflector` can prune by topic.
- Announce posture switches in one line. The user can't see your thinking; they can see your output.
- When in doubt about external action, use the safety primitives in the root soul (careful, freeze, guard). Internal action — reading, organizing, learning — moves boldly.

## Lineage

styx is a distillation, not an invention:

- **`SOUL` / `HEARTBEAT` / `MEMORY` three-file convention** — [paperclip](https://github.com/paperclipai/paperclip)
- **Forcing questions, investigate mode, safety primitives, the sprint loop** — [gstack](https://github.com/garrytan/gstack)
- **Markdown memory in git, wikilink edges** — [gbrain](https://github.com/garrytan/gbrain)
- **Skill discovery, memory layering, `delegate_task`, `/personality` overlays** — [Hermes](https://github.com/NousResearch/hermes-agent)
- **The `/designer` soul and its skills** — distilled from [impeccable](https://github.com/pbakaus/impeccable) (anti-slop tells, the design domains), [taste-skill](https://github.com/Leonxlnx/taste-skill) (variance/density/motion dials, style variants), [refactoring-ui-plugin](https://github.com/gnurio/refactoring-ui-plugin) (hierarchy-first fundamentals), and [layers-skills](https://github.com/jamiemill/layers-skills) (the seven layers of product design)
- **`/skill-cleaner`, `/pr-review`, `/triage`, `/cli-design`, `/to-markdown`, `/domains`, `/wrangler`, `/image-gen`** — lifted from [agent-scripts](https://github.com/steipete/agent-scripts) (skill-cleaner, github-deep-review, github-project-triage, create-cli, markdown-converter, cloudflare-registrar + domain-dns-ops, wrangler, nano-banana-pro + openai-image-gen), de-Codex'd, de-personalized, and made runtime-agnostic
- **`/cache-audit`** — distilled from [prompt-cache-skills](https://github.com/OnlyTerp/prompt-cache-skills), which ships per-harness patches for Cline/Roo/Continue/OpenCode/Aider; collapsed into one runtime-agnostic procedure — the four recurring bugs, the fix, and on-the-wire verification
- **`/handoff`** — formalizes the base soul's context-save mode into a skill, in the spirit of agent-scripts' handoff

The synthesis is what's here. Each upstream does much more. Read them.
