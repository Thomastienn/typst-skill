#!/usr/bin/env bash
# Compiles every example; fails if any snippet in the skill broke.
set -euo pipefail
cd "$(dirname "$0")/typst/examples"
out=$(mktemp -d)
for f in *.typ; do
  typst compile "$f" "$out/${f%.typ}.pdf" && echo "ok  $f"
done
