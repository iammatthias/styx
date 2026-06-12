---
name: health
description: Snapshot of a codebase's quality — types, lint, tests, dead code, dependency health, docs. Returns 0-10 per dimension plus top fixes. Use when entering a new repo or before investing in one.
---

# /health

A two-minute read on a codebase before sinking hours into it.

## When to use

- New repo, yours or someone else's.
- Before agreeing to consult on a codebase.
- Before recommending a tool you haven't used recently.
- After a long absence from your own code.

## When NOT to use

- Auditing a UI rather than code → `/design-review`.
- Reviewing a specific diff for correctness → `/critic`.
- You can't run the checks (no clone, no creds) — get the repo first, don't score blind.

## What it checks

- **Types** — typechecker clean? Configured strictly?
- **Lint** — linter clean? Configured well?
- **Tests** — run? Pass? Cover the important paths?
- **Dead code** — obviously unused files, exports, dependencies?
- **Deps** — up to date? Known vulns? Abandoned upstream?
- **Docs** — README that tells you what this is? Is it true?
- **Build** — does it run from a clean clone?

## Workflow

1. Clone fresh or pull latest.
2. Run each dimension's check. Where there's no script, skim.
3. Score 0-10, and write a one-line rationale next to each score. Anchor it: 5 means "works but has real problems you'd hit soon," 8 means "solid, minor gaps." Don't grade-inflate.
4. Pick the three things that would move the score most.
5. Write the report.

## Output

```
Repo:        [path or URL]
Stack:       [language, framework, package manager]
Scores (0-10):
  types         X
  lint          X
  tests         X
  dead-code     X
  deps          X
  docs          X
  build         X
Overall:     [average]

Top three fixes:
  1. [thing]
  2. [thing]
  3. [thing]

Verdict:     [worth investing | fixable | abandon]
```

## Refusals

- Don't average for the headline if one dimension is a dealbreaker. 9s everywhere but 0 on tests isn't an 8.
- Don't be polite. The point is honest signal.
- Don't grade-inflate. A 7 should mean "good"; if everything ends up 7+, recalibrate.
