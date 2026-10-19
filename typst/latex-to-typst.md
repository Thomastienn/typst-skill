# LaTeX → Typst

Verified against Typst 0.15. Compiled: [examples/math.typ](examples/math.typ).

## Document structure

| LaTeX | Typst |
|---|---|
| `\documentclass{article}` | `#set page(paper: "a4", margin: 2cm)` + `#set text(font: "New Computer Modern", size: 11pt)` |
| `\usepackage{x}` | `#import "@preview/x:ver": *` (only if needed; most is built in) |
| `\title \author \maketitle` | `#set document(title: .., author: ..)` + a centered `#align(center)[..]` block |
| `\section{A}` / `\subsection` | `= A` / `== A`; numbering: `#set heading(numbering: "1.1")` |
| `\section*{A}` | `#heading(numbering: none)[A]` |
| `\tableofcontents` | `#outline()` |
| `\textbf{x}` `\emph{x}` `\texttt{x}` | `*x*` `_x_` `` `x` `` |
| `\underline{x}` `\textsc{x}` | `#underline[x]` `#smallcaps[x]` |
| `itemize` / `enumerate` / `description` | `- a` / `+ a` / `/ Term: a` |
| `\label{x}` `\ref{x}` `\eqref{x}` | `<x>` `@x` `@x` |
| `\cite{k}` + `\bibliography{refs}` | `@k` + `#bibliography("refs.bib")` |
| `\footnote{x}` | `#footnote[x]` |
| `\newcommand{\R}{\mathbb{R}}` | `#let R = $RR$` |
| `\newcommand{\f}[1]{..#1..}` | `#let f(x) = [..#x..]` |
| `\renewcommand` / class options | `#set` / `#show` rules |
| `\input{a}` | `#include "a.typ"` |
| `\newpage` `\vspace{1em}` `\hfill` | `#pagebreak()` `#v(1em)` `#h(1fr)` |
| `\begin{center}` | `#align(center)[..]` |
| `\begin{verbatim}` / `lstlisting` | ```` ```lang ... ``` ```` |
| `\begin{figure} \includegraphics \caption` | `#figure(image("a.png", width: 80%), caption: [..]) <fig:a>` |
| `tabular` | `#table(columns: 3, table.header[a][b][c], [1], [2], [3])` |
| `minipage` side by side | `#grid(columns: (1fr, 1fr), gutter: 1em, [left], [right])` |
| `theorem`/`proof` (amsthm) | `@preview/theorion` (see examples/notes.typ) |
| `tikz` | `@preview/cetz` (see drawing.md) |
| `pgfplots` | `@preview/lilaq` or `@preview/cetz-plot` |
| `tikz-cd` | `@preview/fletcher` |
| `siunitx` `\SI{3}{m/s}` | `$3 "m"/"s"$` or `@preview/unify:0.8.1` / `zero:0.7.1` |
| `beamer` | `@preview/touying:0.8.0` (see [slides.md](slides.md)) |
| `\href` | `#link("url")[text]` |
| `\includepdf` | `#image("a.pdf", page: n)` (0.14+) |
| `\LaTeX` | `#"LaTeX"` (no logo built in) |

## Math syntax

| LaTeX | Typst |
|---|---|
| `\[ .. \]` / `equation` | `$ .. $` (spaces inside = display) |
| `align` with `&` and `\\` | same `&` and `\` inside one `$ .. $` |
| `\frac{a}{b}` | `a/b` or `frac(a, b)` |
| `x_{ij}` `e^{-x}` | `x_(i j)` `e^(-x)` |
| `\sqrt{x}` `\sqrt[3]{x}` | `sqrt(x)` `root(3, x)` |
| `\text{if}` | `"if"` |
| `\mathrm{d}x` `\operatorname{tr}` | `upright(d) x` (or `dif x`) `op("tr")` |
| `\mathbb{R}` `\mathbb{N}` | `RR` `NN` (also `bb(1)`) |
| `\mathcal{L}` `\mathfrak{g}` | `cal(L)` `frak(g)` |
| `\mathbf{v}` `\boldsymbol\alpha` | `bold(v)` `bold(alpha)` |
| `\vec v` `\hat x` `\bar x` `\tilde x` `\dot q` `\ddot q` | `arrow(v)` `hat(x)` `overline(x)` `tilde(x)` `dot(q)` `dot.double(q)` |
| `\left( .. \right)` | automatic; force with `lr(( .. ))` |
| `\|x\|` `\lvert x \rvert` | `norm(x)` `abs(x)` |
| `\lfloor x \rfloor` `\lceil x \rceil` | `floor(x)` `ceil(x)` |
| `\binom{n}{k}` | `binom(n, k)` |
| `pmatrix` | `mat(1, 2; 3, 4)`; brackets: `mat(delim: "[", ..)` |
| column vector | `vec(x, y, z)` |
| `cases` | `cases(x &"if" x > 0, 0 &"else")` |
| `\underbrace{a+b}_{n}` | `underbrace(a + b, n)` |
| `\sum\limits_a` / `\nolimits` | `limits(sum)_a` / `scripts(sum)_a` |
| `\stackrel{def}{=}` | `eq.def` or `stretch(=)^"def"` |
| `\cancel{x}` | `cancel(x)` |
| `\quad` `\qquad` `\,` | `quad` `wide` `thin` |
| `\tag{*}` | `#math.equation(block: true, numbering: _ => "(*)", $x^2$)`; add a label separately for refs |
| `\nonumber` | `#math.equation(block: true, numbering: none, $x^2$)` |

## Symbols

| LaTeX | Typst | LaTeX | Typst |
|---|---|---|---|
| `\cdot` | `dot` | `\times` | `times` |
| `\leq` `\geq` `\neq` | `<=` `>=` `!=` | `\approx` `\equiv` `\propto` | `approx` `equiv` `prop` |
| `\to` `\Rightarrow` `\iff` | `->` `=>` `<=>` | `\mapsto` | `|->` |
| `\infty` | `oo` / `infinity` | `\partial` `\nabla` | `partial` `nabla` |
| `\ldots` `\cdots` | `dots` `dots.c` | `\pm` `\mp` | `plus.minus` `minus.plus` |
| `\forall` `\exists` | `forall` `exists` | `\in` `\notin` | `in` `in.not` |
| `\subset` `\subseteq` | `subset` `subset.eq` | `\cup` `\cap` | `union` `inter` |
| `\emptyset` | `emptyset` | `\langle` `\rangle` | `chevron.l` `chevron.r` |
| `\sim` | `tilde.op` | `\hbar` | `planck` |
| `\ell` | `ell` | `\circ` (compose) | `compose` |
| `\wedge` `\vee` `\neg` | `and` `or` `not` | `\perp` `\parallel` | `perp` `parallel` |
| `\varphi` `\varepsilon` | `phi.alt` `epsilon.alt` | `\iint` `\oint` | `integral.double` `integral.cont` |

Removed in 0.15 (error, not warning): `sect`, `angle.l/r`, `planck.reduce`. Use `inter`, `chevron.l/r`, `planck`.

Math options: `frac.with(style: "horizontal" | "skewed")`, `#math.equation(alt: "description", $x^2$)`, `scr(A)` (script/roundhand). See the [equation reference](https://typst.app/docs/reference/math/equation/). Pasting a whole LaTeX equation: `mitex` (see [specialized.md](specialized.md)); prefer native math.

Unknown symbol? Search https://typst.app/docs/reference/symbols/sym/ or just paste the Unicode character.
