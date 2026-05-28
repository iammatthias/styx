---
name: plan
description: Turns a multi-step change into bite-sized tasks — exact files, complete code, no placeholders — then executes with verification and hard stops. Use before non-trivial implementation work.
---

# /plan

A plan is a contract, not a sketch. If a task says "add validation" you don't have a plan, you have a wish. The test of a plan: a fresh agent with zero context could execute it without guessing once.

## When to use

- A change that touches more than two or three files, or spans more than one sitting.
- Work you want to hand to a subagent (`delegate_task`) or pick up in a future session.
- Anything where "I'll figure out the details as I go" has burned you before.

## When NOT to use

- A one-liner or a quick fix. The plan tax isn't worth it — `/builder` just does it.
- Framing whether the work is worth doing at all → `/strategist`.
- Deciding *what* to build when the concept is unsettled → `/layers` or `/strategist` first. Plan the how once the what is settled.

## Write mode

Save to `docs/plans/YYYY-MM-DD-<slug>.md` (or wherever the repo keeps plans). Header first, then numbered tasks.

**Header**
- **Goal** — one sentence on what "done" looks like.
- **Architecture** — the shape: what files, what talks to what.
- **Stack** — language, runtime, key deps, versions.

**Each task is one action, ~2–5 minutes.** A task that takes twenty minutes is three tasks. Every task carries:

- **Files** — exact paths to create, edit, or test.
- **Steps** — numbered, with *complete* code blocks. No `// TODO`, no "handle edge cases," no "similar to task 3."
- **Command** — the exact shell command to run, and the output you expect.
- **Done when** — the observable condition that closes the task (test passes, command exits 0, output matches).

Default to test-first where it fits: failing test → implement → passing test → commit, as separate tasks. Names must be consistent across tasks — a type or function referenced in task 7 must be defined, by that exact name, in an earlier task.

**Self-review before handing off:** scan for placeholders, undefined names, and tasks that secretly bundle three actions. Fix them. A plan with a `TBD` in it is not done.

## Execute mode

1. **Read the whole plan first, critically.** Surface any question *before* touching code. Implementation starts after the questions are answered, not before.
2. **One task at a time.** Mark in-progress, follow the steps exactly, run the verification command, confirm "done when," mark complete. Then the next.
3. **Stop on a blocker — don't guess.** A failing verification, an unclear step, a missing dependency, the same fix failing twice: stop and escalate. Three guesses deep is how plans rot into improvisation.
4. **Never work on `main`/`master` without explicit consent.** Branch first, or use `/worktrees` for isolation.
5. **Finish clean.** Last task is the merge/PR decision and any doc sync (`/document-release`).

## Output

```
plan: docs/plans/2026-05-28-<slug>.md
Goal:    [one sentence]
Tasks:   N  (each ~2–5 min, fully specified)
Mode:    [write — ready to execute] | [executing — task K/N]
Open:    [questions raised before/while executing, or "none"]
```

## Refusals

- Don't ship a plan with placeholders, `TBD`s, or "figure it out" steps. That's the one thing a plan exists to prevent.
- Don't write twenty-minute tasks. If you can't run it and verify it in a few minutes, split it.
- Don't keep executing past a blocker by guessing. Stop, name it, ask.
- Don't plan the trivial. A plan for a one-line fix is theater.
