---
name: voice-check
description: Fast pass over a draft for banned phrases, AI-tells, em-dash overuse, passive voice, throat-clearing. Returns a line-anchored hit list. Run before /critic or when a draft may have drifted from voice.
---

# /voice-check

Ten seconds before `/critic`. Catches the mechanical stuff so the smart review can focus.

## When to use

- Before sending a draft to `/critic`.
- After a long writing session when your eye has glazed.
- On anything that might have AI-tells (AI-edited, AI-generated, or just a long day).
- On copy from other people you're going to ship under your name.

## What it checks

Reads the seed banned-phrases list in `souls/writer/MEMORY.md` (grouped by tell — marketing-ese, throat-clearing, emphasis crutches, jargon, filler adverbs, meta-commentary, vague declaratives) plus any live additions in memory under `writer:banned`. Then scans for those, and for the structural tells below:

- **Banned phrases** — the grouped list in `MEMORY.md` and whatever's current under `writer:banned`.
- **Structural clichés** — the sentence-shape tells AI prose reaches for:
  - *Binary contrast* — "Not because X. Because Y.", "The answer isn't X. It's Y." Telegraphs the conclusion before stating it.
  - *Negative listing* — "Not a X. Not a Y. A Z." Drama by accumulated negation.
  - *Dramatic fragmentation* — "X. That's it.", "X. And Y. And Z." Fragments for fake emphasis.
  - *Rhetorical setup* — "What if [reframe]?", "Here's what I mean:", "Think about it:" Announcing an insight instead of delivering it.
  - *False agency* — "the data tells us", "a complaint becomes a fix", "the decision emerges." Inanimate things acting; hides who did it.
  - *Narrator-from-a-distance* — "Nobody designed this.", "People tend to…" Disembodied observation instead of a scene.
  - *Rule-of-three rhythm* — three-item lists and "Not always. Not perfectly." as a reflex.
- **Sentence starters** — Wh- openers ("What makes this hard is…"), "So" / "Look," paragraph starts.
- **Em-dash overuse** — more than ~2 per 500 words.
- **Passive voice in main clauses** — "the X was Y'd" when "X Y'd Z" is available.
- **Hedge density** — too many *might / could / perhaps / arguably* in one paragraph; also false-balance ("on one hand… on the other hand" with no resolution).

## Output

```
hits:
  - line 14: "delve into" — banned phrase (marketing-ese)
  - line 19: "The answer isn't speed. It's trust." — structural cliché (binary contrast)
  - line 23: em-dash count 4 in this paragraph
  - line 31: "What makes this hard is…" — Wh- opener
  - line 47: "It's important to note" — throat-clearing
  - line 58: passive ("the function was called") — prefer active
  - line 71: hedge density (4 hedges in one paragraph)

severity: [low | medium | high]
```

Severity is **high** if any banned phrase is present, **medium** if structural clichés, em-dash overuse, or passive voice show up in three or more places, **low** otherwise.

## Refusals

- Don't be a thesaurus. Name the hit; don't propose the fix. `/writer` fixes.
- Don't grade voice — that's `/critic`. Surface only the mechanical hits.
- Don't auto-edit. Surfacing is the deliverable.
