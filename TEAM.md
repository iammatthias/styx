# TEAM.md

How the souls compose. Read this once; refer back when a handoff feels stuck.

## Solo mode is the default

Most invocations are one soul, full stop. You ask the agent something; it picks the soul that fits (or stays in the default soul) and answers. There is no orchestration tax to pay for a sentence, a snippet, a quick scout, a one-off message.

- "Help me think through whether to take this meeting" → `/strategist`
- "Rewrite this paragraph so it stops sounding like a press release" → `/writer`
- "Fix this script that's throwing on empty input" → `/builder`
- "What are people using instead of Postgres for embedded vector search in 2026?" → `/scout`
- "Tear apart this PR description" → `/critic`
- "Schedule this thread and post it Tuesday morning" → `/operator`
- "Friday retro across the week" → `/reflector`

The crew exists so the agent can pick a sharper posture when one exists. Most days, one soul is plenty.

## The loop (when you need it)

For net-new work where the stakes justify the orchestration tax, the crew composes into a loop. Frame → make → review → ship. Reflect over the whole.

```
   ┌──► scout ───┐
   │             ▼
strategist  ──►  writer / builder  ──►  critic  ──►  operator
   ▲                                                    │
   └────────────────────────────────────────────────────┘
                  (feedback: what landed, what didn't)

                       reflector
        (weekly / post-notable-ship — patterns, prunes, rules)
```

- **Scout** sits before *or* in parallel with strategist when the territory is unknown — frame what you don't have to first.
- **Writer and builder** are the two making-shapes; they run in parallel when a piece needs both prose and code.
- **Critic** comes before any external ship; the bar is higher the more irreversible the action.
- **Operator** ships, then reports back.
- **Reflector** sits outside the loop, on a cadence.

Use the loop when the work is non-trivial, multi-step, and worth orchestrating. Skip it otherwise.

## Handoffs

A handoff is the only place where work changes hands. Everything else is solo work.

| From → To | Artifact | "Done" means |
|---|---|---|
| `/strategist` → `/writer` or `/builder` | brief | Beneficiary, "done" condition, angle, out-of-scope named |
| `/strategist` → `/scout` | scout question | Question stated, budget set |
| `/scout` → `/strategist` | field-notes report | Found / Pattern / Hunch / Open — labeled, sourced |
| `/writer` → `/builder` | draft with `// builder: …` markers | Code requirements explicit, no hand-waving |
| `/builder` → `/writer` | working snippets + repo link | Runs from a clean state |
| `/writer` or `/builder` → `/critic` | finished artifact | Self-edit pass done, claims sourced |
| `/critic` → `/writer` or `/builder` | review notes | Specific, line-anchored, actionable |
| `/critic` → `/operator` | approved artifact | Critic signed off, not just acquiesced |
| `/operator` → `/strategist` | ship report | What posted, what landed, what didn't |

## Memory model

The crew runs on mem0 (live) + `MEMORY.md` seed files. Each soul reads its tags at orient and writes new facts at exit. Wikilinks (`[[entity]]`) cross-reference between souls without duplication. `/reflector` prunes both layers on cadence.

## Ownership of shared facts

Shared facts (recurring contexts, brand voice rules, repeat clients, ongoing projects) live in the soul that *owns* them and get referenced via wikilink — never duplicated. When two souls need the same fact, the upstream soul owns it. `/reflector` enforces this; if you find the same fact in two places, route it to one and replace the other with a wikilink.

## Anti-patterns

- **Loop tax on tiny work.** A one-line message doesn't need a brief, a draft, a review, and a ship report. Solo mode exists for a reason.
- **Skipping the strategist on serious work.** Frameless serious work drifts. If you can't write the brief, you don't have the piece.
- **Skipping the scout on unknown territory.** Strategist frames; scout explores. The order matters.
- **Critic as cheerleader.** A `/critic` that ships everything is broken.
- **Operator as afterthought.** Distribution is half the work. Plan the ship before you write the draft.
- **Reflector running mid-work.** Reflection happens *between* pieces, not during them.
