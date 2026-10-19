// Page setup and layout primitives (Typst 0.15). Must compile with zero warnings.
#import "@preview/wrap-it:0.1.1": wrap-content
#import "@preview/oasis-align:0.4.1": oasis-align
#import "@preview/meander:0.4.4"

#set document(title: [Layout Cookbook], author: "A. Agent")
#set text(size: 10pt)
#set par(justify: true)

// Page setup: per-side/inside-outside margins, bleed, numbering, header with
// a different first page, footer reading the page counter.
#set page(
  paper: "a5",
  margin: (inside: 2.2cm, outside: 1.5cm, y: 2cm),
  bleed: 3mm,
  numbering: "1",
  header: context if here().page() > 1 {
    set text(8pt)
    smallcaps[Layout Cookbook]
    h(1fr)
    let hs = query(heading.where(level: 1).before(here()))
    if hs.len() > 0 { emph(hs.last().body) }
  },
  footer: context align(center, text(8pt, counter(page).display("1 of 1", both: true))),
)

// Title page: page-specific settings via #page(..)[..]; background resolves against page + bleed.
#page(
  header: none,
  footer: none,
  fill: none,
  background: rect(width: 100%, height: 100%, fill: gradient.linear(navy, teal, angle: 90deg)),
)[
  #set text(fill: white)
  #set align(center + horizon)
  #title()
  #v(1em)
  #text(14pt)[A. Agent]
  #v(1fr)
  Draft · #datetime(year: 2026, month: 10, day: 19).display()
]
#counter(page).update(1)

= Grid, stack, columns

#grid(
  columns: (auto, 1fr, 2cm),
  gutter: 6pt,
  align: (left, center, right),
  fill: (x, y) => if y == 0 { luma(220) },
  [*auto*], [*1fr*], [*2cm*],
  grid.cell(colspan: 2)[spans two columns], [c],
  grid.cell(rowspan: 2, align: horizon)[tall], [b], [c],
  [b], [c],
)

#stack(dir: ltr, spacing: 4pt, rect(width: 1cm), rect(width: 1.5cm), rect(width: 2cm))

#columns(2, gutter: 1em)[
  #place(top + center, float: true, scope: "parent", clearance: 1em,
    block(fill: luma(235), inset: 6pt, width: 100%)[Float spanning both columns (`scope: "parent"`).])
  #lorem(30)
  #colbreak()
  #lorem(20)
]

= Boxes, blocks, spacing

Inline #box(fill: yellow.lighten(60%), inset: (x: 2pt), outset: (y: 2pt), radius: 2pt)[box] stays in the line.
#block(fill: luma(240), inset: 8pt, radius: 4pt, stroke: 0.5pt + gray, width: 100%, breakable: false)[
  A `block` is its own paragraph-level container.
  #place(top + right, dx: 4pt, dy: -4pt, text(7pt, red)[NEW])
]
#block(sticky: true)[*Sticky caption* (never separated from the next block)]
#rect(width: 100%, height: 1em, fill: teal.lighten(70%))

#align(right)[right] #v(0.5em) A #h(1fr) B #h(2fr) C
#pad(x: 2em)[#lorem(12)]
#v(1em, weak: true) Weak spacing collapses at page/block boundaries.

// measure/layout need context
#context {
  let s = measure[Hello]
  assert(s.width > 0pt and s.height > 0pt)
}
#layout(size => [Available width: #calc.round(size.width.cm(), digits: 1) cm])

#move(dx: 1em, dy: -2pt)[moved] #box(rotate(-10deg)[rotated]) #box(scale(x: -100%)[mirrored])
#rotate(90deg, reflow: true)[reflowed] I am #hide[invisible] here.

#box(width: 1fr, repeat[.]) dot leaders #box(width: 1fr, repeat(gap: 2pt)[-])
Chapter 1 #box(width: 1fr, repeat[.]) 12

#divider()
#show divider: block(width: 100%, align(center)[∗ ∗ ∗])
#divider()

#pagebreak(to: "odd") // parity of the *physical* page, not counter(page)
= Shapes and fills

#stack(dir: ltr, spacing: 6pt,
  line(length: 1.5cm, angle: 20deg, stroke: 2pt + red),
  rect(width: 1.5cm, height: 1cm, radius: 3pt, stroke: (bottom: 2pt, rest: 0.5pt)),
  square(size: 1cm, fill: blue.lighten(60%)),
  circle(radius: 0.5cm, fill: gradient.radial(white, blue)),
  ellipse(width: 1.5cm, height: 1cm, fill: gradient.conic(..color.map.rainbow)),
  polygon(fill: orange, (0pt, 1cm), (0.5cm, 0pt), (1cm, 1cm)),
  polygon.regular(vertices: 6, size: 1cm, fill: green),
  curve(
    stroke: purple + 1pt,
    curve.move((0pt, 1cm)),
    curve.cubic((0.5cm, -0.5cm), (1cm, 1.5cm), (1.5cm, 0pt)),
    curve.line((1.5cm, 1cm)),
    curve.close(),
  ),
)

#rect(width: 100%, height: 1cm, fill: tiling(size: (8pt, 8pt))[
  #place(line(start: (0%, 0%), end: (100%, 100%), stroke: 0.5pt))
])
#box(text(fill: gradient.linear(red, blue), weight: "bold")[Gradient text]) // box = gradient spans the word, not the line

= Wrap and side-by-side packages

#wrap-content(
  rect(width: 3cm, height: 2cm, fill: teal),
  lorem(45),
  align: top + right,
  column-gutter: 1em,
)

#oasis-align(rect(width: 100%, height: 3cm, fill: orange), lorem(25))

#block(height: 5cm, meander.reflow({
  import meander: *
  placed(top + left, circle(radius: 1cm, fill: yellow))
  container()
  content[#lorem(80)]
}))

// Landscape page with its own column count; the next page reverts.
#page(flipped: true, columns: 2)[
  = Landscape
  #lorem(80)
]
Back to portrait.
