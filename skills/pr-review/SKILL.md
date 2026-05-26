---
name: pr-review
description: Deep review of a PR or issue — bug class, root cause + code path, regression provenance, fix quality, proof, residual risk. Reads code first. /critic invokes it for code work.
---

# /pr-review

Evidence-first, code-aware review. Not a summary — a judgment. Find the real cause, decide the best fix after reading enough code, and say "not proven" when the trail is weak. This is the structured procedure `/critic` runs on a PR or issue; `/codex` can second its verdict on high stakes.

## When to use

- A PR needs a real review, not a rubber stamp.
- An issue needs triage-grade understanding: is it real, is it already fixed, what's the cause?
- You're about to merge something and want the residual risk named out loud.

## When NOT to use

- Triaging a whole *queue* of issues/PRs → `/triage`.
- A non-code artifact (prose, a decision) → `/critic` directly.
- A quick "does this look right" → just read it.

## Pull the context

Use the GitHub MCP (this environment) or the `gh` CLI — not web browsing:

```bash
gh pr view <n> --json number,title,state,author,body,comments,reviews,files,commits,statusCheckRollup,mergeStateStatus,headRefName,url
gh pr diff <n> --patch
```

Then read the code, not just the diff:

```bash
git fetch origin && git log --oneline --decorate -20
rg "<key symbol / error / endpoint>"
```

Read repo-local instructions, test guidance, or maintainer runbooks before deciding.

## Review contract

Answer all of these, explicitly:

- **Ref / surface** — issue or PR number, affected area.
- **Bug** — what behavior is wrong or being changed?
- **Cause** — root cause with the code path, or what evidence is missing. Don't guess.
- **Provenance** (regressions) — who/what introduced it and when. Use `git log -S/-G`, `git blame`, linked PRs. Phrase as `introduced by` / `made visible by` / `carried forward by`, with confidence `clear`/`likely`/`unknown`. `N/A` for features.
- **Best fix** — is the proposed fix the best one *after reading adjacent code*?
- **Refactor** — would a bounded refactor make the invariant obvious and reduce future bugs? Or would it just widen risk?
- **Proof** — tests, live repro, CI, source, dependency docs.
- **Risk** — what stays unverified.

## Read past the first file

Follow the real call path: entrypoint → validation → routing → owner module → shared helper → persistence/network boundary. When behavior depends on a dependency, read its docs/source/types before assuming. Prefer current source and executable proof over stale issue comments and old CI.

## Fix quality bar

Good fixes live at the ownership boundary, preserve backward-compatible behavior unless retiring it is the point, add a regression test at the smallest meaningful seam, avoid special cases and hidden migrations in generic core, and update docs/changelog on user-visible change. Call out symptom-level fixes.

## Author trust (non-trivial PRs)

For an unfamiliar author, add a short trust line — it changes review *depth*, not correctness. Pull public signal with `gh api users/<login>` and `gh search prs --repo <owner/repo> --author <login> --state merged`. Don't record private contact details.

## Output

```
Ref:        #123 / PR #456
Surface:    [runtime / CLI / API / docs]
Bug:        [one or two sentences]
Cause:      [code path + confidence]
Provenance: [introduced/made-visible/carried-forward by commit/PR, or N/A]
Best fix:   [what should change and why]
Refactor:   [yes/no + the specific shape]
Proof:      [tests / live / CI / source]
Risk:       [remaining uncertainty]
```

For a PR with no blockers: say "no blocking correctness issues," list the strongest proof checked, name residual risk, and answer whether the design is the best available shape.

## Refusals

- Don't approve, comment, close, merge, or push unless the user asked for that action.
- Don't write vague "consider" notes. Findings need file/line/symbol and a concrete failure mode.
- Don't claim a root cause you can't trace. "Unknown, here's what's missing" beats a confident guess.
- Don't treat author trust as proof. It tunes depth, nothing else.
