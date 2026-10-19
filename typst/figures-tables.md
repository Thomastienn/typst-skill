# Figures, images, tables

Compiled: [examples/figures.typ](examples/figures.typ) (uses `examples/shape.svg` and `shape.pdf`).

## Figure

```typ
#figure(
  image("shape.svg", width: 70%),
  caption: [A thing.],
  alt: "short description",          // 0.14 a11y
  gap: 0.8em,
  placement: top,                    // none | top | bottom | auto (float)
) <fig:a>
#show figure.where(kind: table): set figure.caption(position: top)
```

- `kind` defaults from the body (`image`, `table`, `raw`). Custom: `kind: "algo", supplement: [Algorithm], numbering: "I"`.
- Outline: `#outline(target: figure.where(kind: image), title: [Figures])`.
- Per-chapter numbers: `@preview/headcount:0.1.1` `dependent-numbering("1.1")` + `reset-counter` on headings (see example). Alt: `i-figured` 0.2.4.
- Figures do not break across pages unless `#show figure: set block(breakable: true)`.

Subfigures: `@preview/subpar:0.2.2`

```typ
#import "@preview/subpar:0.2.2"
#subpar.grid(
  figure(image("shape.svg"), caption: [Left.]), <fig:a>,
  figure(image("shape.svg"), caption: [Right.]), <fig:b>,
  columns: (1fr, 1fr), caption: [Both.], label: <fig:both>,
)
```

Wrap text: `wrap-content([#figure(..) <fig:w>], [text @fig:w], align: top + right)` (`wrap-it` 0.1.1).

## Image

```typ
#image("shape.svg", width: 4cm, alt: "…")
#image("shape.svg", width: 3cm, height: 1cm, fit: "cover")  // contain | stretch
#image("shape.pdf", page: 2)                                 // PDF page as image (0.14)
#image(read("shape.svg", encoding: none), format: "svg")
#image(bytes(range(16).map(x => x * 16)), format: (encoding: "luma8", width: 4, height: 4))
```

Formats: png, jpg, gif, svg, **webp**, **pdf**. Inline images need `#box(image(.., height: 1em))`. Paths: forward slashes only (0.15).

## Table

```typ
#show table.cell.where(y: 0): strong
#table(
  columns: (auto, 1fr, auto),
  align: (x, y) => if x == 2 { right } else { left },
  inset: (x: 6pt, y: 4pt),
  stroke: (x, y) => (bottom: if y == 0 { 1pt } else { 0.3pt + gray }),
  fill: (_, y) => if calc.even(y) and y > 0 { luma(240) },
  table.header[A][B][C],
  [1], [2], [3],
  table.cell(colspan: 2)[wide], [z],
  table.footer[*sum*][][*3*],
)
```

- Multiple headers (0.14): `table.header(level: 2)[..]` for group rows; a header forces a row break.
- Booktabs: `stroke: none` + `table.hline()` at top/mid/bottom (see example `booktabs` helper).
- From CSV: `let (head, ..rows) = csv("d.csv"); table(columns: n, table.header(..head), ..rows.flatten())`.
- Markdown-like: `tablem` 0.3.0. Row-wise `&` cells: `rowmantic` 0.5.0 `rowtable`.
- Numeric alignment in tables: `zero` 0.7.1 `format-table`.

## Gotchas

- `figure` of a `rect` still has `kind == image` (default). Set `kind:` if you need a separate counter.
- `query(figure.where(kind: table))` is the whole doc; add `.before(here())` for “so far”.
- Long tables: make the figure breakable **and** use `table.header` so the header repeats.
