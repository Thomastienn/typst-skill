// Labels, refs, footnotes, bibliography, glossary. Compiling = testing.
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl
#show: make-glossary
#set page(width: 16cm, height: auto, margin: 1cm)
#set heading(numbering: "1.")
#set math.equation(numbering: "(1)")

#let entry-list = (
  (key: "pca", short: "PCA", long: "principal component analysis", description: "A linear dimensionality-reduction method."),
)
#register-glossary(entry-list)

= Labels and refs <sec:lab>

See @sec:lab, @sec:lab[Section], and #ref(<sec:lab>, supplement: [Sec.]).

$ e^(i pi) + 1 = 0 $ <eq:euler>
Equation refs need numbering: @eq:euler.

#show ref: it => {
  let el = it.element
  if el != none and el.func() == heading {
    link(el.location(), [§#numbering("1", ..counter(heading).at(el.location()))])
  } else { it }
}
Custom show-ref: @sec:lab.

A claim#footnote[Footnotes can themselves have labels.] <fn:a>
Reuse: #footnote(<fn:a>)

Internal: #link(<sec:lab>)[jump] · URL: #link("https://typst.app")[typst.app]

= Glossary

First mention: #gls("pca") (expands). Later: #gls("pca") (short). Plural: #glspl("pca").

#print-glossary(entry-list)

= Bibliography

Prose: #cite(<knuth86>, form: "prose"). Author: #cite(<euclid>, form: "author").
Parenthetical: @knuth86 @euclid[p. 7].

#bibliography("refs.bib", style: "ieee", title: [References])
