# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Zerocracy
# SPDX-License-Identifier: MIT

.SHELLFLAGS=-e -o pipefail -c
.ONESHELL:
SHELL=bash
.PHONY: all test clean

all: sales-deck.pdf

sales-deck.pdf: sales-deck.tex
	latexmk -pdf -latexoption=-interaction=errorstopmode -latexoption=-halt-on-error $<

clean:
	git clean -dfX
