#!/usr/bin/env bash
# Compiles every example; fails on errors or warnings.
set -euo pipefail
cd "$(dirname "$0")/typst/examples"
out=$(mktemp -d)
trap 'rm -rf "$out"' EXIT

compile() {
  typst compile "$@" 2>&1 | tee "$out/diagnostics" >&2
  ! grep -q '^warning:' "$out/diagnostics"
}

shopt -s nullglob
for f in *.typ; do
  compile "$f" "$out/${f%.typ}.pdf"
  echo "ok  $f"
done
compile homework.typ --input answers=1 "$out/homework-answers.pdf"
echo "ok  homework.typ --input answers=1"
