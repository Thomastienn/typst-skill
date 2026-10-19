// Text, paragraphs, lists, code blocks. Compiling = testing.
#import "@preview/codly:2.0.0" as codly
#import "@preview/codly-languages:0.1.10": codly-languages
#import "@preview/zebraw:0.6.3": zebraw
#import "@preview/numbly:0.1.0": numbly
#import "@preview/cheq:0.4.0": checklist
#set page(width: 16cm, height: auto, margin: 1cm)
#set text(size: 10pt, lang: "en", hyphenate: true)
#set par(justify: true, leading: 0.65em, first-line-indent: (amount: 1.2em, all: false))
#set heading(numbering: numbly("{1}.", "{1}.{2}"))

= Text

#text(font: ("New Computer Modern", "DejaVu Sans"), size: 11pt, weight: "bold", fill: eastern)[Styled]
#text(tracking: 0.1em)[tracked] #text(features: ("smcp",))[Small-cap features]
#lorem(12)

#set par(justify: true, hanging-indent: 1em)
Hanging indent paragraph. #lorem(18)
#set par(hanging-indent: 0pt)

Smart quotes: "hello" vs `'code'`. Hard break: this \
stays on the next line.

#show link: underline
#link("https://typst.app")[typst.app] · #emph[emph] · *strong* · #underline[u] · #strike[x] · #highlight[hi] · #sub[2] · #super[n] · #smallcaps[Nasa] · #upper[ab] · #lower[AB]

#quote(block: true, attribution: [Ada])[The Analytical Engine weaves algebraical patterns.]

#text(fill: gradient.linear(red, blue))[Gradient fill needs a box/width to span a word, not the line.]

= Lists

- bullet
- nested
  - child

+ numbered
+ still numbered

#[
  #set enum(numbering: "1.a.", full: true, start: 3)
  + continues at 3
    + child is 3.a
]

#[
  #set list(marker: ([•], [--]), indent: 1em, body-indent: 0.4em)
  - custom marker
    - second level
]

/ Term: definition
/ Other: more

#[
  #show: checklist
  - [ ] todo
  - [x] done
]

= Code

Inline `let x = 1`. Native block:

```py
def f(x):
    return x + 1
```

#show: codly.lang-set_(languages: codly-languages)
#show raw.where(block: true): it => if it.lang == "rs" { codly.new(it) } else { it }
```rs
fn main() { println!("hi"); }
```

#zebraw(
  numbering: true,
  ```typ
  #let x = 1
  ```
)

= Numbering

#numbering("1.a.i", 2, 1, 3)
#numbering("I.", 4)
#assert.eq(numbering("(a)", 3), "(c)")
