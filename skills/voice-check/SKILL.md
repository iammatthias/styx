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

Reads the seed banned-phrases list in `souls/writer/MEMORY.md` (grouped by tell — marketing-ese, throat-clearing, emphasis crutches, jargon, filler adverbs, weak intensifiers, meta-commentary, vague declaratives, vague attribution, transitions/signposting, conclusion padding, sycophancy, inflate-by-negation) plus any live additions in memory under `writer:banned`. Then scans for those, and for the structural and formatting tells below:

- **Banned phrases** — the grouped list in `MEMORY.md` and whatever's current under `writer:banned`.
- **Structural clichés** — the sentence-shape tells AI prose reaches for:
  - *Binary contrast* — "Not because X. Because Y.", "The answer isn't X. It's Y." Telegraphs the conclusion before stating it.
  - *Inflate-by-negation* — "more than just X", "not just a refactor, a rethink." States significance by negating a strawman.
  - *"X is the Y of Z"* — "Cringe is the visible signature of moving along a gradient you chose." Forced analogy-as-definition; sounds profound, asserts nothing checkable.
  - *Punchline density* — every sentence landing as a quotable aphorism ("Symmetry becomes a trap.", "The Tiger fit the story."). One mic-drop is a flourish; a paragraph of them is a tell.
  - *Negative listing* — "Not a X. Not a Y. A Z." Drama by accumulated negation.
  - *Consecutive short sentences* — staccato runs of fragments for gravitas: "It had no preference for symmetry. No aesthetic prior. No instinct to preserve harmony." Vary the length or cut.
  - *Dramatic fragmentation* — "X. That's it.", "X. And Y. And Z." Fragments for fake emphasis.
  - *Setup-payoff restatement* — a full sentence then a fragment that just restates it: "The results were clear. Crystal clear."
  - *Rhetorical setup* — "What if [reframe]?", "Here's what I mean:", "Think about it:" Announcing an insight instead of delivering it.
  - *False agency* — "the data tells us", "a complaint becomes a fix", "the decision emerges." Inanimate things acting; hides who did it.
  - *Narrator-from-a-distance* — "Nobody designed this.", "People tend to…" Disembodied observation instead of a scene.
  - *Rule-of-three rhythm* — three-item lists and "Not always. Not perfectly." as a reflex.
  - *Both-sides balance* — "While X has its merits, Y also offers…" Equal weight to every tradeoff to avoid taking a position.
- **Sentence starters** — Wh- openers ("What makes this hard is…"), "So" / "Look," paragraph starts, and participle (`-ing`) openers used on repeat ("Leveraging X to…", "Diving into…", "Understanding the tradeoffs…").
- **Formatting tells** — the skimmable-content mimicry:
  - *Bold-phrase-colon* — "**Key takeaway:** …" applied mechanically as a summary device.
  - *Title-Case Headers* — capitalizing every word where sentence case reads more naturally.
  - *Emoji section markers* — 🚀 / 💡 as header prefixes or decorative bullets, especially in technical writing.
  - *Over-signposting* — "First… Next… Finally…" roadmaps on a piece the headings already map.
  - *Empty conclusion* — a wrap-up paragraph that restates the obvious and says nothing new.
- **Em-dash overuse** — more than ~2 per 500 words.
- **Passive voice in main clauses** — "the X was Y'd" when "X Y'd Z" is available.
- **Hedge density** — too many *might / could / perhaps / arguably / quite / somewhat* in one paragraph; soft verbs ("can be", "tends to", "often") stacking up.

## Output

```
hits:
  - line 14: "delve into" — banned phrase (marketing-ese)
  - line 19: "The answer isn't speed. It's trust." — structural cliché (binary contrast)
  - line 23: em-dash count 4 in this paragraph
  - line 31: "Leveraging X to ship Y…" — participle opener (3rd this section)
  - line 38: "**Key takeaway:**" — formatting tell (bold-phrase-colon)
  - line 47: "It's important to note" — throat-clearing
  - line 58: passive ("the function was called") — prefer active
  - line 71: hedge density (4 hedges in one paragraph)

severity: [low | medium | high]
```

Severity is **high** if any banned phrase is present, **medium** if structural clichés, formatting tells, em-dash overuse, or passive voice show up in three or more places, **low** otherwise.

## Refusals

- Don't be a thesaurus. Name the hit; don't propose the fix. `/writer` fixes.
- Don't grade voice — that's `/critic`. Surface only the mechanical hits.
- Don't auto-edit. Surfacing is the deliverable.
