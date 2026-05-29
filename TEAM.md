# TEAM.md

How the souls compose. Read this once; refer back when a handoff feels stuck.

## Solo mode is the default

Most invocations are one soul, full stop. You ask the agent something; it picks the soul that fits (or stays in the default soul) and answers. There is no orchestration tax to pay for a sentence, a snippet, a quick scout, a one-off message.

- "Help me think through whether to take this meeting" → `/strategist`
- "Rewrite this paragraph so it stops sounding like a press release" → `/writer`
- "Fix this script that's throwing on empty input" → `/builder`
- "Make this dashboard stop looking like every other AI-generated SaaS app" → `/designer`
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
strategist  ──►  writer / builder / designer  ──►  critic  ──►  operator
   ▲                                                              │
   └──────────────────────────────────────────────────────────────┘
                  (feedback: what landed, what didn't)

                       reflector
        (weekly / post-notable-ship — patterns, prunes, rules)
```

- **Scout** sits before *or* in parallel with strategist when the territory is unknown — frame what you don't have to first.
- **Writer, builder, and designer** are the making-shapes; they run in parallel when a piece needs prose, code, and a look. Designer runs `/layers` first if the surface isn't the real problem, which can bounce back to strategist.
- **Critic** comes before any external ship; the bar is higher the more irreversible the action.
- **Operator** ships, then reports back.
- **Reflector** sits outside the loop, on a cadence.

Use the loop when the work is non-trivial, multi-step, and worth orchestrating. Skip it otherwise.

## Composition patterns

The loop is the house default — a **pipeline** with a **producer-reviewer** pair bolted on (critic gates the ship) and a feedback edge. It's not the only shape. When the work doesn't fit the loop, reach for one of these and name it so everyone knows the shape:

| Pattern | Shape | Use when |
|---|---|---|
| **Pipeline** | `A → B → C` | Stages depend on the prior one. The loop's spine: strategist → maker → critic → operator. |
| **Fan-out / fan-in** | `in → {A, B, C} → synthesis` | One input needs several independent passes, then a merge. Three scouts on three sources; or writer + builder + designer on one piece, reconciled. |
| **Expert pool** | `router → {A \| B \| C}` | The input decides who handles it. The default soul *is* the router — it picks the crew member that fits and invokes only that one. |
| **Producer–reviewer** | `gen → check → (retry)` | Quality is gated by an objective bar. maker → critic → back to maker until it passes. Don't let the reviewer become a cheerleader. |
| **Supervisor** | `supervisor → {workers}` dynamic | Work volume is variable and assignment is decided at runtime. One soul holds state and dispatches batches — e.g. a large migration split across subagents. |
| **Hierarchical delegation** | `lead → sub-lead → workers` | The problem decomposes in tiers. A soul spawns subagents that spawn their own via `delegate_task`. Keep the tree shallow; depth costs context. |

Most work is **expert pool** (one soul) or **pipeline** (the loop). Fan-out and supervisor earn their orchestration tax only on genuinely parallel or variable-volume work — see the anti-patterns below before reaching for them.

**Checkpoint dispatched work so a restart doesn't redo it.** Any pattern that spawns children — supervisor, fan-out, hierarchical — should record each child's result as it lands, not just at the end. A `/plan` checklist is the natural ledger: one box per dispatched unit, ticked when that child's result is in hand and verified. A supervisor resumed mid-migration re-reads the ledger, skips the batches already checked, and dispatches only the rest — the same reason the executor trusts a checked box in [`/plan`](./skills/plan). Without this, a crashed supervisor re-runs every worker from the top, which on paid models or destructive migrations is the expensive kind of mistake.

## Handoffs

A handoff is the only place where work changes hands. Everything else is solo work.

| From → To | Artifact | "Done" means |
|---|---|---|
| `/strategist` → `/writer` or `/builder` | brief | Beneficiary, "done" condition, angle, out-of-scope named |
| `/strategist` → `/scout` | scout question | Question stated, budget set |
| `/scout` → `/strategist` | field-notes report | Found / Pattern / Hunch / Open — labeled, sourced |
| `/writer` → `/builder` | draft with `// builder: …` markers | Code requirements explicit, no hand-waving |
| `/builder` → `/writer` | working snippets + repo link | Runs from a clean state |
| `/strategist` → `/designer` | brief | Beneficiary, "done" condition, the surface to design |
| `/designer` → `/builder` | spec + tokens + changelog | Design settled, variant + dials stated |
| `/builder` → `/designer` | working but unstyled UI | Runs; ready for the look-and-feel pass |
| `/writer`, `/builder`, or `/designer` → `/critic` | finished artifact | Self-edit / `/design-review` done, claims sourced |
| `/critic` → `/writer` or `/builder` | review notes | Specific, line-anchored, actionable |
| `/critic` → `/operator` | approved artifact | Critic signed off, not just acquiesced |
| `/operator` → `/strategist` | ship report | What posted, what landed, what didn't |

## Memory model

The crew runs on memory (live) + `MEMORY.md` seed files. Each soul reads its tags at orient and writes new facts at exit. Wikilinks (`[[entity]]`) cross-reference between souls without duplication. `/reflector` prunes both layers on cadence.

## Ownership of shared facts

Shared facts (recurring contexts, brand voice rules, repeat clients, ongoing projects) live in the soul that *owns* them and get referenced via wikilink — never duplicated. When two souls need the same fact, the upstream soul owns it. `/reflector` enforces this; if you find the same fact in two places, route it to one and replace the other with a wikilink.

## Anti-patterns

- **Loop tax on tiny work.** A one-line message doesn't need a brief, a draft, a review, and a ship report. Solo mode exists for a reason.
- **Skipping the strategist on serious work.** Frameless serious work drifts. If you can't write the brief, you don't have the piece.
- **Skipping the scout on unknown territory.** Strategist frames; scout explores. The order matters.
- **Critic as cheerleader.** A `/critic` that ships everything is broken.
- **Operator as afterthought.** Distribution is half the work. Plan the ship before you write the draft.
- **Reflector running mid-work.** Reflection happens *between* pieces, not during them.
