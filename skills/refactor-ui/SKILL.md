---
name: refactor-ui
description: Improves an interface with fundamentals, hierarchy first — type, color, spacing, shadows, states. Tunable via variance/density/motion dials. Fixes what /taste and /design-review flag.
---

# /refactor-ui

Take a UI that works and make it look like someone with taste built it. Fundamentals, in order. Hierarchy before color, structure before polish.

## When to use

- A UI functions but reads as amateur or generic.
- After `/taste` or `/design-review` flagged hits and someone has to fix them.
- Turning a wireframe or a working-but-ugly prototype into something shippable.

## When NOT to use

- Deciding *what* to build or whether the concept holds → `/layers`.
- Just detecting tells → `/taste`.
- Scoring the result → `/design-review`.

## Infer the direction first

Before the dials, read what you've got. Don't default to one house style — let the work tell you where it's going.

- **From a brief** — pull the intended audience, mood, and references. A fintech dashboard and a indie zine want opposite dials; the brief says which.
- **From existing code (redesign)** — audit before you touch. Map the current hierarchy, spacing system (or absence of one), type scale, and color logic. Name what's actually broken — usually hierarchy or spacing, rarely color — so you fix the cause, not the symptom. This is the `/layers` instinct applied to a surface: don't repaint a wall that's structurally cracked.
- **No brief, no precedent** — infer from the product's job and state your read in one line before proceeding, so the user can correct the direction before you build on it.

## Set the dials first

State these before you touch anything. They scope every decision below.

- **VARIANCE (1–10)** — layout adventurousness. 1: centered, safe, symmetric. 10: asymmetric, broken-grid, editorial.
- **DENSITY (1–10)** — information per viewport. 1: spacious marketing page. 10: a trading dashboard.
- **MOTION (1–10)** — animation depth. 1: instant, maybe a hover. 10: scroll-triggered, staggered, magnetic.

And pick **one** style variant, then commit to it:

- **soft** — calm, premium, generous whitespace, softer contrast, spring motion.
- **minimalist / editorial** — Linear/Notion register: restrained palette, crisp structure, type does the work.
- **brutalist** — Swiss type, hard contrast, exposed grid, experimental layout.

## The moves, in order

Order matters. Skipping to color is the classic mistake.

1. **Hierarchy.** Decide primary / secondary / tertiary. Express it with weight, size, and color — not borders. The focal point should be obvious in under a second.
2. **Type.** Pick a modular scale (1.2–1.333). Cap weights at two or three. Line length 45–75ch. Line-height inverse to size — tighter for headings, ~1.5–1.6 for body.
3. **Color.** Never pure black or gray — tint the neutrals (build the scale in OKLCH or HSL). One accent, used sparingly so it still means "look here." Hit WCAG AA contrast. If there's dark mode, design it, don't invert.
4. **Space.** One spacing system (4 / 8px base). Whitespace is the cheapest upgrade you have. Group by proximity before you reach for a border or a card.
5. **Shadow.** Elevation maps to importance. One light source, consistent. Soft and tinted, never a dark glow. If proximity already groups it, no shadow.
6. **De-clutter.** Remove every border, divider, and card the spacing already handles. Fewer nests.
7. **States.** Empty, loading, and error are part of the design, not afterthoughts. Real copy, a next action, never a blank rectangle.
8. **Buttons.** One primary action per view. Everything else is secondary or ghost.

## Output

```
variant:   [soft | minimalist | brutalist]
dials:     variance N · density N · motion N
artifact:  [updated code / markup / tokens]
changelog:
  - [move] — [what changed] — [why, in principle not preference]
  - ...
open:      [decisions for /critic or the user]
```

## Refusals

- Don't start with color. Hierarchy and structure first; color is the last 10%.
- Don't blend variants. Soft *or* brutalist, not a muddle of both.
- Don't add motion without a `prefers-reduced-motion` path.
- Don't introduce a tell `/taste` would flag. You fix slop; you don't add it.
- Don't gold-plate past the brief. Ship the upgrade, not your portfolio.
- Pre-flight before handing back: the code is complete and runnable — no truncation, no `/* … */` standing in for the part that matters, no half-applied variant. A snippet that won't paste-and-run isn't a deliverable.
