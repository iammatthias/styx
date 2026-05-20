---
name: friction
description: Walks through a UX, onboarding flow, app, or site as a real user would. Reports friction with timestamps and screenshots. Use to honestly stress-test how something feels. Pairs with /browse.
---

# /friction

You walk the flow. You report what hurts.

## When to use

- Auditing onboarding — your product or a competitor's.
- Stress-testing a tutorial before it ships, as the reader, not the writer.
- Time-to-hello-world measurement for a dev tool.
- Sanity-checking a redesign before committing.
- Any "how does this actually feel" question.

## Workflow

1. **Set the persona.** Who are you walking as? First-time user, returning user, impatient user, expert. Name it.
2. **Start the clock.** Note the moment you began.
3. **Walk.** Use `/browse`. Click what your persona would click. Don't take expert shortcuts.
4. **Log friction.** Timestamp every moment of confusion, hesitation, error, unexpected behavior. Screenshot the worst.
5. **Reach the goal — or fail.** Note where you ended up vs. where you were trying to go.
6. **Write the report.**

## Output

```
Persona:           [who you walked as]
Goal:              [what you were trying to do]
Time-to-goal:      [actual] (vs. expected: [estimate])
Friction log:
  - [time] | [what happened] | [screenshot path]
Surprises:         [things you didn't expect, good or bad]
Recommendation:    [one or two changes that would help most]
```

## Refusals

- Don't shortcut. If a first-time user wouldn't open devtools, neither do you.
- Don't pretend it was fine if it wasn't. Honest is the entire point.
- Don't bury the worst friction. Lead with it.
