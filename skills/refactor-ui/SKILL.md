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
