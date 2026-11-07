# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Zerocracy
# SPDX-License-Identifier: MIT

.SHELLFLAGS=-e -o pipefail -c
.ONESHELL:
SHELL=bash
.PHONY: all test test-assets clean FORCE

all: sales-deck.pdf founder-pitch.pdf

logo.svg: FORCE
	temp=$$(mktemp "$@.XXXXXX")
	trap 'rm -f "$${temp}"' EXIT
	wget --quiet -O "$${temp}" https://www.zerocracy.com/svg/logo.svg
	if ! cmp -s "$${temp}" "$@"; then
		mv "$${temp}" "$@"
	fi

palette.css: FORCE
	temp=$$(mktemp "$@.XXXXXX")
	trap 'rm -f "$${temp}"' EXIT
	wget --quiet -O "$${temp}" https://www.zerocracy.com/css/palette.css
	if ! cmp -s "$${temp}" "$@"; then
		mv "$${temp}" "$@"
	fi

palette.tex: palette.css Makefile
	temp=$$(mktemp "$@.XXXXXX")
	trap 'rm -f "$${temp}"' EXIT
	grep -oE '\.[a-zA-Z0-9_-]+\{color:.[0-9a-fA-F]+' < "$<" | sed -E 's/\.([a-zA-Z0-9_-]+)\{color:.([0-9a-fA-F]+)/\\definecolor{\1}{HTML}{\2}/' > "$${temp}"
	if ! cmp -s "$${temp}" "$@"; then
		mv "$${temp}" "$@"
	fi

%.pdf: %.tex logo.svg palette.tex
	latexmk -pdf -latexoption=-interaction=errorstopmode -latexoption=-halt-on-error $<

test: test-assets

test-assets:
	bash test-assets.sh

FORCE:

clean:
	git clean -dfX -e .opencode/
