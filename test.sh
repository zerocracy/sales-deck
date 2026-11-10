#!/bin/bash
# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Zerocracy
# SPDX-License-Identifier: MIT
set -e
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cp Makefile ./*.tex ./*.png ./*.pdf "$tmp"/
cd "$tmp"
: > logo.svg
builds() { make -n "$1" | grep -q latexmk; }
touch -t 202101010000 ./*
touch -t 202201010000 sales-deck.pdf founder-pitch.pdf
if builds sales-deck.pdf; then
  echo 'an up-to-date deck must not rebuild'
  exit 1
fi
for asset in vitals.png comment.png office.pdf india-flag.pdf handshake.pdf upwork.pdf logo.pdf logo.svg; do
  touch -t 202301010000 "$asset"
  if ! builds sales-deck.pdf; then
    echo "$asset must trigger a rebuild"
    exit 1
  fi
  touch -t 202001010000 "$asset"
done
if builds founder-pitch.pdf; then
  echo 'the founder pitch must not rebuild'
  exit 1
fi
touch -t 202401010000 founder-pitch.tex
if ! builds founder-pitch.pdf; then
  echo 'a newer founder pitch must rebuild'
  exit 1
fi
echo ok
