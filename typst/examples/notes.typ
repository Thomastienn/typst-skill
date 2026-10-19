// Lecture/study notes template. Copy, change the header, write.
#import "@preview/theorion:0.6.0": *
#import cosmos.fancy: *
#show: show-theorion

#set document(title: "Linear Algebra — Week 3", author: "Thomas")
#set page(paper: "a4", margin: 2cm, numbering: "1",
  header: context if counter(page).get().first() > 1 [_Linear Algebra — Week 3_ #h(1fr) #datetime.today().display()])
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true)
#set heading(numbering: "1.1")
#set math.equation(numbering: "(1)")
#show link: underline

#let callout(title, color: blue, body) = block(
  width: 100%, inset: 10pt, radius: 3pt,
  fill: color.lighten(90%), stroke: (left: 3pt + color),
)[*#title* #h(0.5em) #body]
#let tip = callout.with("Tip", color: green)
#let warn = callout.with("Watch out", color: red)

#align(center, text(18pt, weight: "bold")[Linear Algebra — Week 3])
#outline(depth: 2)

= Eigenvalues

#definition[Eigenvector][
  A nonzero $bold(v)$ with $A bold(v) = lambda bold(v)$ for some scalar $lambda$.
] <def:eig>

The characteristic polynomial is
$ p(lambda) = det(A - lambda I) = 0. $ <eq:char>

#theorem[Spectral][
  Every real symmetric matrix is orthogonally diagonalisable.
] <thm:spectral>

#proof[
  Induction on $n$, using @eq:char and @def:eig.
]

#tip[Trace $=$ sum of eigenvalues, $det =$ product.]
#warn[Eigenvectors of a defective matrix do not span $RR^n$.]

== Worked example

+ Compute $det(A - lambda I)$.
+ Solve for $lambda$.
+ For each $lambda$, solve $(A - lambda I) bold(v) = bold(0)$.

#table(
  columns: 3, align: center, stroke: 0.5pt,
  table.header[*Matrix*][*Eigenvalues*][*Diagonalisable?*],
  [$mat(2, 0; 0, 3)$], [$2, 3$], [yes],
  [$mat(1, 1; 0, 1)$], [$1, 1$], [no],
)

See @thm:spectral.
