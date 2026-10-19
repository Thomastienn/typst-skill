# References, bibliography, glossary

Compiled: [examples/references.typ](examples/references.typ) + [examples/refs.bib](examples/refs.bib).

## Labels and refs

Put the label **on the element**, not on following text:

```typ
#set heading(numbering: "1.")
#set math.equation(numbering: "(1)")
= Section title <sec:x>
$ e^(i pi) + 1 = 0 $ <eq:euler>     // equation refs need numbering
See @sec:x, @sec:x[Section], @eq:euler.
#ref(<sec:x>, supplement: [Sec.])
#link(<sec:x>)[jump]
```

`@sec:x[Section]` changes the supplement before the number. For arbitrary link text, use `#link(<sec:x>)[the intro]`.

`#show ref: it => …` — `it.element` can be `none` for bib keys **or while layout is still discovering the target**; always guard it. Preserve links with `link(el.location(), custom-content)` when replacing a reference. See the [official ref example](https://typst.app/docs/reference/model/ref/#customization). Empty labels error (0.14+).

Footnotes: `#footnote[..] <fn:a>` then reuse `#footnote(<fn:a>)`. Style: `#show footnote.entry: …`.

## Outline

```typ
#outline(title: [Contents], depth: 2, indent: auto)
#show outline.entry.where(level: 1): strong
#outline(target: figure.where(kind: table), title: [Tables])
```

Running chapter in header: `hydra` 0.6.3, or `query(heading.where(level: 1).before(here()))` (see [layout.md](layout.md)).

## Cite and bibliography

```typ
@knuth86 @euclid[p. 7]
#cite(<knuth86>, form: "prose")     // also "author" | "year" | "full" | "normal"
#bibliography("refs.bib", style: "ieee", title: [References])
```

Hayagriva YAML works too (`refs.yml`). CSL: `style: "ieee" | "apa" | "chicago-author-date" | "mla"` or a `.csl` file.

**0.15 renamed styles** (compiler warns):

| Old | New |
|---|---|
| `chicago-fullnotes` | `chicago-notes` |
| `vancouver` | `nlm-citation-sequence` |
| `vancouver-superscript` | `nlm-citation-sequence-superscript` |
| `mla-8` / `modern-language-association-8` | `mla` |
| `council-of-science-editors` | `cse-citation-sequence-brackets-8th-edition` |

Multiple bibliographies (0.15): several `#bibliography(..)` with `target:` (which cites each collects) and `group:` (how numbers share/reset). Default remains one bib at the end.

## Glossary / acronyms

Default: **glossarium 0.5.10**

```typ
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl
#show: make-glossary
#let entry-list = ((key: "pca", short: "PCA", long: "principal component analysis", description: […]),)
#register-glossary(entry-list)
#gls("pca") / #glspl("pca") / @pca
#print-glossary(entry-list)
```

`#show: make-glossary` **before** any `gls`/`@key`. Alternatives: `acrostiche` 0.7.0, `glossy` 0.9.2.

## Gotchas

- `cannot reference text` → label landed on a text node. Move it onto the heading/figure (`= Title <id>`).
- Same label in doc and `.bib` → hint in 0.14+; rename one.
- `@key` before `bibliography()` still works (two-pass). Missing key = error.
