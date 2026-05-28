---
name: worktrees
description: Isolates a branch in its own git worktree for parallel or risky work — detect existing isolation first, native tools before git, verify .gitignore, run baseline tests, clean up after.
---

# /worktrees

A worktree is a second working copy of the same repo on its own branch. It lets one task run without disturbing another — no stash juggling, no half-applied changes when you switch focus. The rule of order: detect existing isolation, then native tools, then git.

## When to use

- Running work in parallel (a subagent on one branch while you stay on another).
- A risky or long-lived branch you want quarantined from your main checkout.
- Reviewing a PR locally without clobbering your in-progress changes.

## When NOT to use

- You're already in a worktree or an isolated environment — don't nest. Step 0 catches this.
- A quick branch-and-commit on a clean tree. A plain `git checkout -b` is enough.
- The host gives you a native isolation primitive (an `EnterWorktree`/`/worktree` command, an ephemeral container) — use that instead; it handles cleanup for you.

## Workflow

**0. Detect existing isolation — always, first.**

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" && pwd -P)
```

If `GIT_DIR != GIT_COMMON` (and you're not in a submodule), you're already in a worktree — skip creation, just work. If they're equal, you're in a normal repo; get consent before adding one.

**1. Pick the directory.** Priority: an explicitly requested path → an existing `.worktrees/`/`worktrees/` → default `.worktrees/<branch>`. For a project-local dir, confirm it's ignored before creating anything:

```bash
git check-ignore -q .worktrees || echo ".worktrees/" >> .gitignore  # then commit
```

An un-ignored worktree dir pollutes every `git status` — fix it first.

**2. Create.**

```bash
git worktree add .worktrees/<branch> -b <branch>
cd .worktrees/<branch>
```

**3. Set up + baseline.** Install deps (`npm install` / `cargo build` / `pip install -r requirements.txt` / `go mod download`) and run the test suite *before* changing anything. If the baseline is already red, stop and report — don't build on a broken floor without explicit OK.

**4. Work, then clean up.** When the branch is merged or abandoned, remove the worktree — leaving them around is how you end up with twelve stale copies:

```bash
git worktree remove .worktrees/<branch>
git worktree prune
```

## Output

```
worktree: .worktrees/<branch>  (branch <branch>)
status:   [created | already isolated | removed]
baseline: [tests green | tests red — N failing | n/a]
gitignore: [.worktrees ignored | added + committed]
```

## Refusals

- Never nest worktrees. Run step 0 every time; if already isolated, don't create another.
- Never skip a native isolation tool to drive git by hand — the native one cleans up; manual git leaves litter.
- Never create a project-local worktree without confirming it's `.gitignore`d.
- Never build on a red baseline without explicit permission. Report it first.
- Leave the tree as you found it — remove worktrees when the work lands.
