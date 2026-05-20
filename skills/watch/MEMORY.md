# MEMORY — watch

**Seed file.** Live watches live in mem0 under `watch:*` tags. This file holds active watch definitions and meta-rules about watching itself.

Pruned and refreshed by `/reflector` on cadence.

## Active watches

<!-- Format: `- watch:<slug> — [trigger] — [surfaces] — [cadence] — [started]` -->

## Watch hygiene

- Default cadence is daily. Bias slower; faster cadences burn out.
- Kill or refine any watch whose false-positive rate exceeds ~30%.
- Revisit every watch quarterly. Surfaces shift; triggers go stale.
- Watches that haven't fired in 90 days: check the trigger or kill it.
- A `/watch` that needs hourly alarms is the wrong tool — that's a real-time alert, not a watch.

## Surface notes

<!-- Per-surface notes on what scrapes cleanly, what needs /browse, what changes structure often. -->
