#!/usr/bin/env bash
# Build and validate the CTAN distribution package under ctan/tongjithesis/.
#
# Single source of truth for the CTAN file set, shared by two workflows so the
# two can never drift apart:
#   - .github/workflows/release.yml  packages ctan/ into the release archives
#   - .github/workflows/test.yaml    runs this, then compiles the packaged
#                                    example to prove the package is usable
#
# Run from the repository root. Requires: CURRENT_YEAR, PACKAGE_AUTHOR
# (release.yml exports both; defaults below keep local runs working).
set -euo pipefail

CURRENT_YEAR="${CURRENT_YEAR:-$(date +%Y)}"
PACKAGE_AUTHOR="${PACKAGE_AUTHOR:-TJ-CSCCG}"

# The class hard-errors (\ClassError) without tongji-circled.def and the
# tongji-cjk-font-*.def matching the requested fontset, so every .def
# under style/ is a required runtime file, not an optional extra.
for f in style/tongjithesis.cls style/tongjithesis.cfg \
         style/tongji-circled.def \
         style/font/tongji-cjk-font-fandol.def \
         style/font/tongji-cjk-font-mac.def \
         style/font/tongji-cjk-font-windows.def \
         style/font/tongji-cjk-font-adobe.def \
         style/font/tongji-cjk-font-founder.def \
         figures/tongji.pdf figures/tongji-header.pdf; do
  [ -f "$f" ] || { echo "Error: $f not found"; exit 1; }
done
echo "All required source files present"

mkdir -p ctan/tongjithesis/example/figures ctan/tongjithesis/example/bib

# Copy class files. The .def files ship flat alongside the .cls: the class
# \input's them by bare filename, so kpathsea resolves them from the same
# texmf directory the user installs the class into.
cp style/tongjithesis.cls style/tongjithesis.cfg ctan/tongjithesis/
cp style/tongji-circled.def style/font/tongji-cjk-font-*.def ctan/tongjithesis/
cp figures/tongji.pdf figures/tongji-header.pdf ctan/tongjithesis/example/figures/
# example.tex calls \tjbibresource{bib/note.bib} + \makereferences, so the
# bibliography database has to ship with it or the example cannot compile.
cp bib/note.bib ctan/tongjithesis/example/bib/

# Generate LICENSE
cat > ctan/tongjithesis/LICENSE << HEREDOC
Copyright (C) 2022-${CURRENT_YEAR} TJ-CSCCG

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
The latest version of this license is in
  http://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions of LaTeX
version 2003/12/01 or later.

This work has the LPPL maintenance status "maintained".

The Current Maintainer of this work is ${PACKAGE_AUTHOR}.

This work consists of the files:
- tongjithesis.cls (main class file)
- tongjithesis.cfg (configuration file)
- tongji-circled.def (circled numeral support)
- tongji-cjk-font-*.def (per-fontset CJK font definitions)
- README.md (documentation)
- example/ (example files)
HEREDOC

# Generate README
cat > ctan/tongjithesis/README.md << 'HEREDOC'
# Tongji University Undergraduate Thesis Template

## Overview

`tongjithesis` is a LaTeX class for creating undergraduate theses that comply with the official requirements of Tongji University, China. This template is designed to help students focus on content creation rather than formatting details.

## Features

- Compliant with Tongji University's official undergraduate thesis requirements
- Support for both one-sided and two-sided printing
- Comprehensive formatting for title page, abstract, table of contents, chapters, etc.
- Customized citation styles that comply with Chinese GB/T 7714-2025 standard
- Support for code listings with syntax highlighting (minted or listings)
- Integration of mathematical formulas, figures, tables, and algorithms
- Standalone task book, opening report and mid-term report documents via the
  `doctype` class option

## Requirements

- A complete TeX distribution (TeX Live 2026+, MiKTeX, or MacTeX)
- XeLaTeX or LuaLaTeX engine (the template doesn't support pdfLaTeX)
- Python with Pygments installed (optional, for minted code highlighting)

## Installation

1. **Manual Installation**:
   - Copy `tongjithesis.cls`, `tongjithesis.cfg`, `tongji-circled.def` and the
     `tongji-cjk-font-*.def` files to your project directory, or
   - Install to your local texmf tree (recommended)

   All of these files are required: the class `\input`s `tongji-circled.def` and the
   `tongji-cjk-font-<fontset>.def` matching the `fontset` option, and errors out if
   either is missing. Keep them in the same directory as the class.

2. **Install to TEXMF tree**:
   - For TeX Live on Unix-like systems: `~/texmf/tex/latex/tongjithesis/`
   - For MiKTeX on Windows: `%USERPROFILE%\texmf\tex\latex\tongjithesis\`
   - For MacTeX: `~/Library/texmf/tex/latex/tongjithesis/`

## Basic Usage

```latex
\documentclass[oneside]{tongjithesis}  % Use 'twoside' for double-sided printing

\tjbibresource{bib/note.bib}

\school{计算机科学与技术学院}
\major{计算机科学与技术}
\student{1234567}{张三}
\thesistitle{论文标题}{——副标题}
\thesistitleeng{Thesis Title}{--- Subtitle}
\thesisadvisor{李四 教授}
\thesisdate{2026}{6}{1}

\begin{document}
\MakeCover
\cleardoublepage

\frontmatter
\MakeAbstract{摘要内容}{关键词1，关键词2}
\MakeAbstractEng{Abstract content}{Keyword1, Keyword2}
\clearpage
\tableofcontents
\cleardoublepage

\mainmatter
\chapter{引言}
% ... your content ...

\makereferences
\end{document}
```

## Documentation

For detailed documentation, please refer to the GitHub repository.

## License

This template is licensed under the LaTeX Project Public License (LPPL) version 1.3c or later.

## Links

- GitHub: https://github.com/TJ-CSCCG/TongjiThesis
- Overleaf: https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn
HEREDOC

# Generate MANIFEST
cat > ctan/tongjithesis/MANIFEST << 'HEREDOC'
README.md                     # Package description and usage information
LICENSE                       # License information
tongjithesis.cls              # Main LaTeX class file
tongjithesis.cfg              # Configuration file
tongji-circled.def            # Circled numeral glyph support
tongji-cjk-font-fandol.def    # CJK fonts: fandol  (fontset=fandol)
tongji-cjk-font-mac.def       # CJK fonts: macOS   (fontset=mac)
tongji-cjk-font-windows.def   # CJK fonts: Windows (fontset=windows)
tongji-cjk-font-adobe.def     # CJK fonts: Adobe   (fontset=adobe)
tongji-cjk-font-founder.def   # CJK fonts: Founder (fontset=founder)
example/                      # Example directory
  example.tex                 # Example thesis document
  bib/                        # Bibliography directory
    note.bib                  # Example bibliography database
  figures/                    # Figures directory
    tongji.pdf               # Tongji University logo for cover
    tongji-header.pdf        # Tongji University logo for page header
HEREDOC

# Generate example
cat > ctan/tongjithesis/example/example.tex << 'HEREDOC'
%!TEX program = xelatex
%!TEX encoding = UTF-8

\documentclass[
  oneside,
  degree=bachelor,
  fullwidthstop=false,
  fontset=fandol,
  times=false,
  minted=false,
  biblatex=true,
]{tongjithesis}

\tjbibresource{bib/note.bib}

% Set thesis information
\school{计算机科学与技术学院}
\major{计算机科学与技术}
\student{1234567}{张三}
\thesistitle{基于机器学习的图像分类研究}{——以交通标志识别为例}
\thesistitleeng{Research on Image Classification Based on Machine Learning}{——Take Traffic Sign Recognition as an Example}
\thesisadvisor{李四 教授}
\thesisdate{2026}{4}{20}

% 信息说明页配置
\infotype{thesis}
\infoabstract{本文研究了基于机器学习的图像分类技术，并以交通标志识别为应用场景进行了实验验证。}
\infothesiswords{10000}
\infomaterials{\item 程序源代码}

\begin{document}

% Generate cover and info page
\MakeCover
\cleardoublepage
\MakeInfoPage
\cleardoublepage

% Front matter: abstract and table of contents
\frontmatter
\MakeAbstract{
    本文研究了基于机器学习的图像分类技术，并以交通标志识别为应用场景进行了实验验证。
    图像分类是计算机视觉中的基础任务，具有广泛的应用前景。本文首先综述了图像分类领域的经典算法和最新进展，
    然后提出了一种改进的卷积神经网络模型用于交通标志识别。实验结果表明，所提出的方法在准确率和计算效率方面
    均取得了良好的性能。
}{机器学习; 图像分类; 卷积神经网络; 交通标志识别}

% English Abstract
\MakeAbstractEng{
    This paper investigates image classification techniques based on machine learning,
    with traffic sign recognition as an application scenario for experimental validation.
    Image classification is a fundamental task in computer vision with extensive application prospects.
    This paper first reviews classic algorithms and recent advances in the field of image classification,
    then proposes an improved convolutional neural network model for traffic sign recognition.
    Experimental results demonstrate that the proposed method achieves good performance in terms of
    accuracy and computational efficiency.
}{Machine Learning; Image Classification; Convolutional Neural Network; Traffic Sign Recognition}

% Table of contents
\clearpage
\tableofcontents
\cleardoublepage

% Main matter: thesis chapters
\mainmatter

\chapter{引言}

图像分类是计算机视觉中的基础任务之一，其目标是将图像分配到预定义的类别中。
随着深度学习技术的发展，图像分类的性能得到了显著提升。
本文研究基于机器学习的图像分类技术，并以交通标志识别为例进行应用研究。

\section{研究背景}

交通标志识别是自动驾驶系统的重要组成部分，它能够帮助车辆理解道路环境，遵守交通规则。
准确、实时的交通标志识别对于提高自动驾驶安全性具有重要意义。

% 代码示例
\begin{listing}[!htb]
\begin{minted}{python}
import torch
import torch.nn as nn

class CNN(nn.Module):
    def __init__(self, num_classes=43):
        super(CNN, self).__init__()
        self.conv1 = nn.Conv2d(3, 32, kernel_size=3, padding=1)
        self.relu = nn.ReLU()
        self.pool = nn.MaxPool2d(kernel_size=2, stride=2)
        self.fc = nn.Linear(32 * 16 * 16, num_classes)

    def forward(self, x):
        x = self.pool(self.relu(self.conv1(x)))
        x = x.view(x.size(0), -1)
        x = self.fc(x)
        return x

# 创建模型实例
model = CNN()
print(model)
\end{minted}
\caption{用于交通标志识别的简化卷积神经网络模型}
\label{listing:cnn}
\end{listing}

\chapter{结论}

本文提出了一种高效的交通标志识别方法，在准确率和计算效率方面均表现出色。
未来工作将探索模型的进一步轻量化，以及在嵌入式设备上的部署方案。

\makereferences

\backmatter
\chapter*{谢辞}
\addcontentsline{toc}{chapter}{谢辞}
感谢指导老师的悉心指导。

\end{document}
HEREDOC

required_files=(
  "ctan/tongjithesis/tongjithesis.cls"
  "ctan/tongjithesis/tongjithesis.cfg"
  "ctan/tongjithesis/tongji-circled.def"
  "ctan/tongjithesis/tongji-cjk-font-fandol.def"
  "ctan/tongjithesis/tongji-cjk-font-mac.def"
  "ctan/tongjithesis/tongji-cjk-font-windows.def"
  "ctan/tongjithesis/tongji-cjk-font-adobe.def"
  "ctan/tongjithesis/tongji-cjk-font-founder.def"
  "ctan/tongjithesis/LICENSE"
  "ctan/tongjithesis/README.md"
  "ctan/tongjithesis/MANIFEST"
  "ctan/tongjithesis/example/example.tex"
  "ctan/tongjithesis/example/bib/note.bib"
  "ctan/tongjithesis/example/figures/tongji.pdf"
  "ctan/tongjithesis/example/figures/tongji-header.pdf"
)
for file in "${required_files[@]}"; do
  [ -f "$file" ] || { echo "Error: $file missing"; exit 1; }
done
echo "CTAN package structure:"
find ctan/tongjithesis -type f | sort
