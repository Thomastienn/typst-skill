# CLI and export

Target Typst **0.15.1**. `typst --help` / `typst compile --help` for flags.

## Compile

```
typst compile file.typ                 # PDF inferred
typst compile file.typ out.pdf
typst compile file.typ /tmp/p-{p}.png --ppi 100
typst compile file.typ out.svg
typst compile file.typ --format html --features html out.html
typst watch file.typ                   # recompile on save
typst compile file.typ --root .        # if paths escape the file dir
typst compile file.typ --input mode=draft
typst compile file.typ --pages 1,3-5
typst compile file.typ --open
```

- PNG/SVG multi-page: output name **must** contain `{p}` or `{0p}`. Optional `{t}` adds the total page count; it cannot replace the page number.
- Fonts: `typst fonts`. Extra dirs: `--font-path DIR`. Ignore system: `--ignore-system-fonts`.
- Reproducible dates: `--creation-timestamp 0` or `SOURCE_DATE_EPOCH`.
- Deps for make/nix: `--deps deps.json --deps-format json`.
- 0.15 minifies PDF/SVG/HTML; `--pretty` for readable output.

## PDF standards

```
typst compile file.typ --pdf-standard a-2b
typst compile file.typ --pdf-standard ua-1
typst compile file.typ --pdf-standard ua-1,a-2a   # 0.15: several at once if compatible
```

Values: `1.4`…`2.0`, `a-1b`/`a-1a`/`a-2b`/`a-2u`/`a-2a`/`a-3b`/`a-3u`/`a-3a`/`a-4`/`a-4f`/`a-4e`, `ua-1`. Tagged PDF is default; `--no-pdf-tags` to drop.

In-document: `#pdf.attach("data.csv")` (was `pdf.embed`, removed in 0.15). `#pdf.artifact[..]` marks non-semantic chrome.

## HTML (feature-flagged)

The [official HTML guide](https://typst.app/docs/reference/html/) marks this experimental. Typst emits an expected export warning even for valid HTML; distinguish it from document errors and deprecations.

```
typst compile file.typ --format html --features html
```

- Equations → MathML in 0.15 (better a11y than `html.frame` SVG).
- Typed API: `#html.div[..]`, `#html.video(width: 400, src: "a.mp4")`.
- `html.script` / `html.style` take **strings**, not content: `#html.style("a { color: red }")`.
- `target()` now works without the html feature, but still requires `context`: `#context if target() == "html" [HTML] else [Paged]`. Rest of HTML still needs `--features html`.
- `box`/`block` in HTML follow paged meaning (inline vs block). Extra `<p>` wrapping changed in 0.15 — wrap package HTML in `block` if it should force paragraphs.

Experimental [**bundle** export](https://typst.app/docs/reference/bundle/): `typst compile file.typ out --format bundle --features bundle`. One project emits several files; add `html` to `--features bundle,html` when exporting HTML documents. Skip unless asked.

## Eval / query

0.15: `typst query` is deprecated. Prefer:

```
typst eval 'query(<meta>).first().value' --in file.typ
typst eval '1 + 2'                  # json
typst eval --format yaml 'sys.inputs'
```

In the doc: `#metadata((k: 1)) <meta>`. `--input` values are always strings (`sys.inputs.at("k", default: "x")`).

## Init from a template

```
typst init @preview/charged-ieee:0.1.4 my-paper
cd my-paper && typst compile main.typ
```

More templates: [packages.md](packages.md).
