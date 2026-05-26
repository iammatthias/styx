---
name: design-review
description: Scored design audit of a UI — hierarchy, type, color, spacing, motion, interaction, responsive, copy. Returns 0-10 per dimension plus top fixes and a verdict. The /health analog for interfaces.
---

# /design-review

A read on whether an interface is good before it ships. `/taste` catches the mechanical tells in ten seconds; this is the judgment pass that scores what's left.

## When to use

- Before shipping a real UI to users.
- Auditing your own product or a competitor's — honest signal, per dimension.
- Deciding whether a design is good enough or needs a `/refactor-ui` pass.

## When NOT to use

- A 10-second tells scan → `/taste` (run it first; it feeds this).
- Actually fixing → `/refactor-ui`.
- "Is the concept even right?" → `/layers`.

## Dimensions

Run `/taste` first so the mechanical hits are already logged; they don't eat the judgment budget here.

- **Hierarchy** — is the focal point obvious in under a second? Does the eye know where to go?
- **Typography** — scale, pairing, line length, vertical rhythm, weight discipline.
- **Color & contrast** — tinted neutrals, WCAG AA met, one accent with meaning, dark mode if present.
- **Spacing & layout** — a real system, whitespace used as a tool, grid coherent, grouping by proximity.
- **Motion** — purposeful, eased well, `prefers-reduced-motion` honored, nothing gratuitous.
- **Interaction** — focus states, loading / error / empty states, touch targets ≥44px, forms that forgive.
- **Responsive** — mobile-first, fluid, no horizontal scroll, no broken breakpoints.
- **Copy** — button labels, error messages, empty states, microcopy that sounds human.

## Workflow

1. Run `/taste` for the mechanical hits.
2. Render it — `/browse` to see it real, `/friction` if it's a flow.
3. Judge each dimension. Be specific in your head about what 5 means; don't grade-inflate.
4. Pick the three fixes that move the score most.
5. Verdict.

## Output

```
UI:          [url / path / screens reviewed]
variant:     [intended style, if known]
Scores (0-10):
  hierarchy      X
  typography     X
  color          X
  spacing        X
  motion         X
  interaction    X
  responsive     X
  copy           X
Overall:     [average]

Top three fixes:
  1. [thing] → /refactor-ui
  2. [thing]
  3. [thing]

Verdict:     [ship | polish | rework]
```

## Refusals

- Don't average past a dealbreaker. 9s everywhere but 0 on contrast (it's unreadable / inaccessible) is not an 8.
- Don't grade-inflate. A 7 means "good." If everything lands 7+, recalibrate.
- Don't be polite. The point is honest signal, like `/health`.
- Don't re-litigate the tells `/taste` already caught. Score the judgment calls.
