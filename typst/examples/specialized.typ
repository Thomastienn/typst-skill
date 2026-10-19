// Domain packages. One short snippet each. Compiling = testing.
#import "@preview/unify:0.8.1": num, qty
#import "@preview/zero:0.7.1": num as znum, zi
#import "@preview/typsium:0.3.2": ce
#import "@preview/whalogen:0.3.0": ce as mhchem
#import "@preview/lovelace:0.3.1": *
#import "@preview/algorithmic:1.0.7"
#import "@preview/curryst:0.6.0": rule, prooftree
#import "@preview/simplebnf:0.2.0": *
#import "@preview/tiaoma:0.3.0": qrcode
#import "@preview/mannot:0.4.0": markhl, annot
#import "@preview/cmarker:0.1.10"
#import "@preview/mitex:0.2.7": mi, mitex
#import "@preview/oxifmt:1.0.0": strfmt
#import "@preview/suiji:0.5.1": gen-rng, integers
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-venn:0.2.0"
#import "@preview/quill:0.8.0": *
#import "@preview/finite:0.5.1": automaton
#import "@preview/chronos:0.3.0"
#import "@preview/zap:0.6.0"
#import "@preview/diagraph:0.3.7": raw-render
#set page(width: 16cm, height: auto, margin: 1cm)
#set text(size: 10pt)

= Units
$ num("-1.3+-0.2e-6") quad qty("3.0e8", "m/s") $
#let Js = zi.declare("J s")
Planck: #Js[6.626e-34] · particles: #znum[1e80]

= Chemistry
#ce("[Cu(H2O)4]^2+ + 4NH3 -> [Cu(NH3)4]^2+ + 4H2O")
$ #mhchem("HCl + H2O -> H3O+ + Cl-") $

= Algorithms
#pseudocode-list[
  + *for* $i <- 1$ *to* $n$
    + $s <- s + a_i$
]
#show: algorithmic.style-algorithm
#algorithmic.algorithm({
  import algorithmic: *
  Assign[$x$][$0$]
  While($x < n$, { Assign[$x$][$x + 1$] })
})

= Logic / language
#prooftree(rule(name: [$-> I$], $Gamma, phi tack psi$, $Gamma tack phi -> psi$))
#bnf(Prod($e$, annot: $"Expr"$, {
  Or[$x$][_var_]
  Or[$e$ $e$][_app_]
}))

= Codes and markup
#qrcode("https://typst.app", width: 2cm)
$ markhl(x, #<x>) + y $
#annot(<x>)[marked]
#cmarker.render("*md* inside Typst")
Inline LaTeX: #mi("\\alpha^2") · display: #mitex(`\frac{a}{b}`)
#assert.eq(strfmt("User {} has {}.", "Ada", 10), "User Ada has 10.")
#let (rng, n) = integers(gen-rng(42), low: 0, high: 10)
#assert(n >= 0 and n < 10)

= Diagrams
#cetz.canvas({ cetz-venn.venn2() })
#quantum-circuit(lstick($|0〉$), $H$, ctrl(1), [\ ], lstick($|0〉$), 1, targ())
#automaton((q0: (q1: "a"), q1: none), initial: "q0", final: ("q1",))
#chronos.diagram({ import chronos: *; _par("A"); _par("B"); _seq("A", "B", comment: [hi]) })
#zap.circuit({ import zap: *; node("B", (0, 0)); resistor("r1", "B", (rel: (2, 0))) })
#raw-render(```dot
digraph { a -> b }
```)
