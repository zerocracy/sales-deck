#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Zerocracy
# SPDX-License-Identifier: MIT
set -euo pipefail

makefile="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT
cp "$makefile" "$scratch/Makefile"
mkdir "$scratch/bin"
cat > "$scratch/bin/wget" <<'WGET'
#!/usr/bin/env bash
set -euo pipefail
test "$#" -eq 4 && test "$1" = --quiet && test "$2" = -O
case "$4" in
  https://www.zerocracy.com/svg/logo.svg) printf 'same logo' > "$3" ;;
  https://www.zerocracy.com/css/palette.css) printf '.steel{color:#010203}\n' > "$3" ;;
  *) exit 2 ;;
esac
WGET
cat > "$scratch/bin/latexmk" <<'LATEXMK'
#!/usr/bin/env bash
set -euo pipefail
source=${!#}
printf '%s\n' "$source" >> calls.log
cat pitch.cls > "${source%.tex}.pdf"
LATEXMK
chmod +x "$scratch/bin/wget" "$scratch/bin/latexmk"
export PATH="$scratch/bin:$PATH"
cd "$scratch"
printf 'same logo' > logo.svg
printf '.steel{color:#010203}\n' > palette.css
printf '\\definecolor{steel}{HTML}{010203}\n' > palette.tex
printf 'old class' > pitch.cls
touch sales-deck.tex founder-pitch.tex
touch -t 200001010000 Makefile logo.svg palette.css palette.tex pitch.cls sales-deck.tex founder-pitch.tex
for pdf in sales-deck.pdf founder-pitch.pdf; do
  cp pitch.cls "$pdf"
  touch -t 200001020000 "$pdf"
done
: > calls.log
make --no-print-directory all
test ! -s calls.log
printf 'changed class' > pitch.cls
touch -t 200001030000 pitch.cls
make --no-print-directory -j2 all
for source in sales-deck.tex founder-pitch.tex; do
  if ! grep -qx "$source" calls.log; then
    echo "FAIL: $source was not checked after pitch.cls changed" >&2
    exit 1
  fi
  cmp pitch.cls "${source%.tex}.pdf"
done
test "$(wc -l < calls.log)" -eq 2
: > calls.log
make --no-print-directory all
test ! -s calls.log
echo 'PASS: pitch.cls changes reach both latexmk calls; unchanged inputs do not'
