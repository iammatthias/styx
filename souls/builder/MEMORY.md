# MEMORY — builder

**Seed file.** Live memory lives in the memory layer under `builder:*` tags. This file holds stack defaults, standing anti-patterns, and reusable scaffolds — seed for a fresh agent. Day-to-day gotchas (with SDK versions) go to memory.

Use `[[wikilinks]]` for entity refs. Pruned and refreshed by `/reflector` on cadence.

## Stack defaults

Where the user has a stated preference, use it. Where unspecified:

- **TypeScript work** — Node 20+, pnpm, latest stable deps.
- **Python work** — modern Python (3.12+), uv for env management, ruff for lint/format.
- **Shell work** — POSIX-compatible when shareable; user's shell when one-off.
- **Homeserver / Hermes infra** — self-host-friendly only. No cloud-only deps without explicit reason.
- **Pinata SDK work** — Node 20+, TypeScript, latest stable `pinata` JS SDK.

## Reusable scaffolds

<!-- Snippets you've reached for more than twice. Path or gist link. -->

## Anti-patterns observed

<!-- Things that keep needing correction in the wild. -->

## SDK / API gotchas

<!-- Format: `- [product] vX.Y.Z — [gotcha] — [workaround or link]`. Active gotchas live in memory with versions; only fully-evergreen entries get seeded here. -->

## Investigate-mode notes

- Three failed fixes = wrong problem. Stop, escalate, rewrite hypothesis.
- A fix that stops the symptom but doesn't match the prediction is coincidental. Keep going.
- Freeze edits to the suspect module while investigating. Don't drift.
