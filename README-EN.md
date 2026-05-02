<p align="center">
  <img src="figures/tongjithesis.png" alt="TongjiThesis" width="550">
</p>

<p align="center">
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/actions/workflows/test.yaml"><img src="https://github.com/TJ-CSCCG/TongjiThesis/actions/workflows/test.yaml/badge.svg" alt="CI"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/releases"><img src="https://img.shields.io/github/v/release/TJ-CSCCG/TongjiThesis?label=Release" alt="Release"></a>
  <a href="https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn"><img src="https://img.shields.io/badge/Overleaf-Template-138A07" alt="Overleaf"></a>
  <a href="https://www.latex-project.org/lppl/lppl-1-3c/"><img src="https://img.shields.io/badge/License-LPPL--1.3c-blue" alt="License"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/stargazers"><img src="https://img.shields.io/github/stars/TJ-CSCCG/TongjiThesis?style=flat" alt="Stars"></a>
  <img src="https://img.shields.io/badge/TeX%20Live-2026-blue" alt="TeX Live 2026">
</p>

<p align="center">
  English | <a href="README.md">中文</a>
</p>

A LaTeX template that conforms to the official formatting requirements for Tongji University undergraduate theses. Supports XeLaTeX / LuaLaTeX compilation, offers both `minted` and `listings` for code highlighting, and is compatible with both `biblatex` and `bibtex` citation backends. Continuously tested on Linux, macOS, and Windows via CI.

> [!NOTE]
> Full sample PDFs: [Release page](https://github.com/TJ-CSCCG/TongjiThesis/releases) or [Overleaf Template PDF](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn.pdf). Detailed option documentation is in the compiled template guide (Chapter 1).

---

## Quick Start

| Method             | Description                                                                                                                                              |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Overleaf**       | Use the [Overleaf template](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn) directly — zero setup |
| **Local**          | Install [TeX Live 2026+](https://tug.org/texlive/quickinstall.html), clone the repo, run `make`                                                          |
| **GitHub Actions** | Fork this repo, push to trigger CI, download PDFs from Artifacts                                                                                         |

> [!TIP]
> This template is tested against **TeX Live 2026** in CI. If you encounter unexplained compilation errors locally, please check and upgrade your TeX Live to 2026 first.

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
```

###### Batchfile (Windows)

```bat
.\make.bat                # the same to "make.bat thesis"
.\make.bat thesis         # compile main.pdf
.\make.bat thesis $ENGINE # use $ENGINE (where $ENGINE=-xelatex or -lualatex) to compile main.pdf
.\make.bat clean          # clean all work files by latexmk -c
.\make.bat cleanall       # clean all work files and main.pdf by latexmk -C
.\make.bat wordcount      # wordcount
.\make.bat help           # read the manual
```

<details><summary><b>Using VS Code and LaTeX Workshop Plugin</b></summary>

Install the LaTeX Workshop plugin, then **open this project's root directory directly** (the `TongjiThesis` folder — otherwise `.vscode/settings.json` won't take effect). Open `main.tex`, select `Recipe: latexmk (xelatex)` from the TeX sidebar panel, or save to trigger auto-compilation.

</details>

<details><summary><b>Using in Docker</b></summary>

For detailed usage, see [TongjiThesis-env](https://github.com/TJ-CSCCG/TongjiThesis-env).

</details>

### Template Configuration

#### Document Class Options

Configure in `main.tex` via `\documentclass`:

```latex
\documentclass[
  oneside,              % One-sided printing (default); use twoside for double-sided printing
  degree=bachelor,      % Degree type: bachelor (default); master/doctor reserved
  field=science,        % Major category: science = engineering/sciences (default) / humanities
  fullwidthstop=circle, % Period style: circle keeps "。" (default) / dot replaces with "．"
  fontset=fandol,       % Font set passed to ctex, default is fandol
  times=false,          % true: system Times New Roman; false: newtx (default)
  minted=true,          % true: minted highlighting (needs Python+Pygments); false: listings
  biblatex=true,        % true: biblatex+biber (default); false: bibtex+gbt7714
]{tongjithesis}

\tjbibresource{bib/note.bib}  % Specify bib files (supports multiple, comma-separated)
```

> [!NOTE]
> Economics & Management: class of 2026 may choose `field=science` (recommended) or `field=humanities`; from class of 2027 onward, use `field=science` uniformly.

<details><summary><b>Rendering Rare Characters</b></summary>

The default Fandol font has limited support for rare characters. Download the Adobe font set from the [`fonts`](https://github.com/TJ-CSCCG/TongjiThesis/tree/fonts) branch, install them to your system, and set `fontset=adobe` in `main.tex`.

> [!NOTE]
> Install fonts to the system font directory rather than the project root. On Overleaf, placing fonts in the project root works with LuaLaTeX but may slow compilation.

</details>

<details><summary><b>Code Highlighting Options</b></summary>

1. **`minted`** (default): Python-based (Pygments) with richer syntax highlighting. Requires Python with `pygments` installed (`pip install pygments`).
2. **`listings`**: Pure LaTeX, no external dependencies.

Set `minted=false` in `main.tex` to switch. If you encounter `minted`-related errors, switch to `minted=false`.

</details>

## Contributing & Project History

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This project uses the [LPPL-1.3c license](https://www.latex-project.org/lppl/lppl-1-3c/). See [LICENSE](https://github.com/TJ-CSCCG/TongjiThesis/blob/master/LICENSE).

## Contact

For questions, please use [Discussions](https://github.com/TJ-CSCCG/TongjiThesis/discussions).
