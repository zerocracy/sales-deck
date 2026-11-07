# Sales Deck of Zerocracy

[![make](https://github.com/zerocracy/sales-deck/actions/workflows/latexmk.yml/badge.svg)](https://github.com/zerocracy/sales-deck/actions/workflows/latexmk.yml)

This is the
[PDF](https://zerocracy.github.io/sales-deck/sales-deck.pdf).

To build it, just run:

```bash
make
```

Make refreshes `logo.svg` and `palette.css` from the Zerocracy website and
generates `palette.tex` before checking whether the PDFs need rebuilding.
Unchanged files keep their timestamps.

You need to have
[`aspell`](http://aspell.net/),
LaTeX (with packages from [`DEPENDS.txt`](DEPENDS.txt)),
[`texsc`](https://rubygems.org/gems/texsc),
and
[`texqc`](https://rubygems.org/gems/texqc)
installed.

macOS:

```bash
brew install aspell texlive
gem install texsc texqc
```

Linux (Ubuntu/Debian):

```bash
sudo apt-get install aspell texlive-xetex texlive-fonts-extra
gem install texsc texqc
```

The asset refresh regressions can also run without LaTeX: `make test-assets`.
