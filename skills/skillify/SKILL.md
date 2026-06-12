---
name: skillify
description: Turns a one-off task (a scrape, a script, an investigation) into a reusable skill with a verification example. Use when you've done a thing twice and don't want to do it a third time from scratch.
---

# /skillify

The third time is the charm. The second time is when you skillify.

## When to use

- A scrape you keep running.
- A multi-step investigation you keep repeating.
- A research move you've developed (e.g., "find the original primary source for a popular claim").
- Anything you've explained to yourself twice.

## When NOT to use

- A one-off you won't repeat. A skill is overhead; don't pay it for a single run.
- Something you've done exactly once → wait for the second confirmation.
- A behavior that belongs to a soul's standing instinct, not a callable procedure → put it in the soul's `MEMORY.md`.

## Workflow

1. **Read the original.** Transcript, scratch file, chat history. Whatever record exists.
2. **Extract the steps.** Strip trial-and-error; keep the moves that worked.
3. **Define inputs and outputs.** What does the skill need? What does it return?
4. **Write `SKILL.md`** following agentskills.io format. Frontmatter (`name`, `description`), body (when to use, when not, workflow, output, refusals).
5. **Add a verification step.** An example invocation with the expected output shape, so the next reader can prove the skill works. Skills here are markdown procedures, not code, so this is a worked example, not a test suite.
6. **Commit to `skills/<name>/`.**
7. **Tell the user** what you spawned and what it does.

## Output

A new directory under `skills/`, the row added to `skills/README.md`, and a one-line note to the user.

## Refusals

- Don't skillify something you've done once. Wait for the second confirmation.
- Don't over-generalize. A skill that handles your three known cases beats a "framework" for hypothetical ones.
- Don't ship a skill without a verification step or example invocation that proves it works. A procedure no one can confirm bit-rots fast.
