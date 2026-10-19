# Drawing, plots, diagrams

Compiled: [examples/graphs.typ](examples/graphs.typ). Render PNG and look before handing back. Built-in shapes (`curve`, `tiling`): [layout.md](layout.md). Domain diagrams (circuits, automata, venn): [specialized.md](specialized.md).

| Need | Package |
|---|---|
| Free drawing, geometry, TikZ-style | `@preview/cetz:0.5.2` |
| Plot `y = f(x)` inside CeTZ | `@preview/cetz-plot:0.1.4` |
| Data plots (matplotlib-like) | `@preview/lilaq:0.6.0` |
| Flowcharts, automata, commutative diagrams | `@preview/fletcher:0.5.8` |
| Graphviz DOT | `@preview/diagraph:0.3.7` |

## CeTZ (free drawing, TikZ-like)

```typ
#import "@preview/cetz:0.5.2"
#cetz.canvas({
  import cetz.draw: *
  line((0, 0), (2, 1), mark: (end: ">"), stroke: blue + 1pt)
  circle((0, 0), radius: 1, fill: gray.lighten(80%))
  rect((0, 0), (2, 1), name: "box")
  content("box.center", [label])          // anchors: "box.north", "box.south-west", ...
  arc((0, 0), start: 0deg, stop: 90deg, radius: 0.5, anchor: "origin")
  grid((-2, -2), (2, 2), step: 0.5, stroke: 0.2pt + gray)
  bezier((0, 0), (3, 0), (1, 1), (2, -1))
})
```

- Units: 1 = 1cm. Change with `cetz.canvas(length: 0.5cm, ..)`.
- Coordinates: `(x, y)`, `(x, y, z)`, named anchors `"name.east"`, relative `(rel: (1, 0))`, polar `(30deg, 1)`.
- Styling everywhere: `set-style(stroke: 0.8pt, mark: (fill: black))`.
- `group({ .. })` scopes styles and transforms; `scale`, `rotate`, `translate` inside.
- Dashed: `stroke: (dash: "dashed")`. Math labels: `content(p, $theta$, anchor: "south-west", padding: 0.1)`.
- Trees: `cetz.tree.tree(([root], [a], ([b], [c])))`.

## cetz-plot (function plots in a CeTZ canvas)

```typ
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.4": plot
#cetz.canvas({
  plot.plot(size: (8, 4), x-tick-step: 1, x-label: $x$, y-label: $y$, legend: "inner-north-east", {
    plot.add(domain: (-3, 3), samples: 100, x => calc.sin(x), label: $sin x$)
    plot.add(((0, 0), (1, 1), (2, 4)), mark: "o")      // data points
  })
})
```

- Crowded ticks: set `x-tick-step` / `y-tick-step` (or `none`).
- Limits: `x-min`, `x-max`, `y-min`, `y-max`. Axis style: `axis-style: "school-book"` for centered axes.
- Fill under: `plot.add-fill-between(f, g, domain: ..)`.

## Lilaq (data plots, matplotlib-like)

```typ
#import "@preview/lilaq:0.6.0" as lq
#let xs = lq.linspace(0, 10, num: 50)
#lq.diagram(
  width: 8cm, height: 5cm, xlabel: $t$, ylabel: $v$, title: [Velocity],
  legend: (position: top + left),
  lq.plot(xs, xs.map(x => calc.cos(x)), label: [cos], mark: none),
  lq.scatter((1, 2, 3), (2, 1, 3), label: [data]),
)
#lq.diagram(lq.bar((1, 2, 3), (3, 5, 2)))
```

- Other plot types: `lq.hbar`, `lq.fill-between`, `lq.boxplot`, `lq.contour`, `lq.colormesh`, `lq.quiver`, `lq.stem`; error bars via `yerr:` on `lq.plot`.
- Log axes: `xscale: "log"`. Limits: `xlim: (0, 5)`.
- Load CSV: `#let data = csv("data.csv")`, then convert columns with `float`.
- Docs: https://lilaq.org

## Fletcher (nodes + arrows)

```typ
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#diagram(node-stroke: 0.6pt, spacing: 2em,
  node((0, 0), [Start], shape: fletcher.shapes.pill),
  edge("-|>"),                                   // connects previous and next node
  node((1, 0), [Check?], shape: fletcher.shapes.diamond),
  edge((1, 0), (0, 0), "-|>", [no], bend: 50deg),
)
```

- Arrow marks: `"->"`, `"-|>"`, `"=>"`, `"<->"`, `"--"` (dashed), `"..>"` (dotted), `"hook->"`, `"->>"`.
- Commutative diagrams: `#diagram($ A edge(f, ->) & B \ C & D $)` with `"d"`, `"r"` etc. for direction. Math-mode `edge` calls need the `diagram` wrapper.
- Automata: accept state `extrude: (-2.5, 0)`, self-loop `edge((0,0), (0,0), "-|>", bend: 130deg)`.
- Shapes: `fletcher.shapes.{rect, circle, pill, diamond, hexagon, parallelogram}`.

## Graphviz

```typ
#import "@preview/diagraph:0.3.7": raw-render
#raw-render(```dot
digraph G { rankdir=LR; A -> B [label="f"] }
```)
```

Also `render("digraph { a -> b }")`. Needs no system Graphviz (WASM).

## Gotchas

- Colors: `blue`, `rgb("#336699")`, `.lighten(50%)`, `.darken(20%)`, `.transparentize(50%)`.
- `calc.sin` etc. take radians (or `30deg`). Use `calc.pi`.
- Center a canvas: wrap in `#align(center)[..]` or put in `#figure(..)` to get a caption/number.
- Packages pin their own CeTZ version (fletcher uses 0.3.x); mixing them in one document is fine, but draw inside `cetz.canvas` with the `cetz` you imported.
- Log axes can't show 0: bars/fills with base 0 break `xscale: "log"`.
- 0.15: `path`/`pattern` removed. Use `curve`/`tiling` (see [layout.md](layout.md)).
