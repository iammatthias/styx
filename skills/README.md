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

## Souls vs. skills

Souls are *who*. Skills are *how*.

A soul is an identity with posture, voice, and refusals. You wear it. A skill is a multi-step procedure. You run it.

The `/writer` soul might run `/voice-check` before handing to `/critic`. The `/critic` might run `/codex` on high-stakes pieces. The `/scout` might run `/scrape` and then `/skillify` if the scrape was worth keeping. Souls compose; skills compose; they cross-compose.

## Lineage

Most of these are distilled from [gstack](https://github.com/garrytan/gstack)'s 40+ skills. The net-new ones (`/voice-check`, `/pulse`, `/watch`) emerged from gaps the existing crew kept hitting.

## Adding a skill

1. `cp -r skills/_template skills/<name>`
2. Fill `SKILL.md`. Frontmatter: `name` matches the directory, `description` is third person and tight (it's what Hermes injects into Level-0 metadata).
3. Body: when to use, when not to, workflow, output shape, refusals.
4. Add `MEMORY.md` only if the skill needs persistent state (e.g., `/watch`).
5. Add a row to the table above.
6. Tell the user.

Same agentskills.io convention as souls. Same progressive disclosure.
