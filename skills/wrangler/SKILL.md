---
name: wrangler
description: Cloudflare Wrangler ops — deploy Workers, tail logs, manage KV/R2/D1/Queues, secrets, bindings. Confirm the account before writes; never print secrets. Sibling to /domains.
---

# /wrangler

Cloudflare Wrangler work: deploys, tails, KV/R2/D1/Queues, secrets, bindings, account routing. `/domains` gets the name pointing at Cloudflare; `/wrangler` ships the code behind it.

## When to use

- Deploying or rolling back a Worker.
- Tailing live logs to debug a deployed Worker.
- Reading or writing KV / R2 / D1 / Queues.
- Setting a Worker secret or binding.

## When NOT to use

- Registering a domain or setting DNS → `/domains`.
- A general deploy that isn't Cloudflare → use that platform's CLI.

## Defaults

- **Retrieval first.** Don't invent flags from memory — Wrangler 4 removed/changed some. Confirm with `wrangler --help`, the subcommand `--help`, local `node_modules/wrangler/config-schema.json`, then Cloudflare docs.
- **Prefer the repo wrapper:** `npm exec --yes --package wrangler -- wrangler ...`, unless the repo has its own script.
- **`wrangler whoami` before any account-sensitive work.** Read `wrangler.toml` / `wrangler.json(c)` first; if the config account and the intended product disagree, stop and ask.

## Quick commands

```bash
npm exec --yes --package wrangler -- wrangler whoami
npm exec --yes --package wrangler -- wrangler deploy
npm exec --yes --package wrangler -- wrangler tail <worker> --format json --sampling-rate 0.999 --search '<term>'
npm exec --yes --package wrangler -- wrangler kv key list --namespace-id <id> --prefix '<prefix>'
npm exec --yes --package wrangler -- wrangler kv key get '<key>' --namespace-id <id>
```

## Pitfalls

- `wrangler kv key list` has no `--limit`; use `--prefix` and filter locally.
- Run KV/list/get reads **serially** when workerd/local storage is spinning up — parallel runs hit `SQLITE_BUSY`.
- `wrangler tail --sampling-rate` must be `>0` and `<1`; use `0.999` for near-full, never `1`.
- **Stop tails you start.** Kill the exact `wrangler tail <worker>` process; use a PTY when interactive stop matters.

## Output

```
Account:  [whoami result — confirmed against wrangler.toml]
Action:   [deploy | tail | kv read/write | secret]
Result:   [deployment URL / version / rows / log summary]
Open:     [anything left running, e.g. a tail to stop]
```

## Refusals

- Don't deploy to an account the repo config doesn't intend. Confirm `whoami` vs `wrangler.toml` first.
- Don't print or dump secrets. Query exact secret names; never dump the env.
- Don't invent flags. `--help` over memory, every time.
- Don't leave a `tail` running. Stop what you start.
