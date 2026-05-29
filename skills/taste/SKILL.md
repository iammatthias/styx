---
name: taste
description: Fast pass over a UI (rendered or code) for AI design tells — purple-blue gradients, nested cards, glow shadows, bounce easing. Returns a hit list. Run before /refactor-ui or /design-review.
---

# /taste

Ten seconds before `/design-review`. Catches the slop so the real critique can focus.

This is the `/voice-check` of design — a mechanical pass for the tells that scream "an AI made this and no one looked." It names the tell. It does not fix it (`/refactor-ui` fixes) and it does not grade (`/design-review` grades).

## When to use

- Before shipping any frontend, especially one an AI generated or edited.
- When a design feels generic but you can't say why.
- On a competitor's UI, to learn the difference between theirs and slop.
- After a long design session when your eye has glazed.

## When NOT to use

- Deep, scored critique → `/design-review`.
- Actually fixing the hits → `/refactor-ui`.
- "Is the underlying concept right?" → `/layers`. Taste can't fix a broken conceptual model.

## What it checks

Reads the seed tells list in `souls/designer/MEMORY.md` plus any live additions in memory under `designer:tells`. Then scans, by domain:

- **Type** — Inter / Arial / system stack for *everything*; no pairing; one weight doing every job; mono (JetBrains Mono et al.) on body/UI copy to fake "technical"; line length past ~75ch; cramped line-height on body; skipped heading levels.
- **Color** — purple→blue gradients; pure black (`#000`) text or background; untinted grays; gray text on a colored fill; an accent used on everything so nothing stands out.
- **Shadow** — the default `box-shadow` glow on every card; dark glows; one elevation for everything; shadow used where proximity would do.
- **Layout** — cards nested in cards; *everything* wrapped in a card; the generated-landing-page skeleton (numbered "step" lists + bullet stacks, identical rounded feature cards, the same outline+fill button pair); decorative blinking-dot status badges where nothing is live; centered-everything with no real hierarchy; borders doing a job whitespace should.
- **Motion** — bounce / elastic easing (dated); no `prefers-reduced-motion` path; default 150ms-on-everything; motion with no purpose.
- **Space** — values not on a scale (13px, 27px); cramped padding; touch targets under 44px.
- **Copy** — `Lorem ipsum` left in; "Submit" / "Click here" labels; empty states that are just blank; error text that blames the user.

## Output

```
hits:
  - [selector / file:line] | Inter on body + headings, no pairing        | tell: overused type
  - [selector / file:line] | linear-gradient(135deg, #7c3aed, #2563eb)   | tell: purple→blue gradient
  - [selector / file:line] | color #000 on body text                     | tell: pure black, untinted
  - [selector / file:line] | card > card > card                          | tell: nested cards
  - [selector / file:line] | cubic-bezier bounce on hover                | tell: dated easing
  - [selector / file:line] | no prefers-reduced-motion                   | tell: motion, no opt-out

severity: [low | medium | high]
```

Severity is **high** if any tell is load-bearing (gradient hero, Inter-everywhere, no contrast), **medium** if three or more cosmetic tells, **low** otherwise.

## Refusals

- Don't fix. Name the tell; `/refactor-ui` does the work.
- Don't grade taste — that's `/design-review`. Surface only the mechanical tells.
- Don't auto-edit. Surfacing is the deliverable.
- Don't flag a deliberate choice as a tell without saying so. A brutalist design *means* the hard contrast; note it, don't ding it.
