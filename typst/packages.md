# Package pins

The listed package pins import on Typst **0.15.1** (checked 2026-10-19); `basic-resume` emits dependency warnings. Imports alone do not verify every API or the package's template. The bundled examples exercise representative APIs from these guides. Prefer the file's existing version if already imported. Author documentation: [Typst Universe](https://typst.app/universe/).

## Default stack

| Use | Import |
|---|---|
| Theorems / notes | `@preview/theorion:0.6.0` |
| Physics math | `@preview/physica:0.9.8` |
| Drawing | `@preview/cetz:0.5.2` |
| Function plots | `@preview/cetz-plot:0.1.4` |
| Data plots | `@preview/lilaq:0.6.0` |
| Node/arrow diagrams | `@preview/fletcher:0.5.8` |
| Graphviz | `@preview/diagraph:0.3.7` |
| Slides | `@preview/touying:0.8.0` |
| Code listings | `@preview/codly:2.0.0` + `codly-languages:0.1.10` |
| SI units | `@preview/unify:0.8.1` (or `zero:0.7.1`) |

## Additional import-checked pins

`cetz-venn:0.2.0` `polylux:0.4.0` `pinit:0.2.2` `metropolyst:0.1.0` `zebraw:0.6.3` `subpar:0.2.2` `i-figured:0.2.4` `headcount:0.1.1` `tablem:0.3.0` `rowmantic:0.5.0` `wrap-it:0.1.1` `oasis-align:0.4.1` `meander:0.4.4` `hydra:0.6.3` `glossarium:0.5.10` `acrostiche:0.7.0` `glossy:0.9.2` `showybox:2.0.4` `gentle-clues:1.3.1` `note-me:0.6.0` `great-theorems:0.1.2` `ctheorems:2.0.0` `frame-it:2.0.0` `marginalia:0.3.1` `drafting:0.2.2` `dashy-todo:0.1.3` `cheq:0.4.0` `itemize:0.2.0` `numbly:0.1.0` `droplet:0.3.1` `lovelace:0.3.1` `algorithmic:1.0.7` `curryst:0.6.0` `simplebnf:0.2.0` `typsium:0.3.2` `whalogen:0.3.0` `alchemist:0.2.0` `mannot:0.4.0` `mitex:0.2.7` `cmarker:0.1.10` `oxifmt:1.0.0` `suiji:0.5.1` `quill:0.8.0` `finite:0.5.1` `chronos:0.3.0` `zap:0.6.0` `tiaoma:0.3.0` `timeliney:0.4.0` `gantty:0.5.1` `plotsy-3d:0.2.1` `neural-netz:0.3.0` `fontawesome:0.6.2` `charged-ieee:0.1.4` `clean-math-paper:0.2.8` `arkheion:0.1.2` `ilm:2.1.1` `tufte-memo:0.1.2` `brilliant-cv:4.1.1` `modern-cv:0.10.0` `basic-resume:0.2.9`

## Rules

- Template results and font requirements: [documents.md](documents.md). In particular, the `tufte-memo:0.1.2` template fails on 0.15.1, and `basic-resume:0.2.9` pulls `scienceicons:0.1.0`, which emits raw-text deprecation warnings. Do not claim these compile cleanly or change their pins without approval.
- Pin the version. `#import "@preview/cetz:0.5.2"` not `@preview/cetz`.
- Packages may pull their **own** CeTZ (fletcher → 0.3.x). Draw in `cetz.canvas` using the `cetz` **you** imported.
- `typst init @preview/<template>:<ver> dir` then compile; do not restyle the whole template.
- Local package: `@local/name:0.1.0` under `$XDG_DATA_HOME/typst/packages/local/`.
