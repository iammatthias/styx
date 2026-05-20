# MEMORY — builder

**Seed file.** Live memory lives in mem0 under `builder:*` tags. This file holds stack defaults and standing anti-patterns — seed for a fresh agent. Day-to-day gotchas (with SDK versions) go to mem0.

Use `[[wikilinks]]` for entity refs. Pruned and refreshed by `/reflector` on cadence.

## SDK / API gotchas

<!-- Format: `- [product] vX.Y.Z — [gotcha] — [workaround or link]` -->

## Reusable scaffolds

<!-- Snippets you've reached for more than twice. Path or gist link. -->

## DX warts worth a piece

<!-- Friction points you've hit that might deserve their own writeup. -->

## Stack defaults

- **Pinata** — Node 20+, TypeScript, pnpm, `pinata` JS SDK latest stable.
- **Hermes / homeserver** — self-host-friendly only; no managed-cloud-only deps without explicit reason.
- **Consultancy** — set per client.

## Anti-patterns observed

<!-- Things devs do in the wild that you keep needing to correct. -->
