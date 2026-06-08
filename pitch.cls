% SPDX-FileCopyrightText: Copyright (c) 2024-2025 Zerocracy
% SPDX-License-Identifier: MIT

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pitch}[Package for Pitches]
\LoadClass{article}

\RequirePackage{fontspec}
  \setmainfont{PT Serif}
  \setsansfont{PT Sans}
  \setmonofont{PT Mono}
\RequirePackage{microtype}
\RequirePackage{tikz}
  \usetikzlibrary{arrows}
  \usetikzlibrary{arrows.meta}
\RequirePackage[export]{adjustbox}
\RequirePackage{anyfontsize}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{href-ul}
\RequirePackage{csquotes}
\RequirePackage{textcomp}
\RequirePackage{iexec}
  \iexec[quiet,log]{wget --quiet --no-check-certificate --no-clobber https://www.zerocracy.com/svg/logo.svg}
\RequirePackage{svg}
\RequirePackage{multicol}
\RequirePackage{setspace}
\RequirePackage[paperwidth=11in, paperheight=5in]{geometry}
\RequirePackage{hyperref}
  \hypersetup{colorlinks=true,allcolors=blue}
\RequirePackage{xcolor}
  \iexec[quiet,log]{wget --quiet --no-check-certificate --no-clobber https://www.zerocracy.com/css/palette.css}
  \iexec{grep -oE '\\.[a-zA-Z0-9_-]+\\\{color:.[0-9a-fA-F]+' < palette.css | sed -E 's/\\.([a-zA-Z0-9_-]+)\\\{color:.([0-9a-fA-F]+)/\\\\definecolor\{\\1\}\{HTML\}\{\\2\}/' > palette.tex}
  \input{palette.tex}
\RequirePackage{graphicx}
\pagestyle{empty}

\renewcommand\emph[1]{\textcolor{red}{#1}}

\newcommand\slide[1]{%
  \pagebreak\topskip0pt\vspace*{\fill}%
  \begin{center}\LARGE%
  #1
  \end{center}%
  \vspace*{\fill}}

\color{black}
\pagecolor{steel}
\sffamily

\newcommand\pitchFinal{
  \slide{
  \href{https://www.zerocracy.com}{zerocracy.com}
  \par
  \vspace*{1em}
  {\large
  \href{https://t.me/zerocracy}{Telegram}
  \(\cdot\)
  \href{https://www.linkedin.com/company/zerocracy/}{LinkedIn}
  \(\cdot\)
  \href{https://www.github.com/zerocracy/}{GitHub}
  \(\cdot\)
  \href{https://www.youtube.com/playlist?list=PLaIsQH4uc08yC4-991xt-SGSisteMtD_w}{YouTube}
  \(\cdot\)
  \href{https://instagram.com/zerocracy}{Instagram}
  \par}
  \vspace*{1em}
  {\large\href{mailto:team@zerocracy.com}{team@zerocracy.com}\par}}}

\endinput
