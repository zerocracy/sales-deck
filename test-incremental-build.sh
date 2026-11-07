#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Zerocracy
# SPDX-License-Identifier: MIT

set -euo pipefail
makefile="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT
mkdir "$scratch/bin" "$scratch/build"
cat > "$scratch/bin/latexmk" <<'LATEXMK'
#!/usr/bin/env bash
set -euo pipefail
printf '%s\n' "${!#}" >> "$BUILD_LOG"
LATEXMK
chmod +x "$scratch/bin/latexmk"
export PATH="$scratch/bin:$PATH"
export BUILD_LOG="$scratch/calls.log"
cd "$scratch/build"
for file in sales-deck.tex founder-pitch.tex pitch.cls .latexmkrc vitals.png palette.tex; do
  touch -t 202601010000 "$file"
done
touch -t 202601020000 sales-deck.pdf founder-pitch.pdf
for dependency in pitch.cls .latexmkrc vitals.png palette.tex; do
  touch -t 202601030000 "$dependency"
  : > "$BUILD_LOG"
  make --no-print-directory -f "$makefile" all
  if ! grep -qx sales-deck.tex "$BUILD_LOG"; then
    echo "FAIL: sales-deck.tex was not checked after $dependency changed" >&2
    exit 1
  fi
  if [[ "$dependency" != vitals.png ]] && ! grep -qx founder-pitch.tex "$BUILD_LOG"; then
    echo "FAIL: founder-pitch.tex was not checked after $dependency changed" >&2
    exit 1
  fi
  touch -t 202601010000 "$dependency"
done
echo 'PASS: shared class, configuration, image and generated palette changes reach latexmk'
