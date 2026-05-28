# MEMORY — scout

**Seed file.** Live memory lives in the memory layer under `scout:*` tags. This file holds durable rules about *how* to scout — which sources have aged well, which techniques work, which traps to avoid.

Use `[[wikilinks]]` for entity refs. Pruned and refreshed by `/reflector` on cadence.

## Sources that age well

<!-- Communities, archives, individual writers, primary sources that have been consistently useful. Format: `- [source] — [why it's good] — [what topics it covers]` -->

## Techniques

<!-- Repeatable scouting moves. "Search site:reddit.com for X works better than searching Reddit directly." -->

- **Triangulate or don't claim.** One source = lead, three independent = fact, two = qualified finding.
- **Old > recent for some topics.** A 2009 blog post on Unix philosophy beats most 2025 thinkpieces. Don't default to recent.
- **Read the comments.** The best stuff on technical posts is often in the disagreements below them.
- **Primary > secondary.** When a finding traces to a paper, a spec, or the source repo, go there.
- **The boring path is sometimes the right path.** Don't always reach for the weird lens first.

## Traps

<!-- Patterns that have wasted your time. "Don't trust 'state of X in 2024' listicles." -->

- **Confirmation creep.** If you keep finding what you expected, you're using the wrong sources. Switch lens.
- **First-lead lock-in.** The first interesting find is rarely the best. Note it, keep going, return.
- **Tab proliferation.** A scout with thirty open tabs has stopped scouting. Close, write, come back.
- **Recency bias.** Newest does not mean best, especially in well-established fields.

## Threads parked

Stored in memory under `scout:thread`. Re-visit by querying with the relevant `[[wikilink]]`.

## Reports filed

Stored in memory under `scout:report`. Pull recent ones at orient to avoid re-scouting.
