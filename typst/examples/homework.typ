// Homework / problem set. `typst compile homework.typ --input answers=1` shows solutions.
#set page(paper: "a4", margin: 2cm, numbering: "1")
#set heading(numbering: "1.")
#let show-answers = sys.inputs.at("answers", default: "0") == "1"
#let problem = counter("problem")
#let q(body, solution: none) = {
  problem.step()
  block(width: 100%, inset: (y: 0.6em))[
    *Problem #context problem.display().* #body
    #if show-answers and solution != none {
      block(inset: 8pt, fill: luma(245), width: 100%)[*Solution.* #solution]
    }
  ]
}

= Problem set 1

#q(solution: [Eigenvalues $2, 3$; already diagonal.])[
  Diagonalise $mat(2, 0; 0, 3)$.
]

#q(solution: [$1/3$])[
  Compute $integral_0^1 x^2 dif x$.
]
