---
name: research
description: Multi-source research into a cited report — claims, evidence, contradictions, confidence, gaps. Analyzes one link or synthesizes a question. Recalls memory before new work.
---

# /research

Not a search, not a scrape. You turn a question into a cited answer you'd stake a decision on — or turn one link into structured evidence instead of a wall of prose. Every claim traces to a source. What you couldn't verify, you say so.

## When to use

- An open question that needs synthesis across web, video, papers, and feeds — not one page.
- A link (article, video, podcast, repo, PDF) you want as structured claims/facts/quotes, not a summary.
- Anything downstream of a decision: you need confidence, gaps, and contradictions named, not vibes.
- Work another agent or a later session will continue — the report is the durable artifact.

## When NOT to use

- Fast, exploratory "go look and tell me what's there" → `/scout`. Scout maps; research proves.
- What people are *saying* / sentiment right now → `/pulse`.
- Just convert a file or URL to clean text → `/to-markdown`; just pull structured data off a page → `/scrape`.
- A recurring watch on a subject over time → `/watch` (standing-topic mode). Research is the bootstrap; watch keeps it current.

## Recall before you research

Research memory compounds. Before spending effort on new work:

1. Query memory for `research:*` on the topic and any `[[entities]]` it touches. A prior report with graded claims may already answer it, or answer half of it.
2. If coverage exists, cite the stored report and only research the delta. Don't re-run finished work.
3. Frame the question in one sentence and set a **scope ceiling** — a source count or a time-box. The ceiling is a stop, not a target: stop when the question is answered with enough confidence, even if the budget's unspent. For broad, vague, or high-stakes questions, `/plan` a preflight scope (angles, must-hit sources, out-of-bounds) *before* the expensive pass.

## Analyze mode — one source

When the input is a single link, extract; don't summarize. Pull structured evidence:

- **Claims** — each assertion, with who's asserting it and your confidence (`clear` / `likely` / `unknown`).
- **Facts** — verifiable statements, each with its locator.
- **Numbers** — quantitative data with units and an *as-of* date. A number without a date is a rumor.
- **Positions** — each named stakeholder → their stance.
- **Quotes** — verbatim, attributed, with a locator: `[source#t=mm:ss]` for audio/video, a section or heading for text.

Media is transcript-first: speaker-aware, timestamped. If a video has no spoken content, say so and stop — never invent dialogue to fill the packet. Fetch with `/to-markdown`, `/scrape`, or `/browse` as the surface demands.

## Research mode — an open question

1. **Gather.** Open several angles (who'd know, what's been written, the primary source, the contrarian). Prefer primary over secondary — trace a claim to the paper, spec, or repo and go there.
2. **Extract** each source into the analyze-mode schema above. Grade as you go.
3. **Cross-validate.** A claim from one source is a lead; confirmed by sources of *independent origin* it's a finding (see `/scout` — three pages tracing to one press release are one source). Contradictions get **surfaced, not averaged** — name both sides and which you trust, or mark it open.
4. **Name the holes.** Evidence that's paid, private, blocked, or registry-only is a stated limit, not a value to invent. "Couldn't verify X — behind a paywall" beats a confident guess.
5. **Synthesize.** Answer the question. Lead with the high-confidence answer; keep methodology, gaps, and contradictions as the audit layer beneath it.
6. **Verify the stakes.** High-stakes conclusion → `/codex` for a cross-model second read, or `/critic` before it ships.
7. **Record.** Store the report and its graded claims to memory under `research:<slug>`, `[[wikilinked]]` to the entities, so the next `/research` recalls it. Leave it `/handoff`-ready: open threads and sources gathered, so another session continues instead of restarting.

## Output

The report is the high-confidence answer surface; the notes below it are the audit surface.

```
Question:     [restated in one sentence]
Scope:        [sources read · angles · what was out of bounds]

Answer:       [the synthesized answer, lead with what's certain]

Evidence:
  - [claim] | confidence: clear|likely|unknown | [source#locator], [source#locator]
Contradictions:
  - [X per source A] vs [Y per source B] — [which you trust, or "open"]
Gaps:         [what couldn't be verified, and why — paywalled, private, blocked]
Next:         [source-backed next actions, or "answered"]
Sources:      [id — title — kind (article|video|podcast|paper|repo) — origin]
Recalled:     [prior research:<slug> reused, or "none"]
```

## Refusals

- Don't state a claim you can't trace to a source. If the proof isn't there, the claim doesn't ship.
- Don't invent a value for evidence that's paid, private, or blocked. Name the limit instead.
- Don't average contradicting sources into a mushy middle. Surface the disagreement and pick, or mark it open.
- Don't fabricate transcript content. No spoken words → a no-speech note, not invented dialogue.
- Don't re-run research that memory already holds. Recall first; research the delta.
- Don't report a bare summary and call it research. No structured evidence, no citations → it's a `/scrape`, not a report.
