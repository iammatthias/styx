---
name: to-markdown
description: Converts any file or URL to markdown — PDF, Office, HTML, audio, images, YouTube — via markitdown, plus yt-dlp for transcripts. Use to ingest a document or talk into the workflow.
---

# /to-markdown

Turn a file or URL into clean markdown so the rest of the crew can work with it. `/scrape` pulls structured data off the live web; this ingests a *document* — a PDF, a deck, a recording, a talk — into text `/scout`, `/writer`, or `/critic` can actually read.

## When to use

- A PDF, Word doc, slide deck, or spreadsheet you need as text.
- A YouTube or other video you want the transcript of.
- An audio file to transcribe, or an image to OCR.
- Anything you'd otherwise copy-paste by hand out of a binary format.

## When NOT to use

- Structured data off a live web page → `/scrape`.
- A page you need to interact with (login, click) → `/browse`.
- A single value or a quick fact → just fetch it.

## Files and most URLs — markitdown

`uvx markitdown` needs no install and handles PDF, Word, PowerPoint, Excel, HTML, CSV/JSON/XML, EPub, ZIP (iterates contents), images (EXIF + OCR), audio (EXIF + transcription), and YouTube URLs.

```bash
uvx markitdown input.pdf -o output.md
uvx markitdown deck.pptx > deck.md
cat document | uvx markitdown -x .pdf > output.md     # stdin needs a type hint
uvx markitdown scan.pdf -d -e "<azure-doc-intelligence-endpoint>"   # better OCR on hard PDFs
```

Output preserves structure: headings, tables, lists, links.

## Video transcripts — yt-dlp

When you specifically want a video's transcript and markitdown's path falls short, pull subtitles and clean them:

```bash
yt-dlp --write-auto-subs --sub-lang en --skip-download -o '%(title)s.%(ext)s' '<url>'
# then strip cue timestamps and [Music]-style brackets into a paragraph
```

Default to a clean paragraph; keep timestamps only when asked. Needs `yt-dlp` (and `ffmpeg` for some formats).

## Output

The markdown itself, plus one line: source, format, and anything lossy (a scanned table that didn't survive, a diagram that became alt text).

## Refusals

- Don't silently swallow extraction loss. If a PDF's tables came out garbled, say so and suggest the `-d` Azure path.
- Don't download full video when the user only wanted the transcript.
- Don't convert paywalled or access-controlled content you aren't authorized to pull.
- Don't dump a 200-page conversion into chat. Save to a file and report the path.
