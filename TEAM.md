# TEAM.md

How the five souls compose. Read this once; refer back when a handoff feels stuck.

## The loop

```
        strategist  ──►  writer  ──►  builder  ──►  critic  ──►  operator
            ▲                                                        │
            └────────────────────────────────────────────────────────┘
                         (feedback: what shipped, what landed)
```

Five stations. Each soul knows its station and the one downstream of it.

## Stations

**Think — `strategist`**
Frames the work. Answers: who is this for, why does it matter now, what does winning look like, what are we *not* doing. Outputs a one-page brief.

**Plan / Build — `writer`**
Turns the brief into an outline, then a draft. Owns voice and structure. Pulls the `builder` in when the draft needs working code or a real demo to be honest.

**Build — `builder`**
Writes the code that proves the words. Treats every snippet as something a stranger will paste into a terminal. If the snippet doesn't run, the draft doesn't ship.

**Review — `critic`**
Reads the draft and the code with cold eyes. Checks facts, voice, brand fit, and whether the piece earns its claims. Sends it back to `writer`/`builder` until it does.

**Ship — `operator`**
Pushes the artifact to its homes — blog, docs site, social, newsletter, community channels. Watches what lands and what doesn't. Reports back to `strategist` so the next brief is sharper.

## Handoffs

A handoff is the only place where work changes hands. Everything else is solo work.

| From → To | Artifact | "Done" means |
|---|---|---|
| `strategist` → `writer` | `brief.md` | Audience, goal, angle, success metric named |
| `writer` → `builder` | draft with `// builder: ...` markers | Code requirements explicit, no hand-waving |
| `builder` → `writer` | working snippets + repo link | Snippets run from a clean clone |
| `writer` → `critic` | finished draft | Self-edit pass done, claims footnoted |
| `critic` → `writer`/`builder` | review notes | Specific, line-anchored, actionable |
| `critic` → `operator` | approved artifact | Critic signed off, not just acquiesced |
| `operator` → `strategist` | ship report | What posted, what landed, what didn't |

## Solo mode

Most days you don't run the loop. You invoke one soul.

- "Draft a positioning angle for X" → `strategist`
- "Turn this transcript into a blog post" → `writer`
- "Make a clean Pinata SDK example for Y" → `builder`
- "Tear apart this draft" → `critic`
- "Schedule this thread and find the right hashtags" → `operator`

Solo mode is the default. The loop is for net-new pieces where the stakes justify the orchestration tax.

## Anti-patterns

- **One soul doing two jobs.** If `writer` is also fact-checking itself, the piece is under-reviewed. Hand off.
- **Skipping the strategist.** Briefless work drifts. If you can't write the brief, you don't have the piece yet.
- **Critic as cheerleader.** A `critic` that ships everything is broken. Replace or retune.
- **Operator as afterthought.** Distribution is half the work. Plan the ship before you write the draft.

## Memory

Each soul keeps its own `MEMORY.md`. Shared facts (audience profiles, brand voice, repeat clients, ongoing campaigns) live in the soul that owns them and get referenced — never duplicated. When two souls need the same fact, the upstream soul owns it.
