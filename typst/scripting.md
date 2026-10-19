# Typst scripting

Patterns here are checked by `assert`s in [examples/scripting.typ](examples/scripting.typ) (Typst 0.14); copy from there.

## Model

- `#` switches markup → code for one expression. `{ .. }` is a code block, `[ .. ]` is a content block; both nest.
- Blocks return the **join** of every value their statements produce. `let`, `set`, assignments produce nothing. So `for` inside `[..]` emits content each iteration; inside `{..}` it joins values (arrays concatenate, strings concatenate).
- Values are immutable-by-copy: `let ys = xs; ys.push(1)` does not touch `xs`. Functions are pure; they can't mutate outer variables (use `state` for cross-document data).
- No `null`: use `none`. Missing keys error; use `.at(k, default: ..)`.
- `str` vs `content`: `"a" + "b"` is `str`; `[a] + [b]` is content. Convert `str(x)`, `[#x]`, `repr(x)` for debugging.
- Type checks: `type(x) == str`, `type(x) == content`, `type(x) == dictionary`.

## Syntax quick ref

| Thing | Code |
|---|---|
| Bind / destructure | `let (a, b) = (1, 2)`, `let (x: px, ..rest) = dict`, `let (first, .., last) = arr` |
| If / else | `if c { .. } else if d { .. } else { .. }` (an expression) |
| Loops | `for x in arr { .. }`, `for (k, v) in dict { .. }`, `for (i, x) in arr.enumerate()`, `while c { .. }`, `break`, `continue` |
| One-element array | `(1,)`; empty dict `(:)` |
| Function | `let f(x, y: 2, ..rest) = ..`; closure `x => x + 1`; `(a, b) => ..` |
| Partial | `f.with(y: 3)` |
| Spread | `f(..arr)`, `(..d1, ..d2)`, `table(..cells)` |
| Method chain | `xs.filter(..).map(..).join(", ")` |
| Errors | `assert(c, message: "..")`, `assert.eq(a, b)`, `panic("..")` |
| Modules | `#import "lib.typ": f, g as h`, `#import "lib.typ"` then `lib.f()` |

## Standard library you'll use

- Arrays: `len at first last push pop insert remove slice contains find position filter map fold sum product sorted(key:) rev dedup enumerate zip chunks windows flatten join split range(n)`.
- Dicts: `at insert remove keys values pairs len`, `k in d`.
- Strings: `len split replace slice trim starts-with ends-with contains find matches(regex(..)) upper lower`, `"x" * 3`.
- `calc`: `abs pow sqrt exp ln log sin cos round(digits:) floor ceil min max rem quo pi e`.
- `datetime.today()`, `datetime(year:, month:, day:)`, `.display("[day]/[month]/[year]")`.
- Data files: `csv("a.csv")` (array of rows), `json("a.json")`, `yaml(..)`, `toml(..)`, `read("a.txt")`. Paths resolve relative to the file and must be inside `--root`.

## Documents as code

```typ
// template: lib.typ
#let conf(title: none, doc) = {
  set text(size: 10pt)
  align(center, text(14pt, strong(title)))
  doc
}
// main.typ
#show: conf.with(title: [My notes])
```

- Show rule with function: `#show heading.where(level: 2): it => text(blue, it.body)`. Fields: `it.body`, `it.level`, `it.numbering`; inspect with `repr(it)` or `it.fields()`.
- Selectors: `heading.where(level: 1)`, `figure.where(kind: table)`, `<label>`, `selector(a).or(b)`, `"text"`, `regex("..")`.
- Generate tables: `table(columns: 2, ..rows.flatten().map(v => [#v]))`.

## Introspection (needs `context`)

- `context counter(page).get()`, `counter(heading).display()`, custom `counter("x")` with `.step()`/`.update(n)`.
- `state("key", init)` with `.update(v)` / `.update(old => new)`, read `context st.get()` or `st.final()`.
- `context query(heading)` → list of elements; `here()`, `locate(<label>)`, `.location().page()`.
- Values computed inside `context` are content; you can't pull them out into a `let` outside it. Do the work inside the `context` block.

## CLI hooks

- `typst compile f.typ --input mode=draft` → `sys.inputs.at("mode", default: "final")` (always strings).
- `typst query f.typ "<label>" --field value` dumps metadata as JSON; pair with `#metadata(x) <label>`.
- Debug: put `#repr(value)` in the doc, or a failing `assert.eq` to print the actual value.
