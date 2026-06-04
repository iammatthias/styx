---
name: stack
description: Squash-safe stacked PRs — record parent/child links, retarget children before a parent merges so they don't auto-close, rebase descendants after. Wraps the @kitlangton/stack CLI. Dry-run and confirm before any merge.
---

# /stack

Ship a chain of dependent PRs through a repo that squash-merges and deletes branches — the workflow that detonates naive stacking. Wraps the [`@kitlangton/stack`](https://github.com/kitlangton/stack) CLI: it tracks parent/child links in PR bodies, retargets children *before* the parent merges so branch deletion doesn't close them, then rebases the rest. Sibling to `/worktrees` (isolate a branch) and `/pr-review` (judge one).

## When to use

- Shipping several PRs where each builds on the last, and they need to merge in order.
- The repo **squash-merges and deletes the branch** — the case where children auto-close when a parent lands.
- A parent in a stack is ready to merge and the children need retargeting first.
- Picking up a stack mid-flight: you need to see its shape or repair links after manual changes.

## When NOT to use

- One independent PR. There's no stack — just open it.
- Isolating a branch for parallel or risky work → `/worktrees`.
- Judging the contents of a PR (cause, fix quality, risk) → `/pr-review`; prioritizing a queue → `/triage`.
- The repo uses merge-commit or rebase-merge **and keeps branches** — plain base-branch stacking already survives, so this buys you nothing.

## Preconditions

- **Tool check first.** `stack --version`. If missing: `npm install -g @kitlangton/stack`. The upstream tool also ships itself as an agent skill via `npx skills add kitlangton/stack --skill stack` — that's its own registration mechanism; this `/stack` is styx's in-repo pointer to the same procedure.
- **GitHub access.** Needs auth to the repo. Confirm you're on the intended repo and remote before any write — this is shared infra, so default to `guard`.
- **Don't invent flags.** Commands and flags drift upstream. `stack --help` and subcommand `--help` over memory, every time — same rule as `/wrangler`.
- **PR-body stack blocks are the source of truth**, not an external store. `stack sync` owns them; don't hand-edit.

## Workflow

```bash
stack status                 # locally-tracked stack, no API calls — orient first
stack sync --dry-run         # preview inferred links + repairs. Read this; it's the leash.
stack sync                   # record links, refresh PR bodies with stack blocks
stack merge --apply          # merge root PR: retargets children FIRST, then rebases descendants
```

1. **Orient** — `stack status` shows the chain without touching the API.
2. **Preview** — `stack sync --dry-run` shows what links it will infer (from PR bases) and what it will repair. Don't skip it.
3. **Sync** — `stack sync` records the relationships and writes the stack blocks. `stack sync <branch>` scopes to one branch; `--keep-going` processes independent stacks and reports failures instead of halting.
4. **Merge** — `stack merge --apply` on the root: it retargets children onto the merge base before deletion, then rebases/pushes the rest. `--auto` waits for GitHub checks; `--auto --through <branch-or-pr>` walks the chain merging each as it goes green.
5. **Repeat** — after a parent lands, re-run `stack sync` on what's left; the stack blocks update themselves.

**`careful` on merge.** `stack merge --apply` rewrites PR bases and deletes branches — irreversible. Dry-run, confirm, *then* `--apply`. There's an undo journal; treat it as a seatbelt, not a plan.

## Output

```
stack:    <root> → <child> → <grandchild>
action:   [status | sync --dry-run | sync | merge]
changed:  [links recorded / bases retargeted / branches rebased]
merged:   [PR #N squashed | none]
open:     [conflicts to resolve | next parent ready | clean]
```

## Refusals

- Never `stack merge --apply` without a dry-run and explicit confirmation — it deletes branches and rewrites bases.
- Never hand-edit the PR-body stack blocks. `stack sync` owns them; manual edits desync the tracking.
- Never invent flags. `--help` over memory — the command surface moves.
- Don't reach for this on a lone PR, or to isolate a branch (→ `/worktrees`).
- Don't operate on a repo or remote you haven't confirmed. Shared infra runs under `guard`.
