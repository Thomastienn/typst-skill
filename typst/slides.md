# Slides

Compiled: [examples/slides.typ](examples/slides.typ) (touying 0.8.0). Fallback: [examples/slides-polylux.typ](examples/slides-polylux.typ).

Prefer **touying** for new decks. Polylux only when the file already uses it. Touying 0.8 needs Typst **0.15**. Pass metadata through `config-info(..)`; it is optional when no metadata is needed. Theme layout arguments such as `aspect-ratio` still go directly on the theme function. See the [author's documentation](https://typst.app/universe/package/touying/).

## Touying 0.8

```typ
#import "@preview/touying:0.8.0": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Title], subtitle: [Sub], author: [Ada],
    date: datetime.today(), institution: [Lab],
  ),
)
#title-slide()
#outline-slide(level: 1)

= Section          // section slide
== Slide title     // one slide
#pause
Revealed next.

#slide(composer: (1fr, 1fr))[left][right]
#slide(title: [Explicit])[body]
#speaker-note[+ talking point]
```

Themes (import `themes.<name>`): `metropolis`, `university`, `dewdrop`, `aqua`, `stargazer`, `simple`, `default`. Extra: `metropolyst` 0.1.0.

| Feature | Call |
|---|---|
| Pause | `#pause` (also works inside `$ … pause … $`) |
| Parallel | `#meanwhile` (counter restarts) |
| Keep space | `#uncover("2-")[..]` / `#uncover(2)[..]` |
| No space | `#only(3)[..]` |
| Cycle | `#alternatives[A][B][C]` |
| Callback | `#slide(repeat: 3, self => [ #let (uncover, only) = utils.methods(self); … ])` |
| Columns | `#slide(composer: (1fr, 1fr))[..][..]` or `#cols(columns: (2fr, 1fr))[..][..]` |
| Focus | `#focus-slide[Questions?]` |
| Appendix | `#show: appendix` then more `=` / `==` (not counted in footer) |
| Handout | `config-common(handout: true)` or `--input export-mode=handout` |
| Notes on side | `config-common(show-notes-on-second-screen: right)` |

Annotate a phrase: `pinit` 0.2.2 `#pin(1)text#pin(2)` + `#pinit-highlight(1, 2)` + `#pinit-point-from(2)[note]`.

Export: `typst compile slides.typ` → multi-page PDF (one page per subslide). PNG: `typst compile slides.typ /tmp/s-{p}.png --ppi 72`.

## Polylux 0.4

```typ
#import "@preview/polylux:0.4.0": *
#set page(paper: "presentation-16-9")
#slide[= Title]
#slide[Always. #uncover(2)[Later.] #only(3)[Only 3.]]
```

## Gotchas

- Touying 0.8 `config-info` / `config-common` / `config-colors` — not the old theme-specific named args from blog posts.
- `#pause` in markup splits subslides; wrapping a whole slide in `#slide[..]` is required for `composer` / `repeat`.
- Heading numbering on slides: `#set heading(numbering: "1.")` is optional; section slides use `=`.
