---
name: cli-design
description: Specs a command-line tool's UX before it's built — commands, flags, help, output, exit codes, config, dry-run. Human-first, script-friendly, language-agnostic. /builder invokes it.
---

# /cli-design

Design the interface before the implementation. A CLI is a contract — syntax, behavior, safety — and getting it right on paper is cheaper than refactoring flags after people depend on them. This is the `/layers` of command-line tools: `/builder` runs it before writing code.

## When to use

- Starting a new CLI or subcommand and you want the surface right the first time.
- A tool's flags have grown organically and need a coherent redesign.
- Before `/builder` implements anything with a command-line interface.

## When NOT to use

- Implementing a CLI whose interface is already settled → `/builder`.
- A GUI or web interface → `/designer`.
- "Design the parameters" — then don't drift into implementation. Spec only.

## Clarify (fast)

Ask only what you need to lock the interface, then proceed on best-guess defaults:

- Command name + one-sentence purpose.
- Primary user: humans, scripts, or both.
- Inputs: args vs stdin; files vs URLs. Secrets never via flags.
- Output: human text, `--json`, `--plain`, exit codes.
- Interactivity: prompts allowed? need `--no-input`? confirm destructive ops?
- Config: flags / env / file; precedence; XDG vs repo-local.
- Platform: macOS/Linux/Windows; single binary vs runtime.

## Default conventions

Apply [clig.dev](https://clig.dev) as the rubric unless the user says otherwise:

- `-h/--help` always shows help and ignores other args; `--version` prints to stdout.
- Primary data to stdout, diagnostics to stderr.
- `--json` for machine output; `--plain` for stable line-based text.
- Prompts only when stdin is a TTY; `--no-input` disables them.
- Destructive ops: interactive confirm, and `--force`/`--confirm` for non-interactive.
- Respect `NO_COLOR` and `TERM=dumb`; offer `--no-color`.
- Ctrl-C exits fast with bounded cleanup; be crash-only where you can.

## Output

A compact spec the user can implement:

```
Name:      mycmd
One-liner: ...
Usage:     mycmd [global flags] <subcommand> [args]

Subcommands:  what each does, idempotence, state changes
Flags:        table — type, default, required?, example
I/O:          stdout vs stderr, TTY detection, --json/--plain, --quiet/--verbose
Exit codes:   0 ok · 1 generic · 2 invalid usage · (command-specific only if useful)
Config/env:   vars, file path, precedence (flags > env > project > user > system)
Safety:       --dry-run, confirmations, --force, --no-input
Examples:     5–10 invocations, including piped/stdin flows
```

## Refusals

- Don't prescribe a parsing library or language unless asked. Keep the spec portable.
- Don't drift into implementation when the task is the interface.
- Don't accept secrets via flags. Route them through env or stdin in the spec.
- Don't invent exit codes for their own sake. Add command-specific codes only when they earn it.
