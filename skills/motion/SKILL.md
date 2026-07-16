---
name: motion
description: Motion craft for UI — when to animate and when not, easing, duration, springs, interruptibility, reduced-motion. Reviews motion, finds opportunities, or fixes with exact values. Restraint first.
---

# /motion

Great motion is mostly restraint plus a few exact numbers. Agents reach for animation everywhere and pick the wrong ingredients — `ease-in` on a dropdown, `scale(0)` entrances, a spinner that animates a keyboard shortcut. This skill picks right, and deletes more than it adds.

*Craft adapted from Emil Kowalski's design-engineering skills ([animations.dev](https://animations.dev)) and Apple's* Designing Fluid Interfaces. *`/motion` is to motion what `/refactor-ui` is to layout.*

## When to use

- Building or reviewing any animation, transition, or gesture.
- "Make this feel more alive," "the motion feels off," or "what should animate here?"
- After `/taste` flags a motion tell and you need the correct fix with real values.

## When NOT to use

- Static hierarchy, type, color, spacing → `/refactor-ui`.
- A fast mechanical tell-scan (detect, don't fix) → `/taste`. Run it first.
- A whole-UI score 0–10 → `/design-review` (motion is one dimension).
- A cold read before ship → `/critic`.

## Decide before you animate

1. **Should it animate at all?** Frequency governs — this is the first gate, not an afterthought.

   | Frequency | Verdict |
   |---|---|
   | 100+/day, or keyboard-initiated (shortcuts, command palette) | **No animation. Ever.** Raycast has no open/close animation — that's optimal. |
   | Tens/day (hover, list nav, frequent toggles) | Reduce hard, or near-imperceptible only. |
   | Occasional (modals, drawers, toasts) | Standard animation. |
   | Rare / first-run (onboarding, empty, success) | The delight budget lives here. |

2. **What's the purpose?** Name one, explicitly: *feedback · spatial consistency · state indication · preventing a jarring change · explanation.* "It looks cool" on frequently-seen UI is a delete, not an animation.

3. **What easing?** Entering/exiting → `ease-out`. Moving/morphing on-screen → `ease-in-out`. Hover/color → `ease`. Constant (marquee, spinner) → `linear`. **Never `ease-in` on UI** — it delays the moment the user watches most. Built-in curves are too weak; use custom.

4. **How fast?** UI stays **under 300ms**.

   | Element | Duration |
   |---|---|
   | Press feedback | 100–160ms |
   | Tooltips, small popovers | 125–200ms |
   | Dropdowns, selects | 150–250ms |
   | Modals, drawers | 200–500ms |
   | Marketing / explanatory | Can be longer |

## Exact values — don't approximate

- **Easing:** `--ease-out: cubic-bezier(0.23, 1, 0.32, 1)` · `--ease-in-out: cubic-bezier(0.77, 0, 0.175, 1)` · `--ease-drawer: cubic-bezier(0.32, 0.72, 0, 1)`.
- **Springs** (Apple's two-param model, easier to reason about than mass/stiffness/damping): `{ duration, bounce }`. Default `bounce: 0` (critically damped). Add `bounce: 0.1–0.3` **only when the gesture carried momentum** — a flick, a drag-release. Overshoot on a menu that just faded in feels wrong.
- **Never `scale(0)`** — nothing appears from nothing. Start `scale(0.95–0.97)` + `opacity: 0`.
- **Origin:** popovers/dropdowns/tooltips scale from their trigger (`transform-origin: var(--radix-popover-content-transform-origin)` or the equivalent). Modals are exempt — they stay centered.

## The bar (the ten standards)

Justified · frequency-appropriate · responsive easing (`ease-out`/custom, never `ease-in`) · sub-300ms · origin & physical correctness (no `scale(0)`, trigger-anchored) · interruptible (CSS transitions or springs that retarget from the current value — not `@keyframes` that restart from zero — for anything rapid or gesture-driven) · GPU-only (`transform` + `opacity`; never `width`/`height`/`top`/`left`/`margin`) · accessible (`prefers-reduced-motion` honored — *gentler, not zero*; `:hover` motion gated behind `@media (hover: hover) and (pointer: fine)`) · asymmetric enter/exit (deliberate actions animate slower, system responses snap) · cohesive with the product's personality. When unsure whether motion feels right, the strongest move is usually to delete it.

## Fluid & gesture motion (Apple principles)

For anything the user can grab — drags, swipes, sheets:

- **Respond on pointer-down**, and update the UI **1:1 during** the gesture, not just at the end.
- **Interruptible any instant.** Animate from the *current on-screen* value, never the target — starting from the target jumps. Never lock out input mid-transition. Blend velocity on reversal instead of hard-cutting.
- **Velocity handoff:** when the gesture ends, continue at the finger's release velocity so there's no seam. **Project momentum** with exponential decay to choose the snap target (not the physics-class `v²/2a`), then hand the velocity to a spring. Rubber-band at boundaries — resist progressively, don't stop hard.

## Modes

- **review** — measure a diff or component against the bar. Run `/taste` first for the mechanical hits. Output the Before/After/Why table + a verdict; approval is *earned*, default to flagging.
- **find** — sweep for places that should animate, and reject the rest. Gate every candidate on frequency → purpose → speed → function. Cap at 5–7, ordered by impact. Always list what you deliberately did *not* animate — that section is the point.
- **fix** — turn a finding into an exact recipe (file:line, curve, duration, properties), or a `/plan` for a broad sweep. The only fix for keyboard/high-frequency motion is deletion.

## Output

```
mode:         review | find | fix
Findings / Opportunities:
  | Before / Location | After / Suggested motion | Why |
  ...exact curves, durations, properties — never approximated
Rejected (find mode):   [candidate — the gate question that killed it]
Verdict:      [block | approve]  or  [how much motion this UI actually needs]
```

## Refusals

- Don't animate keyboard-initiated or 100+/day actions. Ever. That's a delete, not a tune.
- Don't ship `ease-in` on UI, `scale(0)` entrances, or `transition: all`.
- Don't animate layout properties when `transform`/`opacity` would do.
- Don't add motion without a `prefers-reduced-motion` path.
- Don't suggest motion everywhere. A short high-conviction list beats a wishlist; "no animation" is a valid answer.
- Don't approximate a curve, duration, or spring when the exact value is above.
