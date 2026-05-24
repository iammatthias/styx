---
name: layers
description: Locates product/design work in seven layers — observed behaviour, domain, needs, strategy, conceptual model, interaction flow, surface. Finds the weakest lower layer creating UX debt before you polish the surface. Use to frame what to build, not how it looks.
---

# /layers

Most UI problems aren't UI problems. Before you reach for `/refactor-ui`, find out which layer is actually broken.

Lower layers are foundations for upper ones. A weak lower layer creates UX debt that propagates up — and no amount of surface polish pays it down. The most neglected layer is almost always the **conceptual model**.

## When to use

- Before designing UI for a real product (not a one-off page).
- When a screen feels off but the visuals are fine — the problem is deeper.
- When redesigning and you're tempted to start at the surface.
- When the team keeps shipping cosmetic fixes that don't move the needle.

## When NOT to use

- Pure visual polish on a concept that's already sound → `/refactor-ui`.
- A fast tells pass → `/taste`.

## The seven layers

**Problem space** — understand before you solve.

1. **Observed behaviour** → what users actually do, as job stories ("when ___, I want to ___, so I can ___").
2. **The domain** → a concept map and shared vocabulary. What are the real-world things and how do they relate?
3. **User needs** → the job stories, prioritized. Which jobs matter most?

**Solution space** — turn understanding into deliberate decisions.

4. **Product & service strategy** → an opportunity tree. Which jobs do we serve, and how?
5. **Conceptual model** → the object map and state diagrams. The objects, their relationships, their vocabulary. *This is the one teams skip.*
6. **Interaction structure & flow** → breadboards. The screens, the moves between them, before any visuals.
7. **Surface** → the visible design. Type, color, spacing, motion — what `/refactor-ui` and `/taste` operate on.

## Workflow

1. **Locate the work.** Which layer does the request live at? Usually someone hands you layer 7 and the problem is lower.
2. **Walk down.** From the surface, descend until you hit the lowest weak layer. That's where the debt is.
3. **Name the debt.** State what's weak and how it propagates upward. "The object model conflates 'project' and 'workspace,' so every screen needs a mode toggle that confuses people."
4. **Fix at the source.** Firm up the lowest weak layer first. Hand surface work to `/refactor-ui` only once the layers beneath it hold.

## Output

```
work is at layer:   [1–7, what was actually requested]
weakest layer:      [1–7] — [why it's weak]
debt it creates:    [how the weakness shows up at the surface]
fix here first:     [the layer to firm up, and the artifact it needs —
                     job stories / concept map / object map / breadboard]
then:               [hand to /strategist for framing, /refactor-ui for surface]
```

## Refusals

- Don't jump to surface fixes when the conceptual model is broken. That's lipstick on UX debt.
- Don't skip the problem space on net-new work. Frameless design drifts.
- Don't treat job stories as a feature list. A job is a goal, not a button.
- Don't redesign every layer when only one is weak. Find the lowest break; fix there.
