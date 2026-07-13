---
name: persona
description: Builds a source-grounded corpus of a person's public writing and talks, then answers as an advisor lens in their documented worldview — cited, never impersonation. Use to consult a specific thinker.
---

# /persona

"What would Paul Graham say about this?" — answered from what he actually wrote, with citations, not from a vibe of him. A persona is a corpus plus a worldview sketch, not a costume. It advises through someone's documented lens; it never claims to *be* them.

## When to use

- You want a specific thinker's take on a decision — grounded in their real positions, not a guess.
- A recurring advisor you'll consult more than once (worth building the corpus once, reusing it).
- Pressure-testing an idea against a known worldview: "how would this land with someone who believes X?"

## When NOT to use

- A generic second opinion with no particular person attached → `/codex` (the other model) or `/critic`.
- A one-off "what do people think" → `/pulse`. A persona is one documented mind, not the room.
- Impersonating a private individual, or a public figure to deceive → refuse (see Refusals).

## Build the corpus

A persona is only as honest as its sources. Build it before consulting:

1. **Gather** the person's own public output — essays, talks, interviews, posts, papers. Their words, not write-ups *about* them. Fetch with `/scrape`, `/to-markdown`, `/browse`; a `/research` run is the fast way to assemble and grade the set.
2. **Extract**, per source, the same graded evidence `/research` uses: claims, positions, quotes verbatim with locators. Keep the citation handle on every quote.
3. **Sketch the worldview** from the corpus — the About below.
4. **Store** the corpus and sketch to memory under `persona:<slug>`, `[[wikilinked]]`. Note the corpus's date range and gaps — a worldview from 2015 isn't today's.

## The About sketch

Built from the corpus, cited, revised as sources are added. Six sections:

- **Recurring themes** — what they return to unprompted.
- **Beliefs and principles** — the load-bearing convictions, each with a source.
- **Predictions and future narratives** — where they think things are going.
- **Recurring questions** — what they keep asking, unresolved.
- **Tensions and contradictions** — where the corpus disagrees with itself. Don't smooth these over; they're the most honest part.
- **Unifying threads** — the throughline that connects the rest.

## Consulting

1. Retrieve the relevant slice of the corpus for the question — the positions and quotes that actually bear on it.
2. Answer in their register (cadence, diction, how they argue), grounded in what the corpus supports.
3. **Cite every substantive position** back to a source: `[persona:slug/source#locator]`. Voice is style; citations are the facts.
4. Where the corpus is silent or self-contradicting, say so — "he hasn't addressed this directly; nearest is…" beats a confident invention. An honest "unknown" is the whole value.

## Output

```
Persona:      [name] (advisor lens — corpus dated [range])
Question:     [restated]

Answer:       [in their register, grounded in the corpus]

Grounded in:
  - [position] — [persona:slug/source#locator]
Off-corpus:   [where the answer extrapolates beyond what they've said, flagged]
Gaps:         [what the corpus doesn't cover, or contradicts itself on]
```

## Refusals

- Don't impersonate. This is an advisor lens with citations, framed as such — not "I am [person]." A public person's profile is a reading of their work, not a literal voice.
- Don't build a persona of a private individual, or a public one for deception, fraud, or putting invented words in a real mouth.
- Don't cite what the corpus doesn't hold. A position with no source is your guess wearing their name — flag it off-corpus or cut it.
- Don't hide the corpus's limits. State its date range and gaps; a stale or thin corpus advises badly and the reader should know.
