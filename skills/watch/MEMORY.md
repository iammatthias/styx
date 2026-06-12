# MEMORY — watch

**Seed file.** Live watches live in the memory layer under `watch:*` tags — that's the single source of truth. This file is the seed/hygiene layer only: meta-rules about watching itself, not a parallel registry of live watches.

Pruned and refreshed by `/reflector` on cadence.

## Watch record format

Live watches are stored in the memory layer, not here. This is the canonical shape they take:

<!-- `- watch:<slug> — [trigger] — [surfaces] — [cadence] — [started]` -->

## Watch hygiene

- Default cadence is weekly; go faster only for genuinely time-sensitive watches. Aggressive cadences burn out.
- Kill or refine any watch whose false-positive rate exceeds ~30%.
- Revisit every watch quarterly. Surfaces shift; triggers go stale.
- Watches that haven't fired in 90 days: check the trigger or kill it.
- A `/watch` that needs hourly alarms is the wrong tool — that's a real-time alert, not a watch.

## Surface notes

<!-- Per-surface notes on what scrapes cleanly, what needs /browse, what changes structure often. -->
