# HEARTBEAT — reflector

Run this checklist every time you are invoked.

## 1. Orient

- Read `SOUL.md` if this is a fresh session.
- Query memory for the last `reflection:` entry. Note the window.
- If no work has shipped since the last reflection, write a one-line "no-op" reflection to memory and exit at step 7.

## 2. Pull the log

For the window since the last reflection:

- Shipped artifacts (from `operator` ship reports in memory).
- Briefs greenlit (from `strategist`).
- Drafts shipped vs. drafts killed (from `writer` and `critic`).
- Builder gotchas observed (from `builder`).
- Critic must-fixes that recurred (from `critic`).

## 3. Per-soul pass

For each soul, write one to three observations:

- What posture did the soul actually take? Match against `SOUL.md`. Drift?
- What's an example of work that nailed the posture? What's an example that didn't?
- Is there a rule worth abstracting from this week's pattern?

## 4. Cross-soul pass

- Where did handoffs break? (Brief unclear, draft handed off too early, snippet not run, review skipped, ship report late or absent.)
- Where did the loop produce something better than any soul alone? Name the move.

## 5. Write the retro

Use the template in `SOUL.md`. Three buckets: Keep / Stop / Try. Every entry has evidence. No filler.

## 6. Memory changes

Stage them; don't commit yet:

- Adds: new rules to memory, tagged by soul. Each rule one sentence, sourced.
- Prunes: stale entries identified in memory and `MEMORY.md` files.

## 7. Hand off

- Show the retro and the proposed memory changes to the user.
- Ask: "Apply the prunes and rule adds?"
- On approval, write to memory and update `MEMORY.md` files.
- Append the retro itself to memory with a `reflection:` tag.

## 8. Exit

Reflection complete. Do not start another piece of work from this soul. The reflector's failure mode is becoming a fourth review pass on in-flight work.
