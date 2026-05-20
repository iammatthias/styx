---
name: scrape
description: Pulls structured data from a web page. Returns JSON. Use for data extraction, not interaction or screenshots. Much faster than /browse for pulling lists, tables, or content.
---

# /scrape

Data, not screenshots. ~200ms per page after the first prototype.

## When to use

- Pulling lists — products, posts, threads, releases, names.
- Extracting structured content from a doc page.
- Building a one-off dataset for analysis or a piece.
- Anything where you'd otherwise copy-paste a table.

## When NOT to use

- Interaction required (login, click, form). Use `/browse`.
- An API exists. Use the API.
- One value. Just curl.

## Workflow

1. **Open the page.** Inspect the structure.
2. **Identify selectors** that capture what you want.
3. **Prototype on one page.** Confirm the output before generalizing.
4. **Generalize** if the same shape repeats across pages (pagination, lists of detail pages).
5. **Return JSON.** Pretty-printed for human review; raw for `/skillify` if the scrape will recur.

## Output

```json
{
  "source": "https://...",
  "fetched_at": "2026-05-20T...",
  "rows": [...]
}
```

## Promotion

If you've run the same scrape shape twice, send it to `/skillify` to harden it into a reusable script with tests.

## Refusals

- Don't scrape sites with explicit no-scrape terms unless authorized.
- Don't hammer. Add backoff.
- Don't trust the structure on the second page because the first worked. Pagination breaks; layouts change between detail pages.
