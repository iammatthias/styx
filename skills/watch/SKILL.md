---
name: watch
description: Recurring monitor for a term, or a standing topic with a thesis it tracks. Reports new hits on a cadence (default weekly). Use for mentions, competitor moves, or a developing belief.
---

# /watch

You can't check everything. `/watch` does.

## When to use

- Product or brand mention tracking.
- Competitor launches, posts, releases.
- Watching a topic you're writing about while it develops.
- Keeping tabs on a person's public output.
- Anything that fits "I want to know when X happens."
- A subject you hold a *thesis* on and want tracked as belief-moving news lands — standing-topic mode below.

## When NOT to use

- One-shot research. Use `/scout` for a quick look, `/research` for a cited report.
- A live alert that needs to fire in seconds. This is cadence-based.

## Setup workflow

1. **Define the trigger.** What counts as a hit? A mention of a name, a release, a new post in a feed, a price change, a status change.
2. **Pick the surfaces.** `/scrape`-friendly sources beat `/browse`-only ones (faster, more reliable).
3. **Set the cadence.** Default weekly. Faster only for genuinely time-sensitive watches; slower for ambient.
4. **Set the report shape.** Brief is usually right.
5. **Store the watch** in the memory layer under `watch:<slug>` — that's the single live registry. `MEMORY.md` is the seed/hygiene file, not a parallel ledger; don't duplicate live watches there.

## Tick workflow

Watches don't self-fire. A tick happens when something re-invokes `/watch` — the user, a `/reflector` pass, or a host scheduler if one is wired up. There's no daemon; "cadence" is the *intended* spacing, enforced by whoever re-runs it. On each such run:

1. Run the scrape across surfaces.
2. Diff against the last tick. Only new hits matter.
3. Filter noise. If most hits are false positives, refine the trigger before next tick.
4. Report. Default: a short note. Escalate (DM, push) only if explicitly configured.

## Standing-topic mode

A plain watch reports hits. A standing topic tracks a *belief* against the news. Use it when you don't just want to know what happened — you want to know whether what happened should change your mind.

**Bootstrap once.** Run `/research` on the subject; that report seeds the topic. From it, write two documents, both stored to memory under `topic:<slug>`:

- **Thesis** — your stable top-level beliefs as numbered claims (`C1`, `C2`, …), each with a confidence and a *falsification condition* ("C2 is wrong if quarterly installs stop growing"). The thesis is **never auto-edited** — a tick can only flag tension against it, never quietly rewrite it. You revise it deliberately, and say when you did.
- **Working** — the living idea layer. New hits get synthesized in as they accumulate; each reorganization is a new version. This is where thinking moves before it earns a thesis change.

**On each tick**, after diffing hits: synthesize the belief-moving ones into `working`, and for each write a **thesis-delta** — which claim it touches and whether it's `reinforced`, `contradicted`, or `raised` (a new claim the thesis should maybe hold). Reorganize `working` under pressure (enough new items, or it's gone stale), not on a clock. Quiet ticks produce no brief.

## Output

Plain watch:

```
Watch:        [slug]
Tick:         [date]
New hits:
  - [where] | [what] | [link]
Quiet:        [surfaces that returned nothing this tick]
Trigger health: [hit-to-noise ratio; is the trigger still tuned?]
```

Standing topic (the tick brief):

```
Topic:        [slug]
Tick:         [date]
What moved:   [the day's belief-relevant items, deduped]
Thesis-deltas:
  - C[n] | reinforced|contradicted|raised | [the item, one line] | [link]
Working:      [what changed in the working doc, or "no reorg this tick"]
Thesis:       [unchanged | flagged: C[n] under pressure — your call to revise]
```

## Refusals

- Don't report noise. A watch with too many false positives gets ignored. Tune or kill it.
- Don't run a watch forever without revisit. `/reflector` should prune watches that outlived their purpose.
- Don't alarm-spam. The whole point is offloading checking — if `/watch` is alarming hourly, the trigger is wrong.
- Don't auto-edit the thesis. A tick flags tension against a claim; revising the claim is your deliberate call, logged as such. Silent thesis drift defeats the point of holding one.
