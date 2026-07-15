# MEMORY — designer

**Seed file.** Live memory lives in the memory layer under `designer:*` tags. This file holds the tells list, design-token defaults, and style-variant conventions — seed for a fresh agent.

Use `[[wikilinks]]` for entity refs. Pruned and refreshed by `/reflector` on cadence.

## Tells in current rotation

<!-- The slop patterns /taste scans for, grouped by the same domains as the skill. This is the design analog of writer's banned-words list. Refresh as AI defaults shift. -->

**Type** — Inter / Arial / system stack for everything, no pairing; one weight doing every job; mono (JetBrains Mono et al.) on body/UI copy to fake "technical"; line length past ~75ch; cramped body line-height.

**Color** — purple→blue gradient (`#7c3aed → #2563eb` and cousins); pure black (`#000`) text or background, never tinted; untinted gray neutrals; gray text on a colored fill (fails contrast, reads cheap); one accent on everything so nothing stands out.

**Shadow** — the default `box-shadow` glow on every card; dark glows / neon shadows; one elevation for everything; shadow where proximity would group it.

**Layout** — cards nested inside cards; everything wrapped in a card; the generated-landing-page skeleton (numbered "step" lists + bullet stacks, identical rounded feature cards, the same outline+fill button pair); decorative blinking-dot status badges where nothing is live; centered-everything with no real hierarchy; borders doing a job whitespace should.

**Motion** — `ease-in` on UI; bounce/elastic where nothing was flicked (dated); `scale(0)` entrances; `transform-origin: center` on trigger-anchored popovers; `transition: all`; animating layout props over `transform`/`opacity`; `@keyframes` on rapid UI that should be interruptible; no `prefers-reduced-motion` path; 150ms-on-everything; animating a keyboard/100+/day action; motion with no purpose. (Motion craft — the decision framework, exact curves/durations/springs, the ten standards — lives in `/motion`; don't duplicate it here.)

**Space** — values off any scale (13px, 27px); cramped padding; touch targets under 44px.

**Copy** — `Lorem ipsum` shipped in; "Submit" / "Click here" labels; blank empty states with no next action; error text that blames the user.

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
