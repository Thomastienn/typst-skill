---
name: typst
description: Write, edit, debug and convert Typst (.typ) documents — notes, math, figures, tables, slides, CeTZ drawings, plots (cetz-plot, lilaq), diagrams (fletcher), scripting, HTML/PDF export, and LaTeX-to-Typst. Use when the user mentions Typst, .typ files, typst compile/watch, notes or a document "like LaTeX", slides/touying, or drawing graphs/plots/diagrams in Typst.
---

# Typst

Target: **Typst 0.15.1** (`typst --version`). Markup by default. `#` = code, `$...$` = math. Not LaTeX: no `\` commands, no preamble.

Checked against the [official reference](https://typst.app/docs/reference/) and [0.15 changelog](https://typst.app/docs/changelog/0.15.0/) on 2026-10-19. Package APIs belong to their authors; use the pinned package's documentation linked from [Typst Universe](https://typst.app/universe/).

## Always

1. Edit the `.typ` file. Reuse its `#set`/`#show`/`#import` versions; do not bump packages unless asked.
2. `typst compile file.typ` (or `typst watch file.typ`). `--root .` if imports leave the file's dir. Forward slashes in paths.
3. Fix all errors and actionable warnings, including deprecations. Report remaining dependency or experimental-export warnings; preserve package pins unless asked to update them.
4. Drawings, plots, layout: `typst compile file.typ /tmp/out-{p}.png --ppi 100` then **look** at the PNG. Fix overlaps, clipped labels, crowded ticks.

Never hand back Typst that has not compiled.

## Read only the files you need

Do not load every `.md`. Open the one that matches the task:

| Task | Read |
|---|---|
| CLI, PDF/HTML/PNG/SVG export, `typst eval` | [cli.md](cli.md) |
| Page, grid, box/block, wrap, shapes, `divider` | [layout.md](layout.md) + [examples/layout.typ](examples/layout.typ) |
| Fonts, par, lists, raw/code, numbering | [text.md](text.md) + [examples/text.typ](examples/text.typ) |
| Math, physics, LaTeX mapping | [latex-to-typst.md](latex-to-typst.md) + [examples/math.typ](examples/math.typ) |
| Scripting, templates, state, data files | [scripting.md](scripting.md) + [examples/scripting.typ](examples/scripting.typ) |
| Figures, images, tables, subfigures | [figures-tables.md](figures-tables.md) + [examples/figures.typ](examples/figures.typ) |
| Labels, cites, bib, glossary, outline | [references.md](references.md) + [examples/references.typ](examples/references.typ) |
| CeTZ / plots / fletcher / graphviz | [drawing.md](drawing.md) + [examples/graphs.typ](examples/graphs.typ) |
| Slides (touying, polylux) | [slides.md](slides.md) + [examples/slides.typ](examples/slides.typ) |
| Notes, homework, reports, templates | [documents.md](documents.md) + [examples/notes.typ](examples/notes.typ) |
| Units, chem, circuits, algorithms, QR | [specialized.md](specialized.md) + [examples/specialized.typ](examples/specialized.typ) |
| Package pins | [packages.md](packages.md) |
| Errors, 0.15 breakages | [errors.md](errors.md) |

Compiled snippets live in `examples/`. `./check.sh` at the repository root compiles all of them and fails on warnings. Markdown snippets may assume the imports or files named in their section.

## Core syntax

| Thing | Typst |
|---|---|
| Heading | `= H1`, `== H2` |
| Bold / italic / code | `*bold*`, `_italic_`, `` `code` `` |
| Lists | `- bullet`, `+ numbered`, `/ Term: def` |
| Link / label / ref | `#link("url")[text]`, `<label>`, `@label` |
| Include / import | `#include "ch.typ"` / `#import "lib.typ": *` |
| Style / transform | `#set text(size: 11pt)` / `#show heading: set text(blue)` |
| Template | `#show: conf.with(title: [x])` |
| Figure | `#figure(image("a.png", width: 70%), caption: [..]) <fig:a>` |
| Cite + bib | `@key` + `#bibliography("refs.bib")` |

Partial application: `#let tip = callout.with("Tip", color: green)`.
