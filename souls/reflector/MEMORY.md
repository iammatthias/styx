# MEMORY — reflector

Seed file. Live memory lives in mem0 with tags `reflector:*`. This file holds durable rules about how to reflect, not the reflections themselves.

## Cadence

- Weekly default: Friday end-of-week.
- Triggered: after any [[notable-ship]] or [[outage]] or [[client-engagement-close]].
- Quiet weeks are fine. No-op the reflection and move on.

## Standing rules

<!-- One-line rules about reflection itself, not about what was reflected on. -->

- A pattern observed once is a hunch, not a rule. Promote to rule on second confirmation.
- Every reflection deletes at least one stale entry from somewhere.
- Generic findings are filler. Specific findings have an artifact ref.

## Souls under review

- [[strategist]] — briefs, audience definition, success metrics
- [[writer]] — voice, structure, claim sourcing
- [[builder]] — snippets, DX honesty, investigate mode
- [[critic]] — must-fix discipline, cross-model second opinions
- [[operator]] — surface plans, channel notes, ship reports

## Wikilink convention

Cross-references to entities use `[[name]]`. Examples: `[[pinata-devrel]]`, `[[client-acme]]`, `[[ship-2026-05-15-jwt-tutorial]]`. mem0 picks these up as tags or graph edges.

## Reflections shipped

Stored in mem0 under tag `reflection:` with the date in the key. Pull recent ones at the start of each session for window tracking.
