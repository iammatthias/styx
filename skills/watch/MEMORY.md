# MEMORY — watch

**Seed file.** Live watches live in the memory layer under `watch:*` tags — that's the single source of truth. This file is the seed/hygiene layer only: meta-rules about watching itself, not a parallel registry of live watches.

Pruned and refreshed by `/reflector` on cadence.

## Watch record format

Live watches and topics are stored in the memory layer, not here. These are the canonical shapes they take:

<!-- watch:  `- watch:<slug> — [trigger] — [surfaces] — [cadence] — [started]` -->
<!-- topic:  `topic:<slug>` holds two docs — thesis (numbered claims C1.. with confidence + falsification condition, hand-revised only) and working (living synthesis, versioned) — plus the tick briefs. -->

## Watch hygiene

- Default cadence is weekly; go faster only for genuinely time-sensitive watches. Aggressive cadences burn out.
- Kill or refine any watch whose false-positive rate exceeds ~30%.
- Revisit every watch quarterly. Surfaces shift; triggers go stale.
- Watches that haven't fired in 90 days: check the trigger or kill it.
- A `/watch` that needs hourly alarms is the wrong tool — that's a real-time alert, not a watch.
- A topic's thesis is revised deliberately, never by a tick. If ticks keep flagging the same claim as contradicted, that's the signal to sit down and revise it — not to let it rot flagged.

## Surface notes

<!-- Per-surface notes on what scrapes cleanly, what needs /browse, what changes structure often. -->
