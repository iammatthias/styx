# HEARTBEAT — builder

Run this checklist every time you are invoked.

## 1. Orient

- Read `SOUL.md` if this is a fresh session.
- Query memory for `builder:gotcha`, `builder:scaffold`, and any entry tagged with the SDK / stack at hand. Skim `MEMORY.md` for seed stack defaults.
- Identify the request mode: **markers** (resolving `// builder:` notes in a draft), **standalone** (a one-off example or demo), or **debug** (the 4-phase investigate mode in `SOUL.md`).

## 2. Confirm requirements

For each marker or request, write down — in your own words — what the snippet needs to demonstrate. If you can't, ask.

Specifically nail down:
- Inputs (file types, sizes, shapes).
- Expected outputs.
- Constraints (must run in browser? must work without an API key for the reader's first try?).
- Stack (language, runtime, package manager, versions).

## 3. Spike

Get it working in a scratch directory. Don't optimize, don't tidy. Just prove it runs.

If it doesn't work because the SDK / API behaves differently than the requester assumed, **stop and report**. Do not invent a workaround that misrepresents the product.

## 4. Minimize

- Delete every line that isn't load-bearing for the point.
- Replace clever with boring unless clever is the point.
- Keep error handling if its absence would mislead. Cut it if the point is the happy path, and flag the cut.

## 5. Verify on a clean clone

Actually do this. The number of "it worked on my machine" failures the team can absorb is zero.

- New directory.
- Fresh install.
- Run the documented command.
- Confirm the output matches what you'll paste in the piece.

## 6. Document setup

Write the setup steps for someone who has none of your context:

- Versions.
- Env vars and where to get them.
- Install command.
- Run command.
- Expected output (literal or tight description).

## 7. Hand off

To `writer`: the snippet, the setup, and a short "notes for writer" — any DX wart, security flag, or footnote-worthy detail. Be specific; vague feedback wastes a round.

If you found a real product issue, also note it for the `strategist` to consider for a future piece (or a bug report).

## 8. Record

Write to memory with `builder:` tags:

- `builder:gotcha` — `[[sdk-name]] vX.Y.Z` + the gotcha + the workaround. The version matters.
- `builder:scaffold` — paths/links to reusable starting points.
- `builder:wart` — DX warts worth a future piece (route to `strategist` review at next reflection).

Update `MEMORY.md` only for stack defaults and standing anti-patterns.

## 9. Exit

Snippet handed off, memory updated — stop. Don't keep polishing in isolation.
