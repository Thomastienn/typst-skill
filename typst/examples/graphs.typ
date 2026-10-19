// Drawings, function plots, data plots, node/arrow diagrams.
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.4": plot
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/diagraph:0.3.7": raw-render
#set page(width: 16cm, height: auto, margin: 1cm)

= CeTZ: free drawing (TikZ-like)
#figure(caption: [Unit circle])[
  #cetz.canvas({
    import cetz.draw: *
    grid((-1.5, -1.5), (1.5, 1.5), step: 0.5, stroke: gray + 0.2pt)
    line((-1.6, 0), (1.6, 0), mark: (end: ">"))
    line((0, -1.6), (0, 1.6), mark: (end: ">"))
    circle((0, 0), radius: 1)
    let p = (calc.cos(40deg), calc.sin(40deg))
    line((0, 0), p, stroke: blue)
    line(p, (p.at(0), 0), stroke: (dash: "dashed"))
    arc((0, 0), start: 0deg, stop: 40deg, radius: 0.3, anchor: "origin")
    content((0.45, 0.15), $theta$)
    content(p, $P$, anchor: "south-west", padding: 0.1)
  })
] <fig:circle>

= cetz-plot: function plots
#cetz.canvas({
  plot.plot(size: (8, 4), x-tick-step: 1, x-label: $x$, y-label: $y$, legend: "inner-north-east", {
    plot.add(domain: (-calc.pi, calc.pi), samples: 100, x => calc.sin(x), label: $sin x$)
    plot.add(domain: (-calc.pi, calc.pi), samples: 100, x => calc.cos(x), label: $cos x$)
  })
})

= Lilaq: data plots (matplotlib-like)
#let xs = lq.linspace(0, 10, num: 50)
#lq.diagram(
  width: 8cm, height: 5cm, xlabel: $t$, ylabel: $v$, legend: (position: top + left),
  lq.plot(xs, xs.map(x => calc.exp(-x / 4) * calc.cos(x)), label: [damped], mark: none),
  lq.scatter((1, 3, 5, 7, 9), (0.5, -0.4, 0.2, -0.1, 0.05), label: [samples]),
)

#lq.diagram(width: 6cm, height: 4cm, lq.bar((1, 2, 3, 4), (3, 5, 2, 6)))

= Fletcher: node/arrow diagrams (flowcharts, automata, commutative)
#diagram(node-stroke: 0.6pt, spacing: 2em,
  node((0, 0), [Start], shape: fletcher.shapes.pill),
  edge("-|>"),
  node((1, 0), [Read input]),
  edge("-|>"),
  node((2, 0), [Valid?], shape: fletcher.shapes.diamond),
  edge("-|>", [yes]),
  node((3, 0), [Done], shape: fletcher.shapes.pill),
  edge((2, 0), (1, 0), "-|>", [no], bend: 50deg),
)

#diagram(cell-size: 1.5cm, $
  A edge(f, ->) edge("d", g, ->) & B edge("d", h, ->) \
  C edge(k, ->) & D
$)

#diagram(node-stroke: 0.6pt,
  node((0, 0), $q_0$, radius: 1em),
  edge((0, 0), (1, 0), $a$, "-|>"),
  edge((0, 0), (0, 0), $b$, "-|>", bend: 130deg),
  node((1, 0), $q_1$, radius: 1em, extrude: (-2.5, 0)),
)

= Graphviz (diagraph)
#raw-render(```dot
digraph G { rankdir=LR; A -> B [label="f"]; B -> C }
```)
