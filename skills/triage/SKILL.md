---
name: triage
description: Maintainer triage of an issue/PR queue — per item: what, type, fit, risk, proof, author trust, blocker, next. Defaults to the current repo. Use to decide what to act on, in order.
---

# /triage

Turn a queue of issues and PRs into maintainer-facing cards: what each one is, why it matters, and the next action. Never return bare queue numbers — every surfaced item gets explained. `/pr-review` goes deep on a single item; `/triage` decides which items deserve that depth.

## When to use

- A repo's open issues/PRs have piled up and you need a prioritized read.
- Deciding what's safe to act on now vs. what needs judgment.
- A maintenance pass: what's mergeable, what's stale, what's blocked.

## When NOT to use

- Deep review of one PR/issue → `/pr-review`.
- General curiosity about a codebase → `/scout`.

## Scope

Default to **the current repo** when you're inside a Git checkout with a GitHub remote. Broaden to multiple repos/owners only when the user says "broad," "all," "everything," or names them.

Before working inside a local checkout, gate on a clean state:

```bash
git status --short --branch && git branch --show-current && git pull --ff-only
```

Proceed only on `main`, a clean worktree, and a successful pull. Otherwise stop and ask — don't switch branches, stash, or reset without direction.

## Pull the queue

Use whichever is present — GitHub MCP (this environment) or the `gh` CLI; they expose the same data, so map fields across. The `gh` form:

```bash
gh issue list --state open --limit 50 --json number,title,author,labels,createdAt,updatedAt,url
gh pr list --state open --limit 50 --json number,title,author,isDraft,reviewDecision,mergeStateStatus,statusCheckRollup,updatedAt,url
```

If neither is available, say so and triage from what the user pasted — don't invent a queue.

Read the latest comments first — the maintainer may have already steered an item. For ~10 items or fewer, inspect all; for larger queues, inspect the priority slice and say what you didn't expand. If the repo has a product/vision doc, read it before judging what's in scope.

## Evaluate each item

Classify and judge:

- **Type** — bug (needs repro + root cause) · feature (needs an e2e test plan; name missing keys/access) · dependency (major/minor risk, split?) · security (raise priority, demand code-path proof) · docs/internal (low risk, still note churn).
- **Fit** — good / mixed / poor, one reason.
- **Risk** — low / medium / high, with blast radius.
- **Proof** — current CI, local repro, failing test, live e2e, or missing.
- **Author trust** — for non-maintainer items: account age, repo + global activity, known/new/bot. Pull from `gh api users/<login>` and `gh search prs` (or the MCP equivalent). If neither is reachable, skip the signal rather than guess. Changes review depth, not correctness.
- **Blocker** — first-time-contributor CI approval, failing check, missing key, unclear direction, stale branch, conflicts, no repro.
- **Next** — the exact action: approve CI, run test, request repro, split, patch locally, merge after green, close with proof, or defer.

Prioritize: security/release/auth/data-loss > reproducible recent bugs > nearly-green low-risk PRs > everything else. Deprioritize archived/forks, old featureless requests, and broad generated diffs with no test plan.

## Output

```
Repo: owner/name
Source: gh list/view/diff, local source where inspected

Immediate:
- #123 PR: <one-line what>
  Type/Fit/Risk: bug · good · low because …
  Trust: @login; acct <date>; <repo/global activity>; known/new/bot
  Proof: <CI/repro/test/e2e>
  Blocker: <none / specifics>
  Next: <exact action>

Needs judgment:
- #124 issue: …

Defer/close:
- #125 issue: …

Skipped:
- <why>
```

## Refusals

- Don't comment, close, merge, rerun, or patch without strong evidence — or without the user asking.
- Don't return opaque queue numbers. Every surfaced item gets a card.
- Don't broaden scope past the current repo unless explicitly told to.
- Don't run destructive local git actions (reset, branch delete, checkout moves) without explicit direction.
