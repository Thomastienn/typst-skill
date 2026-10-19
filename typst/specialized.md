# Specialized packages

Compiled: [examples/specialized.typ](examples/specialized.typ). Pins in [packages.md](packages.md).

## Pick one

| Need | Package | Call |
|---|---|---|
| SI numbers/units | `unify` 0.8.1 | `num("-1.3+-0.2e-6")`, `qty("3e8", "m/s")` |
| Strict numbers + table align | `zero` 0.7.1 | `num[1e80]`, `zi.declare("J s")`, `format-table` |
| Chemistry (mhchem-like) | `typsium` 0.3.2 | `ce("H2O + … -> …")` |
| Chemistry alt | `whalogen` 0.3.0 | `$ #ce("HCl + H2O -> H3O+ + Cl-") $` |
| Skeletal formulae | `alchemist` 0.2.0 | CeTZ-based; read its README |
| Pseudocode | `lovelace` 0.3.1 | `pseudocode-list[+ *for* …]` |
| Pseudocode (algorithmicx) | `algorithmic` 1.0.7 | `#show: style-algorithm` + `Procedure`/`Assign`/`While` |
| Inference trees | `curryst` 0.6.0 | `prooftree(rule(name:, premise, conclusion))` — **last** positional = conclusion |
| BNF | `simplebnf` 0.2.0 | `bnf(Prod($e$, { Or[$x$][_var_] … }))` |
| QR / barcodes | `tiaoma` 0.3.0 | `qrcode("https://…")`, `code128("…")` |
| Mark terms in math | `mannot` 0.4.0 | `$ markhl(x, #<x>) $` then `#annot(<x>)[…]` |
| Markdown → Typst | `cmarker` 0.1.10 | `cmarker.render(read("a.md"))` |
| Paste LaTeX math | `mitex` 0.2.7 | `mi("\\alpha")`, `mitex(`\frac{a}{b}`)` |
| `strfmt` | `oxifmt` 1.0.0 | `strfmt("User {} has {}.", name, n)` |
| RNG (deterministic) | `suiji` 0.5.1 | `integers(gen-rng(42), low: 0, high: 10)` |
| Venn | `cetz-venn` 0.2.0 | `cetz.canvas({ cetz-venn.venn2() })` |
| Quantum circuits | `quill` 0.8.0 | `quantum-circuit(lstick($|0〉$), $H$, ctrl(1), [\ ], …)` |
| Automata | `finite` 0.5.1 | `automaton((q0: (q1: "a"), q1: none), initial:, final:)` |
| Sequence diagrams | `chronos` 0.3.0 | `chronos.diagram({ _par("A"); _seq("A", "B") })` |
| Electronics | `zap` 0.6.0 | `zap.circuit({ node("B", (0,0)); resistor("r1", "B", (rel: (2,0))) })` |
| Graphviz | `diagraph` 0.3.7 | `raw-render(````dot … ````)` |
| Gantt | `timeliney` 0.4.0 | read README; datetime-based: `gantty` 0.5.1 |
| 3D plots | `plotsy-3d` 0.2.1 | CeTZ surfaces |
| Neural nets | `neural-netz` 0.3.0 | architecture diagrams |
| Icons | `fontawesome` 0.6.2 | needs FA **desktop** fonts installed (`typst fonts`) |

## Minimal snippets (all in the example file)

```typ
#import "@preview/unify:0.8.1": num, qty
$ qty("3.0e8", "m/s") $

#import "@preview/typsium:0.3.2": ce
#ce("CO2 + H2O -> H2CO3")

#import "@preview/mitex:0.2.7": mi, mitex
#mi("\\sum_{i=1}^n i")     // last resort; native Typst math is smaller
```

Prefer native Typst / CeTZ / lilaq / fletcher before these. Use mitex only when pasting existing LaTeX.

## Gotchas

- `unify` / `zero` both export `num` — alias one (`num as znum`).
- `whalogen` vs `typsium`: both export `ce`. Alias.
- `curryst` `rule(…)`: premises first, **conclusion last**.
- `simplebnf` `Or[…][…]` calls must be **separate statements** (newlines) inside `{ }`.
- `suiji` is pure: you thread `rng` through; same seed → same numbers.
- Font Awesome: package does not bundle the font. Skip icons if `typst fonts` has no Font Awesome.
