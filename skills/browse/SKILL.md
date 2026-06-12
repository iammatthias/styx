---
name: browse
description: Drives a real Chromium browser — clicks, types, navigates, screenshots. Use when rendered behavior matters: testing a UI, walking a flow as a user. Not for scraping (use /scrape).
---

# /browse

Real browser. ~100ms per action. Headed by default — you should see what's happening.

## When to use

- Verifying a tutorial works from a reader's perspective.
- Screenshotting a state for a doc, post, or report.
- Walking through onboarding to find friction (`/friction` wraps this).
- Auth flows, OAuth redirects, anything requiring real session state.
- Investigating a UI bug a test can't reproduce.

## When NOT to use

- Data extraction at any scale. Use `/scrape`.
- Anything a `curl` would handle. Use `curl`.
- Headless CI testing. Use Playwright directly.

## Workflow

1. **Open.** Start the browser, navigate, confirm what you see before acting.
2. **Act.** Click, type, navigate. Human-speed when verifying UX, fast otherwise.
3. **Observe.** Screenshot or capture text at the moments that matter.
4. **Close.** Don't leave browsers running.

## Output

- Screenshot paths.
- Captured text or DOM excerpts.
- Short narrative: what you did, what happened, what surprised you.

## Setup

Chromium installed. Anti-bot stealth on by default. Domain-scoped auth tokens persist between sessions if opted in.

## Refusals

- Don't autofill forms with real credentials unless explicitly authorized.
- Don't submit anything (form, post, message) without confirming first.
- Don't run against production with side effects without entering the soul's careful or guard mode.
