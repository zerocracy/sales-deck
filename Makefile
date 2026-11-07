# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Zerocracy
# SPDX-License-Identifier: MIT

.SHELLFLAGS=-e -o pipefail -c
.ONESHELL:
SHELL=bash
.PHONY: all test clean FORCE

all: sales-deck.pdf founder-pitch.pdf

# Let latexmk check all recorded inputs, not only the top-level TeX file.
%.pdf: %.tex FORCE
	latexmk -pdf -latexoption=-interaction=errorstopmode -latexoption=-halt-on-error $<

FORCE:

test:
	bash test-incremental-build.sh Makefile

clean:
	git clean -dfX -e .opencode/
