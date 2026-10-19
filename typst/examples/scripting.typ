// Typst scripting. Every assert must hold; compiling = testing.
#set page(width: 16cm, height: auto, margin: 1cm)

// Types and conversion
#assert.eq(type(1), int)
#assert.eq(type("a"), str)
#assert.eq(type([a]), content)
#assert.eq(str(42), "42")
#assert.eq(int("7") + float("0.5"), 7.5)
#assert.eq(repr((1, "a")), "(1, \"a\")")

// Bindings and destructuring
#let (a, b) = (1, 2)
#let (x: px, ..rest) = (x: 1, y: 2, z: 3)
#let (first, .., last) = (1, 2, 3, 4)
#assert.eq((a, b, px, first, last), (1, 2, 1, 1, 4))
#assert.eq(rest, (y: 2, z: 3))

// Control flow: blocks return the joined values of their statements
#let sign(n) = if n > 0 { "+" } else if n < 0 { "-" } else { "0" }
#assert.eq(sign(-3), "-")
#let total = {
  let s = 0
  for i in range(1, 6) { if i == 4 { continue }; s += i }
  s
}
#assert.eq(total, 11)
#let n = 0
#while n < 3 { n += 1 }
#assert.eq(n, 3)

// Arrays
#let xs = (3, 1, 2)
#assert.eq(xs.len(), 3)
#assert.eq(xs.sorted(), (1, 2, 3))
#assert.eq(xs.map(x => x * 2), (6, 2, 4))
#assert.eq(xs.filter(x => x > 1), (3, 2))
#assert.eq(xs.fold(0, (acc, x) => acc + x), 6)
#assert.eq(xs.sum(), 6)
#assert.eq(xs.enumerate().at(1), (1, 1))
#assert.eq(xs.zip(("a", "b", "c")).first(), (3, "a"))
#assert.eq(xs.contains(2), true)
#assert.eq(xs.at(-1), 2)
#assert.eq(xs.at(9, default: none), none)
#assert.eq(().first(default: 7), 7)
#assert.eq(().last(default: 8), 8)
#assert.eq(().join(default: "x"), "x")
#assert.eq(("b", "a").join(", "), "b, a")
#assert.eq(((name: "z", v: 1), (name: "a", v: 2)).sorted(key: d => d.name).first().v, 2)
#assert.eq(range(4).chunks(2), ((0, 1), (2, 3)))
#assert.eq((1, 2, 2, 3).dedup(), (1, 2, 3))
#assert.eq((1, 2, 3).windows(2), ((1, 2), (2, 3)))
#assert.eq((1, 2, 3).find(x => x > 1), 2)
#assert.eq((1, 2, 3).position(x => x == 3), 2)
#let ys = (1,)
#let zs = ys
#zs.push(2)
#assert.eq(ys, (1,))

// Dictionaries
#let d = (name: "Ada", age: 36)
#d.insert("lang", "en")
#assert.eq(d.keys(), ("name", "age", "lang"))
#assert.eq(d.at("age"), 36)
#assert.eq(d.at("missing", default: 0), 0)
#assert.eq(d.pairs().first(), ("name", "Ada"))
#assert.eq((..d, age: 37).age, 37)
#assert("age" in d)
#assert.eq(type((:)), dictionary)
#assert.eq((a: 1, b: 2).map(v => v + 1), (a: 2, b: 3))
#assert.eq((a: 1, b: 2).filter(v => v > 1), (b: 2))
#assert.eq(range(3, inclusive: true), (0, 1, 2, 3))

// Strings
#let s = "Hello, World"
#assert.eq(s.split(", "), ("Hello", "World"))
#assert.eq(s.replace("World", "Typst"), "Hello, Typst")
#assert.eq(s.slice(0, 5), "Hello")
#assert.eq(s.starts-with("He"), true)
#assert.eq(upper("ab"), "AB")
#assert.eq(lower("AB"), "ab")
#assert.eq("a1b22".matches(regex("\d+")).map(m => m.text), ("1", "22"))
#assert.eq("x" * 3, "xxx")

// Functions: defaults, named args, sinks, closures, partial application
#let greet(name, greeting: "Hi") = greeting + ", " + name
#assert.eq(greet("Bo"), "Hi, Bo")
#assert.eq(greet.with(greeting: "Yo")("Bo"), "Yo, Bo")
#let count(..args) = args.pos().len() + args.named().len()
#assert.eq(count(1, 2, k: 3), 3)
#let adder(k) = x => x + k
#assert.eq(adder(2)(3), 5)
#let fact(n) = if n <= 1 { 1 } else { n * fact(n - 1) }
#assert.eq(fact(5), 120)

// calc and datetime
#assert.eq(calc.pow(2, 10), 1024)
#assert.eq(calc.round(calc.pi, digits: 2), 3.14)
#assert.eq(calc.rem(7, 3), 1)
#assert.eq(datetime(year: 2026, month: 1, day: 2).display("[day]/[month]/[year]"), "02/01/2026")

// Generating content from data
#let rows = (("Ada", 36), ("Alan", 41))
#table(columns: 2, table.header[*Name*][*Age*], ..rows.flatten().map(v => [#v]))
#for (i, (name, age)) in rows.enumerate() [ #(i + 1). #name is #age. ]

// Show rules with functions, and a template
#show heading.where(level: 2): it => text(fill: blue, it.body)
#let conf(title: none, doc) = {
  set text(size: 10pt)
  align(center, text(14pt, strong(title)))
  doc
}
#show: conf.with(title: [Templated])

== Blue level-2 heading

// State, counters, query (need context)
#context assert.eq(target(), "paged")
#let mood = state("mood", "ok")
#mood.update("great")
#context assert.eq(mood.get(), "great")
#let ex = counter("example")
#ex.step() #ex.step()
#context assert.eq(ex.get(), (2,))
#context assert.eq(query(heading).len(), 1)
#mood.update(old => old + "!")
#context assert.eq(mood.final(), "great!")
#metadata((a: 1)) <meta> // typst eval 'query(<meta>).first().value' --in scripting.typ

#block[_one_ and _two_] <local-emphasis>
#context assert.eq(query(selector(emph).within(<local-emphasis>)).len(), 2)

// CLI inputs: typst compile f.typ --input mode=draft
#let mode = sys.inputs.at("mode", default: "final")
#assert(mode in ("draft", "final"))
