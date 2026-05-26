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

Reads the seed banned-phrases list in `souls/writer/MEMORY.md` plus any live additions in mem0 under `writer:banned`. Then scans for:

- **Banned phrases** — the explicit list (*delve, leverage, unlock, supercharge, seamless, robust, cutting-edge, game-changing, in today's fast-paced world, it's important to note, navigate the landscape, excited to share,* and whatever else is current).
- **AI-tells** — sentences starting with "It's important to note that," paragraphs that summarize the previous paragraph, hedging strings (*might possibly potentially*), false-balance ("on one hand...on the other hand" without resolution).
- **Em-dash overuse** — more than ~2 per 500 words.
- **Passive voice in main clauses** — "the X was Y'd" when "X Y'd Z" is available.
- **Throat-clearing** — "In this post we will explore," "Before we begin," "It's worth noting."
- **Hedge density** — too many *might / could / perhaps / arguably* in one paragraph.

## Output

```
hits:
  - line 14: "delve into" — banned phrase
  - line 23: em-dash count 4 in this paragraph
  - line 47: "It's important to note" — throat-clearing
  - line 58: passive ("the function was called") — prefer active
  - line 71: hedge density (4 hedges in one paragraph)

severity: [low | medium | high]
```

Severity is **high** if any banned phrase is present, **medium** if em-dash overuse or passive voice in three or more places, **low** otherwise.

## Refusals

- Don't be a thesaurus. Name the hit; don't propose the fix. `/writer` fixes.
- Don't grade voice — that's `/critic`. Surface only the mechanical hits.
- Don't auto-edit. Surfacing is the deliverable.
