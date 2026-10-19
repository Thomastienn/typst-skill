// Figures, images, tables. Every assert must hold; compiling = testing.
#import "@preview/subpar:0.2.2"
#import "@preview/headcount:0.1.1": dependent-numbering, reset-counter
#import "@preview/tablem:0.3.0": tablem, three-line-table
#import "@preview/rowmantic:0.5.0": rowtable
#import "@preview/wrap-it:0.1.1": wrap-content
#set page(width: 16cm, height: auto, margin: 1cm)
#set heading(numbering: "1.")

// Captions of tables go on top; all other kinds stay below
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.caption: set text(size: 0.9em)

// Per-chapter numbering: figures via headcount, equations built-in
#set figure(numbering: dependent-numbering("1.1"))
#set math.equation(numbering: n => numbering("(1.1)", counter(heading).get().first(), n))
#show heading.where(level: 1): it => { counter(math.equation).update(0); it }
#show heading: reset-counter(counter(figure.where(kind: image)))
#show heading: reset-counter(counter(figure.where(kind: table)))

#outline(target: figure.where(kind: image), title: [List of Figures])
#outline(target: figure.where(kind: table), title: [List of Tables])

= Figures

#figure(
  rect(width: 4cm, height: 1.5cm, fill: aqua),
  caption: [A rectangle.],
  alt: "An aqua rectangle",
  gap: 0.8em,
) <fig:rect>

#figure(
  ```py
  print("hi")
  ```,
  caption: [Listing (kind `raw` auto-detected).],
  supplement: [Listing],
) <lst:hi>

#figure(
  block(stroke: 0.5pt, inset: 6pt)[1. read input \ 2. sort \ 3. print],
  kind: "algo",
  supplement: [Algorithm],
  numbering: "I",
  caption: [Custom kind with its own counter.],
) <alg:sort>

#figure(rect(width: 100%, height: 1cm, fill: yellow), placement: top, caption: [Floats to page top.]) <fig:float>

See @fig:rect, @lst:hi, @alg:sort, @fig:float. $ E = m c^2 $ <eq:e>

#context {
  let f = query(<fig:rect>).first()
  assert.eq(f.kind, image)            // body is not an image, but kind defaults to image
  assert.eq(query(<lst:hi>).first().kind, raw)
  assert.eq(counter(figure.where(kind: "algo")).at(<alg:sort>), (1,))
  assert.eq(counter(math.equation).at(<eq:e>), (1,))
}

= Images

#figure(
  image("shape.svg", width: 4cm, alt: "Blue circle, orange triangle"),
  caption: [SVG from a path.],
) <fig:svg>

#grid(columns: 4, gutter: 6pt,
  image("shape.svg", width: 3cm, height: 1cm, fit: "cover"),
  image("shape.svg", width: 3cm, height: 1cm, fit: "contain"),
  image("shape.svg", width: 3cm, height: 1cm, fit: "stretch"),
  image("shape.pdf", page: 2, height: 1cm),     // PDF page as vector image
)

#let svg = read("shape.svg")                         // str
#image(bytes(svg.replace("#2B80FF", green.to-hex())), width: 2cm)
#image(read("shape.svg", encoding: none), format: "svg", width: 2cm)
#image(bytes(range(16).map(x => x * 16)), format: (encoding: "luma8", width: 4, height: 4), width: 1cm, scaling: "pixelated")
#box(image("shape.svg", height: 1em)) inline image needs `box`.

#context assert.eq(counter(figure.where(kind: image)).at(<fig:svg>), (1,))  // reset per chapter
#context assert.eq(counter(math.equation).get(), (0,))

= Tables

#show table.cell.where(y: 0): strong
#figure(
  table(
    columns: (auto, 1fr, auto),
    align: (x, y) => if x == 2 { right } else { left },
    inset: (x: 6pt, y: 4pt),
    stroke: (x, y) => (bottom: if y == 0 { 1pt } else { 0.3pt + gray }),
    fill: (_, y) => if calc.even(y) and y > 0 { luma(240) },
    table.header[Item][Note][Price],
    [Apple], [fresh], [1.20],
    table.cell(colspan: 2, fill: yellow.lighten(60%))[Spans two columns], [10.00],
    table.cell(rowspan: 2, align: horizon)[Pear], [ripe], [0.80],
    [green], [0.75],
    table.footer[*Total*][][*12.75*],
  ),
  caption: [Function align, stroke and zebra fill.],
) <tab:items>

#let data = csv(bytes("name,qty\nbolt,120\nnut,8\nscrew,1045"))   // usually csv("data.csv")
#let (head, ..rows) = data
#set text(number-width: "tabular")
#table(
  columns: 2,
  align: (left, right),
  table.header(..head),
  ..rows.flatten(),
)

#let booktabs(..args) = table(
  stroke: none,
  table.hline(stroke: 0.08em),
  ..args,
  table.hline(stroke: 0.08em),
)
#figure(
  booktabs(
    columns: 3, align: (left, right, right),
    table.header([Model], [Params], [Acc.], table.hline(stroke: 0.05em)),
    [Small], [12 M], [81.2],
    [Large], [340 M], [88.9],
  ),
  caption: [Booktabs-style rules.],
) <tab:booktabs>

#table(
  columns: 2,
  table.header([Region], [Sales]),
  table.header(level: 2, table.cell(colspan: 2, fill: luma(230))[North]),
  [Oslo], [10],
  table.header(level: 2, table.cell(colspan: 2, fill: luma(230))[South]),
  [Rome], [20],
)

#grid(columns: (1fr, 1fr), gutter: 1em, rect(width: 100%)[grid: layout, no stroke/inset], rect(width: 100%)[table: data, semantics])

#context {
  assert.eq(counter(figure.where(kind: table)).at(<tab:booktabs>), (2,))
  assert.eq(query(figure.where(kind: table)).len(), 3)              // whole document
  assert.eq(query(figure.where(kind: table).before(here())).len(), 2)
}

= Packages

#subpar.grid(
  figure(image("shape.svg"), caption: [Left.]), <fig:sub-a>,
  figure(image("shape.svg", height: 2cm), caption: [Right.]), <fig:sub-b>,
  columns: (1fr, 1fr),
  caption: [Two subfigures.],
  label: <fig:sub>,
)
See @fig:sub, @fig:sub-a and @fig:sub-b.

#context assert.eq(counter(figure.where(kind: image)).at(<fig:sub>), (1,))  // subfigures don't count

#tablem[
  | *Name* | *Score* |
  | :----- | ------: |
  | John   | 5       |
  | Wally  | <       |
]

#three-line-table[
  | A | B |
  | --- | --- |
  | 1 | 2 |
]

#rowtable(stroke: 0.5pt, [A & B & C], [D & E])

#wrap-content(
  [#figure(rect(width: 3cm, height: 2cm, fill: teal), caption: [Wrapped.]) <fig:wrap>],
  [Text flows beside @fig:wrap. #lorem(40)],
  align: top + right,
)

// Long table across pages: figures are unbreakable by default
#set page(height: 6cm)
#show figure: set block(breakable: true)
#figure(
  table(columns: 2, table.header[n][$n^2$], ..range(1, 16).map(n => ([#n], [#(n * n)])).flatten()),
  caption: [Breaks across pages; header repeats.],
) <tab:long>
#metadata(none) <long-end>
#context assert(locate(<long-end>).page() > locate(<tab:long>).page())
