# Errors and 0.15 changes

## Common compile errors

| Message | Fix |
|---|---|
| `unknown variable: xy` in math | Space letters `x y`, or `"xy"` |
| `expected content, found …` | Wrap `[…]` or `str()` / `[#x]` |
| `cannot access file system outside of project root` | `typst compile --root <dir>` |
| `package not found` | Exact `name:version` from [packages.md](packages.md) |
| `unknown font family` | `typst fonts`; check spelling |
| `… is deprecated, use … instead` | Apply the new name; warnings fail the skill's bar |
| `cannot reference text` | Label is on a text node. Use `= Title <id>` |
| `layout did not converge` | 0.15 prints **which** context/state loops. Stop reading a counter you also update, or move work out of `context` |
| `unknown symbol modifier` (`angle.l`, `planck.reduce`) | `chevron.l`, `planck` |
| `unknown variable: sect` | `inter` |
| `context` / `can only be used within` | Read counters/state/`here()` **inside** `context { }` |

Debug: `#repr(x)` in the page, or a failing `#assert.eq(got, want)` (prints both). CLI: `typst eval 'query(<id>)' --in file.typ`.

## 0.15 breaking (skill targets 0.15.1)

| Change | What to write |
|---|---|
| `path` element gone | `curve` + `curve.move`/`line`/`cubic`/`close` |
| `pattern` type gone | `tiling` |
| `pdf.embed` gone | `pdf.attach` |
| `json.decode` etc. gone | `json(bytes)` / `json("f.json")` |
| Backslash in paths | always `/` |
| `box` baseline kept | visually recheck old `dy` compensations |
| `html.script`/`style` | string body only |
| SVG classes `typst-frame` etc. | no longer emitted |
| Variable font suffixes | drop `"Variable"`/`"Var"`/`"VF"` from `text.font` |
| NCM calligraphic | old look: `#show math.equation: set text(stylistic-set: 6)` |
| `chevron.l(x)` in math | now an `lr` delimiter, not a fallback print |
| `query` CLI | `typst eval 'query(<id>)' --in file.typ` |

0.14 already removed `int == "integer"` type/string compares; use `type(x) == int`.

## Deprecations still warned on 0.15

`sect`, `angle.l/r`, and `planck.reduce` were **removed** in 0.15; the replacements above are required. Still-warned deprecations include ambiguous raw language tags, renamed citation styles, and fallback to Arabic for numbering systems that cannot express 0 (e.g. `"⓵"`). See the [official deprecations and removals](https://typst.app/docs/changelog/0.15.0/#deprecations).
