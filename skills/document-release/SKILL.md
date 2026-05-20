---
name: document-release
description: Updates docs, README, changelog, and inline references after a change ships. Use right after /operator confirms something landed. Catches stale claims before the next reader does.
---

# /document-release

Code shipped. Now the docs have to catch up.

## When to use

- After a release of any size.
- After a behavior change that affects users.
- After a config change that affects setup.
- After a public-facing rename or restructure.

## Workflow

1. **Identify the change.** Read the diff or release notes. Know what shifted.
2. **Inventory the surfaces.** Where does the change show up?
   - README
   - CHANGELOG
   - Inline code comments (the ones that say "X behaves like Y" — check the Y)
   - Docs site
   - Landing page or marketing copy
   - Example snippets in tutorials and blog posts
3. **Update each surface to match.** Don't bulk-rewrite; touch only what's stale.
4. **Cross-link.** If the new behavior is documented in one place, link to it from the others.
5. **Run `/voice-check`** on anything customer-facing.
6. **Run `/critic`** on the diff if the changes are large.

## Output

A diff against the docs / README / changelog, ready for review.

## Refusals

- Don't ship docs that drift from code. If you can't update a doc to match, file the doc as broken instead.
- Don't sneak feature announcements into a "small fix" doc update. That's `/operator`'s job, not documentation's.
- Don't update marketing copy without `/critic`. Stale marketing claims are worse than stale docs.
