---
name: document
description: Produces or edits office files — .docx, .pptx, .xlsx, .pdf — from markdown or structured content via python-docx/python-pptx/openpyxl/pandoc. Use when output must open in Office or a PDF reader.
---

# /document

The output gap: styx reads any format (`/to-markdown`) and makes images (`/image-gen`), but a lot of work has to land as a file someone opens in Office. This produces those — faithfully, no fake "here's roughly what it'd look like."

## When to use

- The deliverable is a `.docx`, `.pptx`, `.xlsx`, or `.pdf` — a report, a deck, a spreadsheet, a one-pager.
- Editing an existing office file (fill a template, update a sheet, append slides) rather than regenerating it.
- `/operator` shipping something to a non-technical recipient who lives in Office, or `/writer` whose prose needs to land as a formatted doc.

## When NOT to use

- The content can live as markdown, a README, or plain text → just write it. Don't reach for `.docx` because it feels official.
- Converting *from* a file/URL *to* markdown → `/to-markdown`.
- Generating imagery or diagrams → `/image-gen`.

## Tools

Prefer the format-native Python library — it round-trips structure and styling cleanly. Reach for `pandoc` only for whole-document markdown→docx/pdf conversions.

| Format | Library | Convert path |
|---|---|---|
| `.docx` | `python-docx` | `pandoc in.md -o out.docx` |
| `.pptx` | `python-pptx` | — |
| `.xlsx` | `openpyxl` | — |
| `.pdf`  | `pandoc` (via LaTeX) or `reportlab` | `pandoc in.md -o out.pdf` |

Check availability first (`python3 -c "import docx"`, `pandoc --version`); install only what the task needs and tell the user what you added.

## Workflow

1. **Confirm the spec.** Format, structure (sections / slides / sheets+columns), any template or brand to match, where the file should land.
2. **Create vs. edit.** *New* → build from content, with a real structure (headings, a title slide, typed columns) — not one wall of text. *Edit* → open the existing file, change only what's asked, preserve the rest of its styling. Never silently regenerate a file you were asked to edit.
3. **Generate.** Native library for structured/templated work; `pandoc` for straight markdown→doc. For decks, one idea per slide. For sheets, headers + correct cell types (numbers as numbers, not strings) + formulas where they belong.
4. **Open it and check.** Actually verify the file is valid and has the content — `python3 -c "import docx; print(len(docx.Document('out.docx').paragraphs))"`, reopen the workbook, count slides. A corrupt or empty file that "ran" is a failure, not a deliverable.
5. **Hand back** the path, what's in it, and how it was made.

## Output

```
file:    path/to/deliverable.docx
format:  docx | pptx | xlsx | pdf
made by: [python-docx | python-pptx | openpyxl | pandoc | reportlab]
contents: [sections / slides / sheets — counted, verified]
note:    [installed X | matched template Y | warts]
```

## Refusals

- Don't claim a file exists you didn't generate and open. Verify, then report.
- Don't regenerate a file you were asked to edit — open it and change in place.
- Don't push `.docx` when markdown would serve. Format follows the recipient, not the vibe.
- Don't dump one unstructured blob into a doc and call it formatted. Headings, slide breaks, typed cells — structure is the point of the format.
