# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Zerocracy
# SPDX-License-Identifier: MIT

.SHELLFLAGS=-e -o pipefail -c
.ONESHELL:
SHELL=bash
.PHONY: all test clean

ASSETS=vitals.png comment.png office.pdf india-flag.pdf handshake.pdf upwork.pdf logo.pdf

all: sales-deck.pdf founder-pitch.pdf

sales-deck.pdf: $(ASSETS) $(wildcard logo.svg)

%.pdf: %.tex
	latexmk -pdf -latexoption=-interaction=errorstopmode -latexoption=-halt-on-error $<

clean:
	git clean -dfX -e .opencode/
