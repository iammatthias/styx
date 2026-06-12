---
name: codex
description: Independent second opinion from the other model — Codex asks Claude Code, Claude Code asks Codex. Three modes: review, challenge, consultation. Use when stakes warrant a second judgment.
---

# /codex

Two models. Same prompt. Compare.

## When to use

- Before an irreversible decision.
- On code where a wrong call ships to users.
- On a piece you're proud of but suspicious of.
- When you and the primary model agree and you can't tell if that's signal or echo.

## When NOT to use

- When the stakes don't warrant a second model — a reversible, low-cost call. Just decide.
- To break a tie on a question you haven't sharpened yet → sharpen it first, then maybe ask.
- As a substitute for doing the thinking. A second opinion checks judgment; it doesn't replace it.

## Modes

**review** — pass/fail gate. Hand the artifact, ask "ship or not?", get a yes/no with reasons.

**challenge** — adversarial. "Find the strongest case against this." The second model plays critic, not collaborator.

**consultation** — open question. No artifact, just a hard question. Ask both, compare.

## Workflow

1. **Pick the mode.**
2. **Bundle context.** Subagents have no parent history. Pass the brief, the artifact, the question, the constraints — everything the second model needs to judge fairly.
3. **Invoke the other model** via `delegate_task` with the right system prompt (review / challenge / consultation). If `delegate_task` or the other model isn't reachable, say so and fall back to a single-model self-review pass in the chosen mode — label it as such so the user knows it's one model, not two.
4. **Compare.**
   - Overlap = high confidence. Both flagged X → X is real.
   - Divergence = a question to resolve, not a tiebreaker. Don't average.
   - Silence on a hard question = ambiguity. Sharpen the question.
5. **Return the comparison**, not just the verdict.

## Output

```
Mode:         [review | challenge | consultation]
Primary:      [model + verdict]
Second:       [model + verdict]
Overlap:      [what both said]
Divergence:   [what they disagreed on, with the strongest argument for each side]
Action:       [what to do with the result]
```

## Refusals

- Don't use `/codex` to break a tie when the question wasn't sharp. Sharpen first.
- Don't average. Two models saying "kinda" doesn't mean "yes" or "no."
- Don't skip context. A second opinion without the full picture is just a different first opinion.
