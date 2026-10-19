# Typst scripting

Patterns here are `assert`s in [examples/scripting.typ](examples/scripting.typ) (Typst 0.15). Copy from there.

## Model

- `#` switches markup → code for one expression. `{ .. }` is a code block, `[ .. ]` is a content block; both nest.
- Blocks return the **join** of every value their statements produce. `let`, `set`, assignments produce nothing. So `for` inside `[..]` emits content each iteration; inside `{..}` it joins values (arrays concatenate, strings concatenate).
- Values have copy semantics: `let ys = xs; ys.push(1)` does not touch `xs`. Functions are pure; they can't mutate outer variables. Use `state` for values tracked in document layout order.
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

- Arrays: `len at first last push pop insert remove slice contains find position filter map fold sum product sorted(key:) sorted(by:)` (0.14 `by:` cmp) `rev dedup enumerate zip chunks windows flatten join split range(n)` / `range(end, inclusive: true)` (0.15). `.first(default:)` / `.last(default:)` / `.join(default:)`.
- Dicts: `at insert remove keys values pairs len`, 0.15 `map`/`filter` over **values** (`d.map(v => v + 1)`), `k in d`. `in` also checks **module** definitions (0.14).
- String methods: `len split replace slice trim starts-with ends-with contains find matches(regex(..))`; `"x" * 3`. Case conversion uses functions: `upper("ab")`, `lower("AB")`.
- `calc`: `abs pow sqrt exp ln log sin cos round(digits:) floor ceil min max rem quo pi e`.
- `datetime.today()`, `datetime(year:, month:, day:)`, `.display("[day]/[month]/[year]")`.
- Data files: `csv("a.csv")` (array of rows), `json("a.json")`, `yaml(..)`, `toml(..)` (always a dict), `xml(..)` (0.15 namespaces), `read("a.txt")`. 0.15 `path` type: construct in one file, pass into a package, still resolved vs the original file. No `json.decode` — pass `bytes` to `json()`. Paths: `/` only.

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
- Selectors: `heading.where(level: 1)`, `figure.where(kind: table)`, `<label>`, `selector(a).or(b)`, `"text"`, `regex("..")`. The [selector reference](https://typst.app/docs/reference/foundations/selector/) documents `selector(emph).within(<label>)` (0.15: descendants of an ancestor). `before`/`after`/`within` work with introspection, not show rules. Many elements are locatable without a label (0.14+: `par`, `table`, `image`, `link`, …).
- Generate tables: `table(columns: 2, ..rows.flatten().map(v => [#v]))`.

## Introspection (needs `context`)

- `context counter(page).get()`, `counter(heading).display()`, custom `counter("x")` with `.step()`/`.update(n)`.
- `state("key", init)` with `.update(v)` / `.update(old => new)`, read `context st.get()` or `st.final()`.
- `context query(heading)` → list of elements; `here()`, `locate(<label>)`, `.location().page()`.
- Values computed inside `context` are content; you can't pull them out into a `let` outside it. Do the work inside the `context` block.

## CLI hooks

- `typst compile f.typ --input mode=draft` → `sys.inputs.at("mode", default: "final")` (always strings).
- Dump metadata: `typst eval 'query(<meta>).first().value' --in f.typ` (0.15; `typst query` deprecated). Pair with `#metadata(x) <meta>`.
- Debug: `#repr(value)` in the doc, or a failing `assert.eq`. `panic("msg")` prints the string as-is in 0.15.
