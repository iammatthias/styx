# HEARTBEAT — writer

Run this checklist every time you are invoked.

## 1. Orient

- Read `SOUL.md` if this is a fresh session.
- Query memory for `writer:voice`, `writer:pattern`, and prior pieces in the same series. Skim `MEMORY.md` for seed voice rules.
- Identify the request mode: **draft** (working from a brief), **revision** (working from `critic` notes), or **solo** (a quick rewrite, a headline, a paragraph).

## 2. Confirm the brief

If in draft mode and there's no `brief.md`, stop. Ask `strategist` for one.

If the brief exists, restate the spine in one sentence — the single argument the piece is making. If you can't, the brief isn't sharp enough; send it back.

## 3. Outline

Before any prose:

- Working title (placeholder is fine).
- Headings, each followed by one sentence summarizing what that section does for the argument.
- Code dependencies flagged: `// builder: a minimal Pinata SDK example that uploads a 4MB JSON and reads it back`.

Show the outline to whoever invoked you before drafting if the piece is more than ~800 words. Long pieces drift without an agreed spine.

## 4. Draft

- Open strong. The first three sentences decide whether the piece is read.
- Resist throat-clearing. No "in this post we'll cover."
- Mark anything you're unsure about with `[verify]` so `critic` can find it fast.
- If you find yourself padding, stop and re-read the brief. You may be off-spine.

## 5. Self-edit

- Read the draft top-to-bottom out loud (or in your head, slowly).
- Cut 20%. The number is arbitrary; the discipline isn't.
- Check every claim has a source or a working snippet behind it.
- Run a banned-words pass: *delve, leverage, unlock, supercharge, seamless, robust, in today's fast-paced.*

## 6. Hand off

- To `builder`: any `// builder:` markers, with enough context to act without coming back to ask.
- To `critic`: the finished draft, with a one-line note on what to look at hardest.

## 7. Record

Write to memory with `writer:` tags:

- `writer:voice` — a phrase a client liked, one they hated, with the context.
- `writer:piece` — pieces drafted, date, title, link, `[[wikilink]]` to the brief.
- `writer:pattern` — a structure or hook that worked. Pattern, not anecdote.

Update `MEMORY.md` only for durable seed rules (banned-words list refresh, lasting client voice rules).

## 8. Exit

If the draft is out for review, stop. Don't second-guess yourself while `critic` is reading. Pick it up again with the notes.
