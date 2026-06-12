---
name: skill-cleaner
description: Audits the styx skill/soul library — budget, dupes, orphans, drift, runtime fit, host overlap. Returns a punch list. Use when metadata feels heavy, before adding a skill, or to prune for a runtime.
---

# /skill-cleaner

Every `SKILL.md` description sits in Hermes's Level-0 metadata — always loaded, every session, before anything is chosen. The bodies load on demand; the descriptions never unload. This skill keeps that always-on list tight and honest.

## When to use

- The skills/souls metadata feels heavy and you want to know where the budget went.
- Before adding a skill — check it doesn't duplicate one that exists.
- After a burst of additions (a PR that dropped several skills at once).
- Periodically, as part of `/reflector`'s pruning pass.
- Loading styx into a runtime or host that ships its own skills — find what can't run here and what's redundant before it costs metadata.

## When NOT to use

- Writing a *new* skill from a one-off → `/skillify`.
- Judging whether a skill's *procedure* is good → that's a read, not an audit.
- Pruning *souls* for going quiet → `/reflector` owns soul lifecycle; this only audits their frontmatter cost.

## What it checks

- **Description budget.** Every description is always-loaded metadata. The `_template` caps it at ~200 chars (~50 tokens). Anything over is pure prompt tax across every session.
- **Duplicates.** Same `name`, or near-identical description/body, across `skills/` and `souls/`. Deliberate analogs (`/taste`↔`/voice-check`) are not duplicates — they name the analogy and split by domain.
- **Orphans.** A skill nothing references — not in the README tables, not in `TEAM.md`, not cross-linked from another skill or soul. Either wire it in or cut it.
- **Name/dir drift.** Frontmatter `name` must match the directory, or Hermes's `/<name>` invocation breaks.
- **Spec conformance.** Frontmatter follows the [Agent Skills spec](https://github.com/anthropics/skills) (agentskills.io): `name` and `description` both present and non-empty; `name` lowercase with hyphens (no spaces, no caps, matching the dir). A skill missing `description` is invisible to discovery; a malformed `name` doesn't route. Flag any frontmatter that wouldn't load under a strict host parser.
- **Runtime fit.** A skill whose tools aren't available in the current runtime is dead weight — it loads into Level-0 metadata, routes a request, then fails. `/browse` needs Chromium, `/domains` and `/wrangler` need Cloudflare creds, `/image-gen` needs an image API, `/to-markdown` needs markitdown + yt-dlp. Flag the ones *this* runtime can't actually run.
- **Host overlap.** When styx loads into a host that ships its own commands (Claude Code, etc.), a styx skill that duplicates a native one is two routes for one job. Name the overlap and which to prefer — the host's version may be better or worse, so this is a flag, not a cut.
- **Trigger nouns.** A description earns its budget by carrying the nouns an agent routes on: the tool, the action, the object, the when. Compaction trims grammar, never trigger nouns.

## Workflow

1. **Measure the budget.** Longest descriptions first:

   ```bash
   for f in skills/*/SKILL.md souls/*/SKILL.md; do
     desc=$(sed -n 's/^description: *//p' "$f" | head -1)
     printf '%4d  %s\n' "${#desc}" "$f"
   done | sort -rn
   ```

   Anything over ~200 is a compaction candidate.

2. **Check name/dir drift + spec conformance.**

   ```bash
   for f in skills/*/SKILL.md souls/*/SKILL.md; do
     dir=$(basename "$(dirname "$f")")
     name=$(sed -n 's/^name: *//p' "$f" | head -1)
     desc=$(sed -n 's/^description: *//p' "$f" | head -1)
     [ "$dir" != "$name" ] && echo "DRIFT: $f (name=$name dir=$dir)"
     [ -z "$desc" ] && echo "SPEC: $f missing description — invisible to discovery"
     printf '%s' "$name" | grep -Eq '^[a-z0-9-]+$' || echo "SPEC: $f name '$name' not lowercase-hyphen — won't route"
   done
   ```

   `_template` rows are placeholders, not shipped skills — they'll show as drift and as budget here and in steps 1 and 3. Ignore them.

3. **Find orphans.** Count references to each `/<name>` outside its own folder:

   ```bash
   for d in skills/*/ souls/*/; do
     name=$(basename "$d")
     n=$(grep -rl "/$name\b" --include='*.md' . | grep -v "/$name/" | wc -l)
     printf '%2d refs  /%s\n' "$n" "$name"
   done | sort -n
   ```

   Zero refs = orphan. Wire it into a README table and its callers, or cut it.

4. **Eyeball duplicates.** Skim the description list from step 1 for near-twins. Two skills that would route the same request are a merge candidate; confirm by reading both bodies before suggesting a merge.

5. **Check runtime fit** (only when auditing for a specific deployment). Tool needs live in two places: souls declare theirs in a `TOOLS.md`; skills declare theirs inline in the SKILL.md body (a "Setup" or "Tools" section — see `/browse`, `/document`, `/domains`). Surface both, then flag what the target runtime lacks:

   ```bash
   # soul tool declarations
   for f in souls/*/TOOLS.md; do
     printf '== soul %s ==\n' "$(basename "$(dirname "$f")")"; sed -n '1,20p' "$f"
   done
   # skill tool/dependency mentions in the body
   grep -rniE 'chromium|playwright|cloudflare|wrangler|api key|pandoc|markitdown|yt-dlp|python-docx|openpyxl|requires|needs ' \
     skills/*/SKILL.md
   ```

   A skill the runtime can't run is a prune candidate *for that deployment* — not a cut from the library.

6. **Check host overlap** (only when loading into a host with its own skills). List the host's native commands and flag styx skills that route the same job — e.g. `/pr-review` against a host's code-review command, `/codex` against a built-in second-opinion. Report the pair and which to prefer; the user owns the call.

7. **Compact the over-budget descriptions.** Relaxed grammar — drop articles, fold clauses, swap a full stop for a dash — until under cap. Keep every trigger noun. Keep the "use when" signal. Don't sand off the voice.

8. **Report. Don't auto-delete.** Hand back the punch list. Apply only what the user approves.

## Output

```
Library:        N skills, M souls
Level-0 budget: ~T tokens total in descriptions

Over budget (>200 chars):
  chars  skill            suggested trim
  275    /taste           [compacted line]
  ...
Duplicates:     [pairs, or "none — analogs are intentional"]
Orphans:        [skills with 0 external refs, or "none"]
Name/dir drift: [mismatches, or "none"]
Spec issues:    [missing description / malformed name, or "none"]
Runtime fit:    [skills the target runtime can't run, or "n/a — auditing the library itself"]
Host overlap:   [styx↔host duplicate pairs + which to prefer, or "none"]

Top fixes:
  1. [the change that saves the most budget / removes the most confusion]
  2. ...
```

## Refusals

- **Suggest first; edit only when asked.** A clean audit is the deliverable. Don't delete or rewrite on sight.
- Don't compact away trigger nouns to hit a char count. A tight description that no longer routes is worse than a long one that does.
- Don't flag deliberate analogs as duplicates. If a skill says "the X of Y," that's a designed pair, not redundancy.
- Don't prune a skill for being new. Orphan-because-just-added gets wired in, not cut.
- Runtime fit and host overlap are *deployment* calls, not library defects. Surface them and let the user decide what they run — never cut a skill from the library just because one runtime can't use it or a host happens to ship its own.
- When applying approved cleanup, make small grouped commits — descriptions, then merges, then deletes — never one churning blob.
