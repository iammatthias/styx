---
name: cache-audit
description: Audits an LLM harness/SDK for prompt-caching bugs — volatile prefix, no cache_control, short TTL, missing provider key — fixes them, verifies cache hits on the wire. Use when cache_read is low.
---

# /cache-audit

Prompt caching is the cheapest 10x in agent infra, and most harnesses break it with one line. This finds the broken line, fixes it, and proves the cache hits on the wire.

## When to use

- A harness or SDK integration bills full price every turn — `cache_read` tokens stay near zero.
- You're adding caching to an LLM call and want it right the first time.
- A model or provider swap (Anthropic ↔ OpenAI ↔ Gemini ↔ Bedrock ↔ Mistral) quietly turned caching off.
- Before trusting a cost estimate that assumes caching works.

## When NOT to use

- A one-line fix you already understand → just make it. This is for diagnosing breakage you can't see.
- The workload has no reusable prefix (every prompt unique) → caching can't help; don't force it.
- Latency profiling or shrinking token counts → different problem. Caching is about cost on repeated prefixes.

## The four bugs

90% of broken caching reduces to one of these:

1. **Volatile prefix.** A value that changes every turn — a timestamp, a turn counter, a freshly-serialized tool list, a UUID — sits *above* the cache breakpoint. Every turn rewrites the prefix, so every turn misses. The most common bug by far; it's a copy-paste pattern that spread across several popular harnesses. Fix: move anything volatile *below* the last breakpoint, or freeze it for the session.

2. **No breakpoint at all.** Caching is opt-in on most providers and the integration never sets it: no `cache_control` (Anthropic/Bedrock), no cache key (OpenAI/Mistral), no cached-content handle (Gemini). Full price, silently. Fix: mark the largest stable prefix.

3. **Wrong TTL.** Anthropic defaults to a 5-minute TTL. Human-in-the-loop sessions — read code, think 10 minutes, type — miss the window, and the usual workaround (keepalive pings) bills for the pings *and* the rewrites. Fix: set `cache_control: {type: "ephemeral", ttl: "1h"}` once a session clears ~4 reads in the hour. (1h TTL ran behind a dated beta header historically; current Anthropic docs serve it on the standard endpoint — verify against current provider docs, these surfaces drift.)

4. **Misplaced or missing provider key.** Each provider caches differently, and a swap breaks the assumption. The block sizes and field names below are illustrative — verify against current provider docs, since these surfaces drift:
   - **Anthropic / Bedrock** — `cache_control: {type: "ephemeral"}`, up to 4 blocks, on the *trailing* block of each stable segment.
   - **OpenAI** — automatic over ~1024 tokens, but a stable `prompt_cache_key` pins routing; without it the hit rate is luck.
   - **Mistral** — its own cache key, same idea.
   - **Gemini** — explicit: create cached content, reference its handle. Almost nobody implements this by default.

## Breakpoint placement

Order matters. Cache most-stable-first: **tools → system → context/RAG → conversation history**, with the volatile tail (current message, live data) after the last breakpoint. One breakpoint at the boundary of each stable segment, never inside one. A breakpoint below a value that mutates is bug #1 wearing a hat.

## Workflow

1. **Find the call site.** Where the request is assembled — message array, system prompt, tools, headers.
2. **Trace the prefix top-down.** The first mutating value from the top is the cache ceiling. Everything stable above it is cacheable; if a mutator sits above a breakpoint, that's bug #1.
3. **Identify the provider path** and which of the four bugs apply. Watch for routing layers — an OpenAI-compatible proxy in front of Anthropic changes the rules.
4. **Propose the fix** — minimal diff at the call site. Don't refactor the harness; move the volatile block, add the breakpoint/key, set the TTL.
5. **Verify on the wire.** Non-negotiable — caching fails silently, so a code read is not proof. Capture the actual request/response and run the same prefix twice (or warm-up + real turn):
   - Anthropic / Bedrock: `usage.cache_creation_input_tokens` on call 1, `usage.cache_read_input_tokens` on call 2 covering the prefix.
   - OpenAI: `usage.prompt_tokens_details.cached_tokens > 0` on call 2.
   - Gemini: `usageMetadata.cachedContentTokenCount > 0`.
   - TTL fixes: wait past the old window (>5 min) before call 2 and confirm the read still lands.
6. **Score it.** Share of the prefix now cached vs. the theoretical max.

## Output

```
Target:       [harness/repo or call site]
Provider:     [anthropic | openai | gemini | bedrock | mistral | proxy → X]
Bugs found:
  volatile-prefix   [yes/no — the mutating value + where]
  no-breakpoint     [yes/no]
  wrong-ttl         [yes/no — current TTL, session shape]
  provider-key      [yes/no — what's missing]
Fix:          [the minimal change, per bug]
Wire proof:   [field + before/after token counts, or "not yet verified"]
Cached share: [~X% of prefix cached / theoretical max]
Verdict:      [fixed & proven | fix proposed, unverified | caching won't help here]
```

## Refusals

- **Don't claim it's fixed without wire proof.** `cache_read > 0` on the second call is the only evidence. "Should cache now" is not a result.
- Suggest the diff; apply it only when asked. Same contract as the other audits.
- Don't add caching to a workload with no reusable prefix. A cache that never hits is write-premium for nothing.
- Don't freeze a load-bearing volatile value (a per-turn timestamp the model actually needs) just to fake a stable prefix — move the breakpoint instead.
- Don't trust the SDK name for the provider. A litellm/proxy layer can route Anthropic calls through an OpenAI-shaped API; verify the actual wire format.
