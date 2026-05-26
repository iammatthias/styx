---
name: domains
description: Cloudflare domain ops — availability, pricing, registration, DNS zones, redirects, verify. Registration is billable; gated by the careful primitive. Use to check, buy, or wire up a domain.
---

# /domains

Check, buy, and wire up domains through Cloudflare. Registration spends money and isn't refundable, so the **careful** primitive governs anything that writes: confirm loud and explicit before a billable or destructive call.

## When to use

- Checking whether a domain is available and what it costs.
- Registering a domain (with confirmation).
- Pointing a domain at Cloudflare and setting up DNS or a redirect.
- Verifying that DNS and HTTPS actually resolve the way you intended.

## When NOT to use

- Deploying a Worker or app to Cloudflare → that's `wrangler`, a separate concern.
- A registrar that isn't Cloudflare → adapt the API calls; the guardrails still hold.

## Setup

Cloudflare API token + account ID, supplied however your environment does it (env vars, a CLI like `cli4`, `wrangler`, or an MCP). Export only the vars a single command needs; never print a token.

## Availability and pricing

Always check immediately before any registration:

```bash
curl -s -X POST "https://api.cloudflare.com/client/v4/accounts/$CF_ACCOUNT_ID/registrar/domain-check" \
  -H "Authorization: Bearer $CF_API_TOKEN" -H "Content-Type: application/json" \
  -d '{"domains":["example.com"]}'
```

## Register (careful: billable)

Stop and confirm with the user before this call. State the domain and the price.

```bash
curl -s -X POST "https://api.cloudflare.com/client/v4/accounts/$CF_ACCOUNT_ID/registrar/registrations" \
  -H "Authorization: Bearer $CF_API_TOKEN" -H "Content-Type: application/json" \
  -d '{"domain_name":"example.com","auto_renew":false,"privacy_mode":"redaction"}'
```

List what's registered with `GET /accounts/$CF_ACCOUNT_ID/registrar/registrations`.

## Wire it up (zone → DNS → redirect → verify)

1. **Routing model** — page rule (small, per-zone), bulk redirects (account-level, needs token perms), or a Worker route (fallback).
2. **Zone** — create it, confirm the nameservers Cloudflare assigns.
3. **Nameservers** — set them at the registrar. Confirm the registrar *first*; "invalid nameservers" is usually "wrong registrar."
4. **DNS** — proxied apex `A` + wildcard `A` (placeholder `192.0.2.1` lets Cloudflare terminate HTTPS), then the real records.
5. **Redirect** — page rule or Worker, per the routing model.
6. **Verify** — reversible steps, check after each: `dig +short example.com @1.1.1.1` (expect Cloudflare anycast), `curl -I https://example.com` (expect the `301`).

## Output

```
Domain:   example.com
Action:   [checked | registered | wired]
Cost:     [price, if registered]
DNS:      [records set]
Verify:   dig → [result] · curl → [status]
Open:     [anything left, e.g. nameserver propagation]
```

## Refusals

- Don't register without explicit confirmation. Billable and non-refundable — careful mode, always.
- Don't print or log API tokens.
- Don't change nameservers or delete records without naming exactly what changes and verifying after.
- Don't debug a Cloudflare "invalid nameservers" error before confirming which registrar actually holds the domain.
