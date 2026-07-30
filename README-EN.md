<p align="center">
  <img src="figures/tongjithesis.png" alt="TongjiThesis" width="550">
</p>

<p align="center">
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/actions/workflows/test.yaml"><img src="https://github.com/TJ-CSCCG/TongjiThesis/actions/workflows/test.yaml/badge.svg" alt="CI"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/releases"><img src="https://img.shields.io/github/v/release/TJ-CSCCG/TongjiThesis?label=Release" alt="Release"></a>
  <a href="https://www.overleaf.com/latex/templates/tongjithesis-tongji-university-thesis-template/tfvdvyggqybn"><img src="https://img.shields.io/badge/Overleaf-Template-138A07" alt="Overleaf"></a>
  <a href="https://www.latex-project.org/lppl/lppl-1-3c/"><img src="https://img.shields.io/badge/License-LPPL--1.3c-blue" alt="License"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/stargazers"><img src="https://img.shields.io/github/stars/TJ-CSCCG/TongjiThesis?style=flat" alt="Stars"></a>
  <img src="https://img.shields.io/badge/TeX%20Live-2026-blue" alt="TeX Live 2026">
</p>

<p align="center">
  English | <a href="README.md">中文</a>
</p>

LaTeX template for Tongji University undergraduate thesis (design).

> [!NOTE]
> Full sample PDFs: [Release page](https://github.com/TJ-CSCCG/TongjiThesis/releases) or [Overleaf Template PDF](https://www.overleaf.com/latex/templates/tongjithesis-tongji-university-thesis-template/tfvdvyggqybn.pdf). Detailed option documentation is in the compiled template guide (Chapter 1).

---

## Quick Start

| Method             | Description                                                                                                                                             |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Overleaf**       | Use the [Overleaf template](https://www.overleaf.com/latex/templates/tongjithesis-tongji-university-thesis-template/tfvdvyggqybn) directly — zero setup |
| **Local**          | Install [TeX Live 2026+](https://tug.org/texlive/quickinstall.html), clone the repo, run `make`                                                         |
| **GitHub Actions** | Fork this repo, push to trigger CI, download PDFs from Artifacts                                                                                        |

> [!TIP]
> This template is tested against **TeX Live 2026** in CI. If you encounter unexplained compilation errors locally, please check and upgrade your TeX Live to 2026 first.
>
> The bibliography follows GB/T 7714-2025. If the build reports the `gb7714-2025` style or `gbt7714-2025-numeric.bst` as *not found*, your local `biblatex-gb7714-2015` / `gbt7714` packages predate the 2025 styles — update them (requires TeX Live ≥ 2026):
>
> ```bash
> tlmgr update --self                         # run first if tlmgr asks to self-update
> tlmgr update gbt7714 biblatex-gb7714-2015
> ```
>
> On macOS / Linux system-wide installs, prefix the commands with `sudo`; on Windows, run them from an **Administrator** command prompt (no `sudo`). MiKTeX users: update these packages via the MiKTeX Console instead.

## Usage

### Online Use

#### Using Directly via Overleaf Template

> [!IMPORTANT]
> When using the Overleaf template, check the compiler and main entry settings:
>
> - Set `main.tex` as the main entry file, instead of other files (such as `tongjithesis.cls`);
> - Use `XeLaTeX` or `LuaLaTeX` compilers; `pdfLaTeX` is not supported.

#### Importing This Repository on Overleaf

Download this repository via `Code | Download ZIP` and drag-and-drop the ZIP file into [Overleaf](https://www.overleaf.com/).

#### Compiling in GitHub Actions

Fork this repo and push to trigger CI. Download PDFs from the `Summary | Artifacts` section of the workflow run. Enable Actions first via `Settings | Actions | General`.

### Local Use

#### Installing TeX Distribution

Install TeX Live (Windows, Linux) or MacTeX (macOS) following the [official quick install guide](https://tug.org/texlive/quickinstall.html).

#### Building the Project

We recommend building via the command line. VS Code LaTeX Workshop is also supported.

##### Command Line

###### Makefile (Linux/macOS)

```shell
make all                # compile main.pdf
make ENGINE=$ENGINE all # use $ENGINE (where $ENGINE=-xelatex or -lualatex) to compile main.pdf
make clean              # remove intermediate files
make cleanall           # remove all intermediate files (including .pdf)
make wordcount          # word count
make taskbook           # compile taskbook.pdf (task book)
make proposal           # compile proposal.pdf (opening report)
make midterm            # compile midterm.pdf (mid-term report)
make forms              # compile taskbook.pdf, proposal.pdf, and midterm.pdf
```

###### Batchfile (Windows)

```bat
.\make.bat                # the same to "make.bat thesis"
.\make.bat thesis         # compile main.pdf
.\make.bat thesis $ENGINE # use $ENGINE (where $ENGINE=-xelatex or -lualatex) to compile main.pdf
.\make.bat clean          # clean all work files by latexmk -c
.\make.bat cleanall       # clean all work files and all output PDFs by latexmk -C
.\make.bat wordcount      # wordcount
.\make.bat taskbook       # compile taskbook.pdf (task book)
.\make.bat proposal       # compile proposal.pdf (opening report)
.\make.bat midterm        # compile midterm.pdf (mid-term report)
.\make.bat forms          # compile taskbook.pdf, proposal.pdf, and midterm.pdf
.\make.bat help           # read the manual
```

##### Using VS Code and LaTeX Workshop Plugin

Install the LaTeX Workshop plugin, then **open this project's root directory directly** (the `TongjiThesis` folder — otherwise `.vscode/settings.json` won't take effect). Open `main.tex`, select `Recipe: latexmk (xelatex)` from the TeX sidebar panel, or save to trigger auto-compilation.

##### Using in Docker

For detailed usage, see [TongjiThesis-env](https://github.com/TJ-CSCCG/TongjiThesis-env).

### Template Configuration

#### Document Class Options

Configure in `main.tex` via `\documentclass`:

```latex
\documentclass[
  doctype=thesis,       % Document type: thesis body (default); taskbook/proposal/midterm — see "Task Book / Opening Report / Mid-term Report" below
  oneside,              % One-sided printing (default); use twoside for double-sided printing
  degree=bachelor,      % Degree type: bachelor (default); master/doctor reserved
  field=science,        % Major category: science = engineering/sciences (default) / humanities
  algo=algpseudocode,   % algpseudocode (default): algorithm+algorithmicx; algorithm2e: standalone algorithm2e package
  minted=false,         % true: minted highlighting (needs Python+Pygments); false: listings (default)
  biblatex=true,        % true: biblatex+biber (default); false: bibtex+gbt7714
  fontset=fandol,       % Font set passed to ctex, default is fandol
  times=false,          % true: system Times New Roman; false: newtx (default)
  fullwidthstop=circle, % Period style: circle keeps "。" (default) / dot replaces with "．"
]{tongjithesis}

\tjbibresource{bib/note.bib}  % Bib database (supports multiple, comma-separated); styled per GB/T 7714-2025
```

> [!NOTE]
> Economics & Management: class of 2026 may choose `field=science` (recommended) or `field=humanities`; from class of 2027 onward, use `field=science` uniformly.

### Task Book / Opening Report / Mid-term Report

Beyond the thesis body (`main.tex`), the template also provides 3 standalone, independently compilable official administrative documents, sharing the school/major/student/topic information in `chapters/metadata.tex` (the advisor is a handwritten signature slot on all 3 forms and is not prefilled):

| Document                    | Entry file      | Build command                            |
| --------------------------- | --------------- | ----------------------------------------- |
| Task book (任务书)          | `taskbook.tex`  | `make taskbook` / `.\make.bat taskbook`   |
| Opening report (开题报告)   | `proposal.tex`  | `make proposal` / `.\make.bat proposal`   |
| Mid-term report (中期报告)  | `midterm.tex`   | `make midterm` / `.\make.bat midterm`     |

Build all 3 at once: `make forms` / `.\make.bat forms`. The task book's duration (in weeks) is computed automatically from `\taskbookperiod{startYear}{startMonth}{startDay}{endYear}{endMonth}{endDay}` — no manual entry needed. See the compiled template guide for details.

### Font Selection

- **Windows users**: Use `fontset=windows` — SimSun / SimHei / KaiTi / FangSong are included with the OS and provide broader coverage.
- **macOS users**: Use `fontset=mac` — Songti SC / Heiti SC / STFangsong / Kaiti SC are included with macOS, zero-config.
- **Cross-platform users**: The default `fontset=fandol` (shipped with TeX Live, zero-config) is recommended. For broader character coverage, download `adobe` / `founder` / `windows` fonts from [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex), install them to your system, then switch the `fontset`.

> [!NOTE]
> Run `fc-cache -fv` after installing new fonts to refresh the font cache.

### Code Highlighting & Algorithm Typesetting

#### Code Highlighting

1. **`listings`** (default): Pure LaTeX, no external dependencies. Suitable for most use cases.
2. **`minted`**: Python-based (Pygments) with richer syntax highlighting. Set `minted=true` in `main.tex` to enable. Requires Python 3.11–3.13 with `pygments` installed (`pip install pygments`). If you have multiple Python versions installed, use `\renewcommand{\MintedPython}{/path/to/python}` to specify the Python interpreter for minted.

#### Algorithm Typesetting

1. **`algpseudocode`** (default): Uses `algorithm` + `algorithmicx` + `algpseudocode` packages with `\State`, `\If`, `\For` commands.
2. **`algorithm2e`**: Standalone `algorithm2e` package with a different syntax. Set `algo=algorithm2e` in `main.tex` to switch.

## Contributing & Project History

See [CONTRIBUTING.md](CONTRIBUTING.md). Architecture notes and development conventions for AI coding agents live in [AGENTS.md](AGENTS.md).

## License

This project uses the [LPPL-1.3c license](https://www.latex-project.org/lppl/lppl-1-3c/). See [LICENSE](https://github.com/TJ-CSCCG/TongjiThesis/blob/master/LICENSE).

## Contact

For questions, please use [Discussions](https://github.com/TJ-CSCCG/TongjiThesis/discussions).
