# Notes, homework, reports, templates

Compiled: [examples/notes.typ](examples/notes.typ), [examples/homework.typ](examples/homework.typ), [examples/layout.typ](examples/layout.typ) (title page).

## Study / lecture notes

Copy `examples/notes.typ`. It already has: `#set page/text/par/heading/equation`, theorion 0.6.0 (`#definition` `#theorem` `#proof` `#example` …), `#tip`/`#warn` via `.with`, outline, table.

```typ
#import "@preview/theorion:0.6.0": *
#import cosmos.fancy: *                 // or cosmos.simple / rainbow / clouds
#show: show-theorion
#definition[Name][body] <def:x>
#theorem[Name][body] <thm:x>
#proof[…]
```

Conventions: one `=` per topic, `==` subtopic; label anything you will `@ref`. Long notes: `main.typ` + `#include "week-03.typ"`.

Theorem alts: `great-theorems` 0.1.2, `ctheorems` 2.0.0, `frame-it` 2.0.0. Callouts: roll a 5-line `callout` (see notes.typ) before adding `showybox` / `gentle-clues` / `note-me`. Margin notes: `marginalia` 0.3.1. TODOs: `drafting` 0.2.2 / `dashy-todo` 0.1.3.

## Homework

`examples/homework.typ`: counter + solution toggle.

```
typst compile homework.typ
typst compile homework.typ --input answers=1
```

`sys.inputs` values are strings. Pattern: `#let show-answers = sys.inputs.at("answers", default: "0") == "1"`.

## Report / thesis skeleton

```typ
#set page(numbering: "i")
#outline()
#pagebreak()
#counter(page).update(1)
#set page(numbering: "1")
#include "chapters/intro.typ"
#pagebreak()
#set heading(numbering: "A.1")
#counter(heading).update(0)
= Appendix
```

Front matter: title page via `#page(header: none)[#title()]` (see layout.typ). Abstract = unnumbered heading + justified block.

## Own template

```typ
#let conf(title: none, authors: (), doc) = {
  set document(title: title, author: authors)
  set page(paper: "a4", numbering: "1")
  set text(size: 11pt)
  align(center, text(16pt, strong(title)))
  doc
}
#show: conf.with(title: [My notes], authors: ("Ada",))
```

Put it in `template.typ` and `#import "template.typ": conf`.

## `typst init` templates

Template entrypoints tested on 0.15.1, 2026-10-19. Importing a package alone does not verify its template. Font warnings below depend on locally installed fonts.

```
typst init @preview/charged-ieee:0.1.4 my-paper
```

| Kind | Package | Template check |
|---|---|---|
| IEEE paper | `charged-ieee` 0.1.4 | Clean |
| Math paper | `clean-math-paper` 0.2.8 | Clean |
| arXiv-like | `arkheion` 0.1.2 | Clean |
| Notes/book | `ilm` 2.1.1 | Iosevka font warnings |
| Tufte memo | `tufte-memo` 0.1.2 | Fails: `can only be used when context is known` |
| CV | `brilliant-cv` 4.1.1, `modern-cv` 0.10.0 | Source Sans / Roboto font warnings; inspect diagnostics |
| Resume | `basic-resume` 0.2.9 | Upstream `scienceicons` raw-text deprecation warnings |

Init, then compile `main.typ` (or whatever the template printed). Keep the template's package versions.

## Gotchas

- Theorion: `#show: show-theorion` once; pick **one** cosmos style. `#theorem-box(outlined: false)[..]` for unnumbered.
- Don't mix `ctheorems` and `theorion` in one file.
- Roman→arabic page numbers: update the **counter**, plus `#set page(numbering: …)`.
