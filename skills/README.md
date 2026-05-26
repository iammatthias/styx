# skills/

Multi-step procedures any soul can invoke. Following [agentskills.io](https://agentskills.io) — each subfolder has a `SKILL.md` with frontmatter Hermes reads at startup. Full bodies load on demand.

## What's here

| Skill | Use when |
|---|---|
| [`/browse`](./browse) | Real browser. Clicks, types, screenshots. |
| [`/friction`](./friction) | Walk a UX as a real user, report friction with timestamps. |
| [`/scrape`](./scrape) | Pull structured data from a web page. Returns JSON. |
| [`/skillify`](./skillify) | Turn a one-off into a reusable skill with tests. |
| [`/codex`](./codex) | Independent second opinion from the other model. |
| [`/document-release`](./document-release) | Update docs, README, changelog after a ship. |
| [`/health`](./health) | Codebase quality snapshot, 0-10 per dimension. |
| [`/voice-check`](./voice-check) | Fast banned-phrases / AI-tells pass on a draft. |
| [`/pulse`](./pulse) | What are people saying about X right now? |
| [`/watch`](./watch) | Recurring monitor for X across surfaces. |
| [`/taste`](./taste) | Fast pass over a UI for AI design tells. The `/voice-check` of design. |
| [`/refactor-ui`](./refactor-ui) | Improve an interface with fundamentals — hierarchy first, then the rest. |
| [`/design-review`](./design-review) | Scored design audit, 0-10 per dimension. The `/health` of UI. |
| [`/layers`](./layers) | Find which layer is actually broken before you polish the surface. |
| [`/skill-cleaner`](./skill-cleaner) | Audit skills + souls for description budget, duplicates, orphans, drift. |

## Souls vs. skills

Souls are *who*. Skills are *how*.

A soul is an identity with posture, voice, and refusals. You wear it. A skill is a multi-step procedure. You run it.

The `/writer` soul might run `/voice-check` before handing to `/critic`. The `/critic` might run `/codex` on high-stakes pieces. The `/scout` might run `/scrape` and then `/skillify` if the scrape was worth keeping. The `/designer` soul owns the design skills the way `/writer` owns `/voice-check`: `/taste` before adding, `/refactor-ui` to do the work, `/design-review` to score it, `/layers` when the surface isn't the real problem. Souls compose; skills compose; they cross-compose.

## Lineage

Most of these are distilled from [gstack](https://github.com/garrytan/gstack)'s 40+ skills. The net-new ones (`/voice-check`, `/pulse`, `/watch`) emerged from gaps the existing crew kept hitting.

The design skills (`/taste`, `/refactor-ui`, `/design-review`, `/layers`) are distilled the same way, from four upstream design skills:

- **Anti-slop tells, the seven design domains** — [impeccable](https://github.com/pbakaus/impeccable)
- **Variance / density / motion dials, the style variants** — [taste-skill](https://github.com/Leonxlnx/taste-skill)
- **Hierarchy-first fundamentals, the corrective moves** — [refactoring-ui-plugin](https://github.com/gnurio/refactoring-ui-plugin)
- **The seven layers, problem-space-before-solution-space** — [layers-skills](https://github.com/jamiemill/layers-skills)

`/skill-cleaner` is adapted from [agent-scripts](https://github.com/steipete/agent-scripts) — its Codex/OpenClaw analyzer (prompt-budget math, duplicate/unused detection, description compaction) distilled into a Hermes-native procedure that audits this library's own skills and souls.

## Adding a skill

1. `cp -r skills/_template skills/<name>`
2. Fill `SKILL.md`. Frontmatter: `name` matches the directory, `description` is third person and tight (it's what Hermes injects into Level-0 metadata).
3. Body: when to use, when not to, workflow, output shape, refusals.
4. Add `MEMORY.md` only if the skill needs persistent state (e.g., `/watch`).
5. Add a row to the table above.
6. Tell the user.

Same agentskills.io convention as souls. Same progressive disclosure.
