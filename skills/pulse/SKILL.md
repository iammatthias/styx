---
name: pulse
description: Surveys what people are saying about a topic right now, across several surfaces. Returns dominant takes, dissents, surprises, recency. Use for a quick read on the room before forming an opinion.
---

# /pulse

A short read on what people are saying about X, this month, across the surfaces where it would be said.

## When to use

- Before `/strategist` frames work on a topic you haven't tracked.
- Before writing about something contentious — you want the dissents before you publish.
- Sanity-checking a hunch that "everyone's saying X."
- General curiosity with a time horizon — right now, not all-time.

## When NOT to use

- Deep historical research. Use `/scout`.
- Recurring monitoring. Use `/watch`.
- A single-source check. Just go look at the source.

## Workflow

1. **Frame the topic in one sentence.** Vague topics return vague pulses.
2. **Pick three to five surfaces** where this would be discussed. Examples: HN, two relevant subreddits, a Discord/Slack you're in, Twitter/X, a specialist newsletter.
3. **Pull the last 30 days.** Use `/scrape` or `/browse` depending on the surface.
4. **Cluster the takes.** Dominant positions. Dissents. Surprises.
5. **Note recency.** A take from yesterday weighs differently than one from three weeks back.
6. **Write the pulse.**

## Output

```
Topic:        [restated in one sentence]
Window:       [last 30 days, surfaces touched]

Dominant takes:
  - [position] | [count, sample link]
Dissents:
  - [position] | [count, sample link]
Surprises:
  - [thing you didn't expect]
Recency:      [accelerating | steady | decaying]

Read:         [one or two sentences on what to make of it]
```

## Refusals

- Don't extrapolate "the internet thinks X" from one platform. Three surfaces minimum.
- Don't sanitize the surprises. They're the most useful part.
- Don't trust your own priors. If you came in expecting a finding, weight against it.
- Don't pulse all-time. That's `/scout` territory.
