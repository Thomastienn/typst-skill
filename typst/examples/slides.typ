// Touying 0.8.0 deck (metropolis theme): headings, animations, columns, notes, focus slide, appendix.
#import "@preview/touying:0.8.0": *
#import themes.metropolis: *
#import "@preview/pinit:0.2.2": *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Eigenvalues in Practice],
    subtitle: [Week 3 seminar],
    author: [Thomas],
    date: datetime(year: 2026, month: 10, day: 19),
    institution: [CodeBase University],
  ),
  config-article(available-fields: (title: "info.title", author: "info.author")),
  // config-common(handout: true),                       // or: --input export-mode=handout
  // config-common(show-notes-on-second-screen: right),  // notes beside each slide
)

#set heading(numbering: "1.")

#slides-only(title-slide())

#outline-slide(level: 1)

= Basics

== Heading-driven slide

Every `==` starts a slide; every `=` makes a section slide.

#pause

This appears on the second subslide.

#speaker-note[
  + Remind them about last week's determinant trick.
]

== Columns

#slide(composer: (1fr, 1fr))[
  *Left*: definitions.
  - $A bold(v) = lambda bold(v)$
][
  *Right*: intuition.
  - stretch along $bold(v)$
]

#slide(title: [Explicit `#slide`])[
  #cols(columns: (2fr, 1fr), gutter: 1em)[
    Wide column. #lorem(12)
  ][
    #align(center, text(3em)[$lambda$])
  ]
]

= Animations

== Pause and meanwhile

First #pause second #pause third.

#meanwhile

After `#meanwhile` the count restarts: this shows with "First".

== uncover, only, alternatives

#uncover("2-")[`uncover` keeps the space reserved (subslide 2+).]

#only(3)[`only` takes no space when hidden (subslide 3).]

#alternatives[Option A][Option B][Option C]

== Math animation

$
  (a + b)^2 & = pause a^2 + 2 a b + b^2 \
            & pause >= 4 a b
$

== Callback style

#slide(repeat: 3, self => [
  #let (uncover, only, alternatives) = utils.methods(self)
  Subslide #self.subslide of 3.
  #only(2)[Only on two.] #uncover(3)[Shown on three.]
])

== Annotate with pinit

The #pin(1)characteristic polynomial#pin(2) decides everything.

#pinit-highlight(1, 2)

#pinit-point-from(2)[roots = eigenvalues]

#focus-slide[Questions?]

#show: appendix

= Appendix

== Proof details

Appendix slides do not raise the total in the footer.
