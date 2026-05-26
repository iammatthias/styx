---
name: image-gen
description: Generates or edits images via an image API (OpenAI Images or Gemini/Nano Banana). Draft → iterate → final, with prompt templates and edit-only discipline. For /designer and /writer visuals.
---

# /image-gen

Generate or edit images through whatever image API is configured — OpenAI Images (`gpt-image`) or Google's Gemini / Nano Banana. The discipline is the same regardless of model: iterate cheap, lock the prompt, then render final. `/designer` uses it for visuals; `/writer` for post and doc imagery.

## When to use

- A post, doc, or design needs an image and you'd otherwise hunt stock.
- Editing an existing image — restyle, add/remove an element, fix a background.
- Generating a small set of variations to pick from.

## When NOT to use

- Diagrams, charts, or anything that should be real vector/markup → build it, don't generate it.
- A precise UI mockup → `/designer` + `/refactor-ui`. Generators drift on exact layout.

## Setup

An API key in the environment (`OPENAI_API_KEY` or `GEMINI_API_KEY`) and whatever invocation your setup uses — a script, a CLI, or a direct API call. Pass the key via env, not on the command line where it lands in shell history.

## Workflow: draft → iterate → final

Don't burn time rendering 4K before the prompt is right.

1. **Draft** at low res (~1K) for a fast feedback loop.
2. **Iterate** — adjust the prompt in small diffs, one change at a time. When *editing*, keep the same input image every iteration until you're happy.
3. **Final** — render high res (2K/4K) only once the prompt is locked.

Map vague requests to resolution: no mention → 1K · "thumbnail/tiny" → 512 · "normal/medium" → 2K · "hi-res/ultra/4K" → 4K.

## Prompt templates

Generation — fill the slots:

> Create an image of: `<subject>`. Style: `<style>`. Composition: `<camera/shot>`. Lighting: `<lighting>`. Background: `<background>`. Color palette: `<palette>`. Avoid: `<list>`.

Editing — change one thing, preserve the rest:

> Change ONLY: `<single change>`. Keep identical: subject, composition/crop, pose, lighting, palette, background, text, and overall style. Do not add new objects. If text exists, keep it unchanged.

Pass the user's creative intent through as-is; only rework a prompt that's clearly insufficient.

## Filenames

`yyyy-mm-dd-hh-mm-ss-descriptive-name.png` — timestamp plus a 1–5 word lowercase hyphenated name from the prompt. Save to the working directory, not a skill folder.

## Output

The saved file path, the model and resolution used, and the final prompt. **Don't read the image back into context** — report the path and let the user look.

## Refusals

- Don't render 4K until the prompt is locked. Iterate at 1K.
- Don't change more than the user asked when editing. One diff at a time, everything else identical.
- Don't put the API key on the command line.
- Don't generate images of real, identifiable people in compromising or deceptive contexts.
