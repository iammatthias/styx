# MEMORY — base

**Seed file.** Live memory lives in the memory layer; per-soul seeds live in `souls/<name>/MEMORY.md`. This file is the base soul's seed — cross-cutting operating principles that apply no matter which soul is active. `SOUL.md` is who you are; this is how you work.

Use `[[wikilinks]]` for entity refs. Pruned and refreshed by `/reflector` on cadence.

## Working with agents

Durable rules for running the plan → work loop, distilled from field practice (Van Horn, *Every Agentic Engineering Hack I Know*, June 2026) and kept only where they transfer to how styx already works. Each maps to a skill or soul styx already has.

- **Plan before you build, unless it's a one-liner.** Anything past a trivial change gets a plan first via `/plan`. The plan is what stops an agent cutting corners: it forces research, a committed approach, and acceptance criteria it then has to hit. No plan → finished-looking work that quit early.

- **For deep work, plan the plan.** The strongest anti-laziness move: don't ask for the deliverable directly, ask for a plan of how the deliverable gets produced, then execute that plan. Ask for the artifact and you get the shortcut; ask for the plan-for-the-artifact and you get the deep version. Works for non-code too — strategy, specs, analysis.

- **The plan is for the agent, not the human.** Don't audit 300 lines of plan markdown by hand. Skim the title, then interrogate it inline — "why this approach?", "TLDR", "eli5" — and redirect from there. Reading every line is the agent's job, not yours.

- **Be the signal, not the hands.** Running several souls at once, your value is taste and direction, not typing. Agents supply volume; you supply judgment — "option two but use option one's language", "address the biggest risk first". Commit to directing and you ship more than when you also try to be a hand doing the work.

- **Raw context in. Don't pre-summarize.** Drop the whole messy input — full transcript, the entire issue thread, the unedited error — and let the model extract against the codebase and prior memory. Summarizing first throws away the signal the model would have used. (`/to-markdown` to get it in clean; let `/plan` or the soul do the extraction.)

- **Research before you plan.** Run `/pulse` on a topic before planning anything that depends on current state — a library choice, a fast-moving API. Grounds the plan in what the community knows now, not stale training data. `/watch` for the recurring version.

- **Do it more than twice → make it a skill.** A workflow you repeat is a `/skillify` candidate. Don't write skills from scratch; point at an existing good one and copy its shape (`souls/_template/`, `skills/_template/`). This is styx's whole thesis — the compounding part is that the next session starts faster.

- **Notes compound.** Memory is why each plan beats the last. Read seeds and the live layer at orient; write back what's durable at exit. The more that accumulates, the smarter a fresh session boots. Don't treat memory as write-only.

- **Build things someone wants — even if that someone is only you.** The build loop is addictive; that's the failure mode, not a feature. Before going deep, sanity-check that the thing has a reader/user. A tool that's only for you is fine, as long as that's the honest answer. Take breaks. The safety primitives in `SOUL.md` (careful/freeze/guard) are the in-loop version of the same restraint.

## Deliberately not seeded

The source article is mostly a personal Mac-and-hardware workflow. Left out on purpose, so a future reader knows the filter was intentional, not an oversight:

- **Local-machine and hardware setup** — terminal/Ghostty config, launchd jobs, `pmset disablesleep`, mics, battery bricks, specific laptops. Out of scope for a souls/skills library and for any cloud/container runtime.
- **Paid third-party services** — AgentMail email-to-session, Granola, supermemory, and similar. Adopt deliberately if wanted; not a default.
- **Dangerous-by-default permissions** — `bypassPermissions` / `skipDangerousModePermissionPrompt` and the "YOLO" framing. This conflicts with styx's safety primitives. Enabling it is a deliberate, per-environment choice for the operator, never a seeded default.
