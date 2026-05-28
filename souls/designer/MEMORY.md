# MEMORY — designer

**Seed file.** Live memory lives in the memory layer under `designer:*` tags. This file holds the tells list, design-token defaults, and style-variant conventions — seed for a fresh agent.

Use `[[wikilinks]]` for entity refs. Pruned and refreshed by `/reflector` on cadence.

## Tells in current rotation

<!-- The slop patterns /taste scans for. This is the design analog of writer's banned-words list. Refresh as AI defaults shift. -->

- Inter (or Arial / system stack) for everything, no pairing
- purple→blue gradient (`#7c3aed → #2563eb` and its cousins)
- pure black (`#000`) text or background, never tinted
- untinted gray neutrals
- gray text on a colored fill (fails contrast, reads cheap)
- the default `box-shadow` glow on every card
- dark glows / neon shadows
- cards nested inside cards
- everything wrapped in a card
- centered-everything with no real hierarchy
- bounce / elastic easing (dated)
- motion with no `prefers-reduced-motion` path
- spacing values off any scale (13px, 27px)
- touch targets under 44px
- `Lorem ipsum` shipped in
- "Submit" / "Click here" button labels
- blank empty states with no next action

## Design tokens per context

<!-- The scale, spacing base, neutrals, and accent for each recurring product. Obey the system; don't freelance. -->

- `[[product-name]]` — type scale, spacing base, neutral ramp, accent. Link the token file.

## Style-variant defaults

<!-- Which variant fits which context, so the soul doesn't pick brutalist on a banking app. -->

- **soft** — calm, premium, generous whitespace, spring motion. Default for consumer / marketing.
- **minimalist / editorial** — Linear/Notion register, type does the work. Default for tools / dashboards.
- **brutalist** — Swiss type, hard contrast, exposed grid. Only when the brand explicitly wants it.

## Decisions that held

<!-- Design calls that worked, abstracted into a portable principle. Promoted from memory by /reflector. -->

## Lessons

<!-- Portable rules abstracted from specific work. -->
