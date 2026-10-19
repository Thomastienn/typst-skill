# Text, lists, code

Compiled: [examples/text.typ](examples/text.typ).

## Text and paragraph

```typ
#set text(
  font: ("New Computer Modern", "DejaVu Sans"),  // fallback list
  size: 11pt, weight: "regular", lang: "en", hyphenate: true,
)
#set par(
  justify: true, leading: 0.65em, spacing: 1.2em,
  first-line-indent: (amount: 1.2em, all: false),  // dict folds across set rules (0.15)
)
```

- Tracking: `text(tracking: 0.1em)`. OpenType: `features: ("smcp",)`, `stylistic-set: 6`.
- Variable fonts (0.15): axes follow `weight`/`stretch`/`size`. Extra: `variations: (wght: 650)`. Omit family suffixes `"Variable"`/`"Var"`/`"VF"`.
- `typst fonts` lists families. `--font-path`. Variable fonts warn on 0.14; work on 0.15.
- Smart quotes follow `text.lang`. Hard break: `this \ next`.
- `#lorem(40)`. Drop cap: `@preview/droplet:0.3.1`.
- `#show "TODO": text(red)[TODO]` or `#show regex("\d+"): strong`.

## Inline styles

`_emph_` `*strong*` `#underline` `#strike` `#overline` `#highlight` `#sub` `#super` `#smallcaps` `#upper` `#lower`. `#show link: underline`. `#quote(block: true, attribution: [Ada])[..]`.

## Lists

```typ
- bullet
+ numbered
/ Term: definition

#set enum(numbering: "1.a.", full: true, start: 3)
#set list(marker: ([•], [--]), indent: 1em, body-indent: 0.4em)
```

- 0.15: `list.marker-align` (default baseline + end). Nested tight lists space better.
- Checklists: `@preview/cheq:0.4.0` `#show: checklist` then `- [ ]` / `- [x]`. **Scope it** — it fights other `enum` numbering (start > 1 overflows its marker list).
- Extra control: `@preview/itemize:0.2.0`.

## Code blocks

Native: `` `let x = 1` `` and fenced ```` ```py … ``` ````. Style: `#show raw.where(block: true): set block(fill: luma(245), inset: 8pt)`.

| Package | Pin | Use |
|---|---|---|
| **codly** | 2.0.0 | `#show raw.where(block: true): codly.new` — 2.0 API, needs Typst 0.15. Languages: `codly-languages` 0.1.10 via `#show: codly.lang-set_(languages: codly-languages)` |
| **zebraw** | 0.6.3 | `#zebraw(numbering: true, ```typ … ```)` lighter alternative |

Codly 1.x snippets (`#show: codly-init.with()`) are **wrong** for 2.0.

## Numbering

`#set heading(numbering: "1.1")`. Function: `numbering: (..n) => …`. Per-level patterns: `@preview/numbly:0.1.0` `numbly("{1}.", "{1}.{2}")`. Built-in strings: `"1."`, `"1.a.i"`, `"I."`, `"(a)"`. 0.15 adds Armenian/Abjad/Tibetan; Greek numbering changed to modern style.

## Gotchas

- Empty `text.font: ()` errors. Unknown family: `typst fonts`.
- `par.first-line-indent` as a length still works; prefer the dict form.
- Default math font calligraphic forms changed in 0.15 (NCM 8.1). Restore old: `#show math.equation: set text(stylistic-set: 6)`.
