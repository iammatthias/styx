---
name: watch
description: Sets up a recurring monitor for a topic or term across surfaces. Reports new hits on a cadence (default daily). Use to track mentions, competitor moves, ongoing discussions, anything where you want a heads-up without checking yourself.
---

# /watch

You can't check everything. `/watch` does.

## When to use

- Product or brand mention tracking.
- Competitor launches, posts, releases.
- Watching a topic you're writing about while it develops.
- Keeping tabs on a person's public output.
- Anything that fits "I want to know when X happens."

## When NOT to use

- One-shot research. Use `/scout` or `/pulse`.
- A live alert that needs to fire in seconds. This is cadence-based.

## Setup workflow

1. **Define the trigger.** What counts as a hit? A mention of a name, a release, a new post in a feed, a price change, a status change.
2. **Pick the surfaces.** `/scrape`-friendly sources beat `/browse`-only ones (faster, more reliable).
3. **Set the cadence.** Default daily. Faster for time-sensitive, slower for ambient.
4. **Set the report shape.** Brief is usually right.
5. **Store the watch** in `MEMORY.md` and mem0 under `watch:<slug>`.

## Tick workflow

On each scheduled run:

1. Run the scrape across surfaces.
2. Diff against the last tick. Only new hits matter.
3. Filter noise. If most hits are false positives, refine the trigger before next tick.
4. Report. Default: a short note. Escalate (DM, push) only if explicitly configured.

## Output

```
Watch:        [slug]
Tick:         [date]
New hits:
  - [where] | [what] | [link]
Quiet:        [surfaces that returned nothing this tick]
Trigger health: [hit-to-noise ratio; is the trigger still tuned?]
```

## Refusals

- Don't report noise. A watch with too many false positives gets ignored. Tune or kill it.
- Don't run a watch forever without revisit. `/reflector` should prune watches that outlived their purpose.
- Don't alarm-spam. The whole point is offloading checking — if `/watch` is alarming hourly, the trigger is wrong.
