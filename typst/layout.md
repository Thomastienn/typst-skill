# Layout

Compiled: [examples/layout.typ](examples/layout.typ).

## Page

```typ
#set page(
  paper: "a4",                       // also "us-letter", "presentation-16-9", …
  margin: (inside: 2.2cm, outside: 1.5cm, y: 2cm),  // or 2cm, or (x:, y:)
  numbering: "1",
  bleed: 3mm,                        // 0.15 crop/bleed
  header: context if here().page() > 1 { smallcaps[Title] + h(1fr) + [Chapter] },
  footer: context align(center, counter(page).display("1 of 1", both: true)),
)
#page(header: none, footer: none, fill: luma(240))[title page body]
#counter(page).update(1)
#pagebreak(to: "odd")                // physical page, not the counter
#page(flipped: true, columns: 2)[landscape body]   // next page reverts
```

- `paper` sizes include `"a4"`, `"us-letter"`, `"us-executive"` (size was wrong before 0.15), `"presentation-16-9"`.
- `#title()` prints `document.title` (0.14+). Pair with `#set document(title:, author:)`.
- Running header from last heading: `query(heading.where(level: 1).before(here()))`. Package: `hydra` 0.6.3.

## Columns, grid, stack

```typ
#columns(2, gutter: 1em)[ … #colbreak() … ]
#grid(
  columns: (auto, 1fr, 2cm), gutter: 6pt,
  align: (left, center, right),
  fill: (x, y) => if y == 0 { luma(220) },
  [*h*], [*h*], [*h*],
  grid.cell(colspan: 2)[wide], [c],
)
#stack(dir: ltr, spacing: 4pt, rect(width: 1cm), rect(width: 1.5cm))
```

`table` = data + semantics; `grid` = layout only (no default stroke/inset).

## Box vs block, place, spacing

- `box`: stays in line. `block`: paragraph-level, `breakable:`, `sticky:` (keep with next).
- `#place(top + right, dx: 4pt, dy: -4pt)[..]`. Float: `#place(top, float: true, scope: "parent", clearance: 1em)[..]` (parent = span columns).
- `#v(1em)`, `#h(1fr)`, `#v(1em, weak: true)` (collapses at boundaries). `#pad(x: 2em)[..]`.
- `#align(center + horizon)`, `#move`, `#rotate(-10deg)`, `#rotate(90deg, reflow: true)`, `#scale(x: -100%)`, `#hide[..]`.
- Dot leaders: `Chapter 1 #box(width: 1fr, repeat[.]) 12`.
- Measure: `#context { let s = measure[Hello]; s.width }` · `#layout(size => [… #size.width …])`.

## Shapes and fills (0.15)

The `path` drawing element was **removed** → `curve`. The new `path()` type resolves file paths. `pattern` **removed** → `tiling`.

```typ
#line(length: 1.5cm, angle: 20deg)
#rect(width: 2cm, height: 1cm, radius: 3pt, stroke: (bottom: 2pt, rest: 0.5pt))
#circle(radius: 0.5cm, fill: gradient.radial(white, blue))
#polygon((0pt, 1cm), (0.5cm, 0pt), (1cm, 1cm), fill: orange)
#curve(stroke: 1pt, curve.move((0pt, 1cm)), curve.cubic((0.5cm, 0pt), (1cm, 1cm), (1.5cm, 0pt)), curve.close())
#rect(width: 100%, height: 8pt, fill: tiling(size: (8pt, 8pt))[#place(line(start: (0%, 0%), end: (100%, 100%)))])
```

Gradient on text: wrap in `#box` or the gradient spans the line. `#divider()` is a stylable thematic break (`#show divider: …`).

## Wrap / side-by-side packages

| Need | Call |
|---|---|
| Text beside a figure | `#import "@preview/wrap-it:0.1.1": wrap-content` then `wrap-content(fig, text, align: top + right)` |
| Equal-height columns | `@preview/oasis-align:0.4.1` `oasis-align(a, b)` |
| Text flowing around shapes | `@preview/meander:0.4.4` `meander.reflow({ placed(..); container(); content[..] })` |

## Gotchas

- `here().page()` is the **physical** page. After `#counter(page).update(1)` they diverge.
- 0.15 keeps baselines on `box`/`list`/`enum`. Recheck old `dy` adjustments visually; remove them if the new baseline makes them unnecessary.
- `show page:` rules are unsupported (warning). Use `#page(..)[..]` or `#set page(..)`.
