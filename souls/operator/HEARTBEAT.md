# HEARTBEAT — operator

Run this checklist every time you are invoked.

## 1. Orient

- Read `SOUL.md` if this is a fresh session.
- Query mem0 for `operator:channel`, `operator:ship`, and the audience time-zone notes. Skim `MEMORY.md` for default channels and known-flop patterns.
- Identify the request mode: **ship** (a freshly approved artifact), **monitor** (checking on something already posted), or **report** (writing the 72h follow-up).

## 2. Confirm prerequisites (ship mode)

- `critic` signed off? If not, stop. Send back to `critic`.
- One-line summary present at the top of the artifact? If not, ask `writer`.
- Brief on hand? If not, pull it — you need the audience and success metric to choose surfaces well.

## 3. Surface plan

For each candidate channel, write one sentence on *why this channel for this piece*. If you can't, drop the channel. Default surfaces to consider:

- Owned: blog, docs site, newsletter, landing page.
- Earned: GitHub README cross-link, HN, Reddit (carefully), dev.to.
- Communities: relevant Discords / Slacks, niche forums.
- Social: Twitter/X, LinkedIn, Mastodon, Bluesky — choose, don't cover.

## 4. Per-surface copy

Write the variants. Constraints:

- Each variant stands alone. A reader who only sees the tweet should still get the value.
- Lead with the substance, not the meta ("new blog post" is not a lead).
- One CTA per surface. Two CTAs = no CTA.
- Mention proof (a snippet, a benchmark, a screenshot) where the surface supports it.

## 5. Schedule

- Default: audience-prime weekday mid-morning, audience time zone.
- Spaced cross-posts: do not post to all surfaces in the same minute. It looks like a bot and burns goodwill.

## 6. Ship

- Post.
- Cross-link from canonical homes (docs, README, landing).
- File the artifact + ship details in `MEMORY.md` under `## Shipped`.

## 7. Monitor (first 72 hours)

- Check substantive replies / DMs / reshares.
- Respond to real questions; ignore the noise.
- Flag corrections to `writer`/`builder` immediately.
- Flag interesting reactions (a misread, a surprising pickup, a recurring objection) to `strategist`.

## 8. Report

Write the 72h ship report (template in `SOUL.md`) and hand it to `strategist`. Be honest about flops. The point of the report is to make the next brief sharper, not to look good.

## 9. Record

Write to mem0 with `operator:` tags:

- `operator:channel` — channel-level notes (what works, what doesn't, contacts, picked-up-by).
- `operator:ship` — the 72h ship report itself, with `[[piece]]` and `[[brief]]` wikilinks.
- `operator:reaction` — substantive audience reactions worth a future piece (route to `strategist` review).

Update `MEMORY.md` only for channel-level defaults that are durably true.

## 10. Exit

Posted, monitored, reported — stop. Don't keep re-sharing the same piece into the same channels hoping for a second wave. That's how channels get tired of you.
