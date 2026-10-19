---
name: typst
description: Write, edit, debug and convert Typst (.typ) documents — scripting (functions, loops, templates, show rules, state), notes, math, figures, tables, CeTZ drawings, plots (cetz-plot, lilaq), diagrams (fletcher), and LaTeX-to-Typst translation. Use when the user mentions Typst, .typ files, typst compile/watch, wants notes or a document "like LaTeX", or asks to draw graphs, plots, or diagrams in Typst.
---

# Typst

Target: Typst 0.14 CLI (`typst --version`). Typst is not LaTeX: no backslash commands, no preamble packages. Markup mode by default, `#` enters code, `$...$` enters math.

## Workflow (always)

1. Edit the `.typ` file.
2. Compile: `typst compile file.typ` (or `typst watch file.typ` for the user to keep open). Use `--root .` if imports reach outside the file's dir.
3. Fix every `error:` and `warning:` (deprecations included), recompile until clean.
4. For drawings, plots, or layout changes, look at the result: `typst compile file.typ /tmp/out-{p}.png --ppi 100`, then read the PNG. Fix overlaps, crowded ticks, clipped labels.

Never hand back Typst that hasn't compiled.

## Core syntax

| Thing | Typst |
|---|---|
| Heading | `= H1`, `== H2` |
| Bold / italic / code | `*bold*`, `_italic_`, `` `code` `` |
| Lists | `- bullet`, `+ numbered`, `/ Term: def` |
| Link / label / ref | `#link("url")[text]`, `<label>`, `@label` |
| Footnote | `#footnote[...]` |
| Page break / spacing | `#pagebreak()`, `#v(1em)`, `#h(1fr)` |
| Include file | `#include "chapter.typ"` (content) / `#import "lib.typ": *` (defs) |
| Variable / function | `#let x = 5`, `#let f(a, b: 1) = [..#a..]` |
| Style everything | `#set text(size: 11pt)` |
| Transform elements | `#show heading: set text(blue)`, `#show "TODO": text(red)[TODO]` |
| Wrap whole doc | `#show: template.with(title: "x")` |
| Content block | `[markup *here*]` |
| Read state (page no., counters) | `context counter(page).get()` |
| Image / figure | `#figure(image("a.png", width: 70%), caption: [..]) <fig:a>` |
| Bibliography | `#bibliography("refs.bib")`, cite with `@key` |

Partial application: `#let tip = callout.with("Tip", color: green)`.

Writing real code (loops, arrays/dicts, closures, templates, show-rule functions, state/counters/query, data files, `sys.inputs`): see [scripting.md](scripting.md). Patterns there are tested asserts in [examples/scripting.typ](examples/scripting.typ).

## Math essentials

- Inline `$x^2$`; display needs spaces: `$ x^2 $`. Number displays with `#set math.equation(numbering: "(1)")`.
- Multi-letter words are identifiers: `ab` errors, write `a b`. Text goes in quotes: `"if"`.
- Grouping uses parens, not braces: `x_(i j)`, `e^(-x^2)`, `(n+1)/2` (outer parens dropped).
- `\` newline, `&` alignment point (like `align`).
- Common: `frac(a, b)`, `sqrt(x)`, `root(3, x)`, `vec(x, y)`, `mat(1, 2; 3, 4)`, `cases(..)`, `abs(x)`, `norm(x)`, `RR`, `cal(L)`, `bold(v)`, `upright(d)`, `op("argmax")`, `lr(( .. ))`.
- Full LaTeX mapping and 0.14 symbol renames: [latex-to-typst.md](latex-to-typst.md).
- Physics/derivatives: `#import "@preview/physica:0.9.8": *` gives `dv`, `pdv`, `braket`, `vb`, `grad`.

## Notes

Start from [examples/notes.typ](examples/notes.typ): page/text setup, numbered headings and equations, theorion theorem boxes (`#definition`, `#theorem`, `#proof`, `#example`, ...), custom callouts, outline, tables. Copy it, change the title, write.

Notes conventions:
- One `= Heading` per topic, `==` for subtopics; label things you'll reference (`<def:x>`, `<eq:x>`, `<thm:x>`).
- Key ideas in `#definition`/`#theorem`, intuition in `#tip`, pitfalls in `#warn`.
- Long notes: split into files and `#include` them from a `main.typ`.

## Drawing & graphs

Pick the tool:

| Need | Package |
|---|---|
| Free drawing, geometry, TikZ-style | `@preview/cetz:0.5.2` |
| Plot a function `y = f(x)` inside CeTZ | `@preview/cetz-plot:0.1.4` |
| Data plots: line, scatter, bar, error bars (matplotlib-like) | `@preview/lilaq:0.6.0` |
| Flowcharts, automata, commutative diagrams, graphs of nodes/edges | `@preview/fletcher:0.5.8` |
| Graphviz DOT | `@preview/diagraph:0.3.6` |

Working, compiled examples of each: [examples/graphs.typ](examples/graphs.typ). API notes and gotchas: [drawing.md](drawing.md).

## Editing existing Typst

- Read the whole file's `#set`/`#show`/`#import` header first; reuse its helpers and styles rather than adding new ones.
- Keep package versions consistent with what the file already imports.
- Preserve labels; grep for `@label` before renaming one.
- After edits, compile and fix errors (step 2-3 of Workflow).

## Common errors

| Error | Fix |
|---|---|
| `unknown variable: xy` in math | Space letters `x y` or quote `"xy"` |
| `expected content, found ...` | Wrap in `[...]` or convert with `str()`/`repr()` |
| `cannot access file system outside of project root` | `typst compile --root <dir>` |
| `package not found` | Check exact `name:version` on typst.app/universe |
| `unknown font family` | `typst fonts` lists available ones |
| `... is deprecated, use ... instead` | Apply the suggested name |
| Layout loop / `context` errors | Only read counters/state/`here()` inside `context` |
