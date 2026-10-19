// Polylux 0.4.0 minimal deck. Prefer touying for new slides (see slides.typ).
#import "@preview/polylux:0.4.0": *
#set page(paper: "presentation-16-9")
#set text(size: 25pt)

#slide[
  #set align(horizon)
  = Polylux fallback

  Use touying unless the file already uses polylux.
]

#slide[
  == Reveal

  Always visible.
  #uncover(2)[Appears on subslide 2.]
  #only(3)[Only on subslide 3.]
]
