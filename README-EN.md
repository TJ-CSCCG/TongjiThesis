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

<p align="center">
    <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/TongjiThesis/preview/main_page-0001.jpg" width="23%">
    <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/TongjiThesis/preview/main_page-0002.jpg" width="23%">
    <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/TongjiThesis/preview/main_page-0005.jpg" width="23%">
    <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/TongjiThesis/preview/main_page-0039.jpg" width="23%">
</p>

> [!NOTE]
> A complete sample can be found in [Template Output Sample Display (Full Version)](https://github.com/TJ-CSCCG/TongjiThesis/discussions/21), in the PDF download link under "Assets" in the [Release page](https://github.com/TJ-CSCCG/TongjiThesis/releases) or [Overleaf Template PDF](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn.pdf).

## Key Features

- Based on `ctexbook`, supports `\frontmatter` / `\mainmatter` / `\backmatter` / `\appendix` structure
- Compliant with the 2026 Tongji undergraduate thesis writing standard (小四 body, 1.5× line spacing, 小三 chapter headings)
- Dual compiler support: `XeLaTeX` and `LuaLaTeX`
- Dual bibliography backends: `biblatex` (default) and `bibtex`, unified via `\makereferences`
- Dual code highlighting: `minted` (default) and `listings`
- `longlisting` environment for cross-page code blocks
- Built-in information description page (`\MakeInfoPage`) per the 2026 official template
- Single-sided / double-sided printing with automatic binding line
- Key-value document class options for flexible configuration
- Continuous CI testing on Linux, macOS, and Windows

---

## Quick Start

| Method             | Description                                                                                                                                              |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Overleaf**       | Use the [Overleaf template](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn) directly — zero setup |
| **Local**          | Install [TeX Live 2026+](https://tug.org/texlive/quickinstall.html), clone the repo, run `make`                                                          |
| **GitHub Actions** | Fork this repo, push to trigger CI, download PDFs from Artifacts                                                                                         |

> [!TIP]
> This template is tested against **TeX Live 2026** in CI. If you encounter unexplained compilation errors locally, please first check and upgrade your TeX Live installation to 2026. Older TeX Live versions may ship package versions that are incompatible with this template.

## Usage

### Online Use

#### Using Directly via Overleaf Template

You can use this template directly via the [Overleaf template link](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn).

> [!IMPORTANT]
> When using the Overleaf template, please check the compiler and main entry settings:
>
> - Set `main.tex` as the main entry file, instead of other files in the project (such as `tongjithesis.cls`);
> - It is recommended to use the `XeLaTeX` or `LuaLaTeX` compilers, as some compilers (such as `pdfLaTeX`) are not supported by this template.

#### Importing This Repository on Overleaf

- Download this repository via `Code | Download ZIP` at the top of the repository home page file list;
- Open [Overleaf](https://www.overleaf.com/);
- Upload the downloaded `zip` file to Overleaf by dragging and dropping.

#### Compiling in GitHub Actions

The project is configured with GitHub Actions in `.github/workflows/*.yaml`. Pushing code to a fork repository or a template-generated repository will trigger tests. You can obtain build artifacts for multiple platforms from the `Summary | Artifacts` section of the workflow run associated with the commit.

(Enable GitHub Actions by checking `Settings | Actions | General | Allow all actions and reusable workflows`)

### Local Use

#### Installing TeX Distribution

We recommend installing TeX Live (Windows, Linux) or MacTeX (macOS) following the [official quick install guide](https://tug.org/texlive/quickinstall.html).

#### Building the Project

We recommend building the project via the command line. Alternatively, you can use the VS Code LaTeX Workshop plugin.

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

Install the LaTeX Workshop plugin in VS Code, and then **open the root directory of this project directly** (i.e., the `TongjiThesis` folder, not a parent folder, otherwise `.vscode/settings.json` will not take effect).

Since we have configured the LaTeX Workshop plugin in `.vscode/settings.json`, you only need to:

- Select the `main.tex` file;
- Click the button with the $\TeX$ icon on the left sidebar;
- Click `Recipe: latexmk (xelatex)` from the `Build LaTeX project` list to compile the `.pdf` file.

Alternatively, the LaTeX Workshop plugin will automatically compile the file when you save it.

</details>

<details><summary><b>Using in Docker</b></summary>

For detailed usage, see [TongjiThesis-env](https://github.com/TJ-CSCCG/TongjiThesis-env).

</details>

### Template Configuration

#### Document Class Options

This template provides the following document class options, which can be configured in `main.tex`:

```latex
\documentclass[
  oneside,           % One-sided printing (default), use twoside for double-sided printing
  degree=bachelor,   % Degree type: bachelor (default), master/doctor reserved
  fullwidthstop=false, % Whether to replace Chinese period "。" with Western-style period "．", default is false
  fontset=fandol,    % Font set to use, default is fandol
  times=false,       % Whether to use Times New Roman font, default is false
  minted=true,       % Whether to use the minted package for code highlighting, default is true
  biblatex=true,     % Whether to use biblatex for bibliography management, default is true
]{tongjithesis}

\tjbibresource{bib/note.bib}  % Specify bib files (supports multiple, comma-separated)
```

<details><summary><b>Detailed option descriptions</b></summary>

##### Single/Double-Sided Printing Options

- `oneside`: Single-sided printing (default)
- `twoside`: Double-sided printing, adjusts page margins and binding line

##### Font Options

- `fontset=fandol`: Use Fandol font set (default)
- `fontset=adobe`: Use Adobe font set (requires Adobe fonts installation)
- `times=false`: Use `newtx` package fonts (default)
- `times=true`: Use Times New Roman font

##### Chinese Punctuation Options

- `fullwidthstop=false`: Keep Chinese period "。" unchanged (default)
- `fullwidthstop=true`: Replace Chinese period "。" with Western-style period "．"

##### Bibliography Options

- `biblatex=true`: Use `biblatex` (biber backend) for bibliography management (default)
- `biblatex=false`: Use `bibtex` with `gbt7714` package for bibliography management

Use `\tjbibresource{file1.bib,file2.bib}` to specify bib files, and `\makereferences` to output the bibliography.

</details>

<details><summary><b>Rendering Rare Characters</b></summary>

Due to the default use of the Fandol font in this template, support for rare characters such as names and specific terms might not be adequate. We provide the Adobe font set in the [`fonts`](https://github.com/TJ-CSCCG/TongjiThesis/tree/fonts) branch of our GitHub repository. You can download and install these fonts, and then use the `fontset=adobe` option in `main.tex` to use the Adobe font set:

```latex
\documentclass[
  oneside,
  fontset=adobe,
  % other options...
]{tongjithesis}
```

This modification will switch the rendering in the document to use the Adobe font set, enhancing support for rare characters.

**Note**: Placing Adobe font files in the project's root directory and specifying the font path in `main.tex` is not always effective. Therefore, we recommend installing the Adobe fonts into the system font directory. Tests show that placing Adobe font files in the root directory of an Overleaf project and using LuaLaTeX for compilation works, but this method may slow down the compilation process.

</details>

#### Code Highlighting Options

This template provides two code highlighting solutions:

1. **`minted` package** (Python-based): Provides advanced syntax highlighting features, requires Python environment.
   - Enable by setting `minted=true` (default) in `main.tex`
   - Requires installation of Python and Pygments library (`pip install pygments`)
   - You need to add Python to the system `PATH` environment variable,
     - or specify the Python path in `main.tex` (see below)
   - Requires `-shell-escape` parameter during compilation (this template has added)

2. **`listings` package** (pure LaTeX): Does not depend on external programs, can be used in any environment.
   - Enable by setting `minted=false` in `main.tex`
   - No additional program installation required

If you do not want to install Python or encounter `minted`-related errors, you can change `minted=true` to `minted=false` in `main.tex`. When using `minted=false`, the template will automatically use the `listings` package to process all code, without requiring additional configuration.

<details><summary>Using <code>minted</code> but don't want to add Python to the <code>PATH</code> environment variable?</summary>

You can add a redirection to the Python path of the `minted` package in the `main.tex` file:

```latex
\renewcommand{\MintedPython}{/path/to/your/python}
```

</details>

## How to contribute to this project?

Please refer to the [Contributing Guide](CONTRIBUTING.md#提交-pull-request).

## Open Source License

This project uses the [LPPL-1.3c license](https://www.latex-project.org/lppl/lppl-1-3c/). See the [LICENSE](https://github.com/TJ-CSCCG/TongjiThesis/blob/master/LICENSE) file for details.

## Project History

- This project originated from [YukuanHU](https://github.com/YukuanHu)'s undergraduate thesis, which was uploaded on May 24, 2019.
- Starting May 9, 2021, [ganler](https://github.com/ganler) enhanced the functionalities (project structure and platform compatibility) based on the original project and began maintaining it.
- As of May 12, 2022, [skyleaworlder](https://github.com/skyleaworlder) started contributing to the project, integrated it into [TJ-CSCCG](https://github.com/TJ-CSCCG), and has continued to update and improve it. It has now become a comprehensive undergraduate thesis template.
- From April 2023, [RizhongLin](https://github.com/RizhongLin) began contributing to and managing the project.
- April 2025 update, implemented key-value based class options, supporting more flexible configuration.
- 2026 update: migrated to `ctexbook` base class, added dual `biblatex`/`bibtex` backend support, `longlisting` cross-page code environment, `\makereferences` unified bibliography output, CI upgraded to TeX Live 2026; aligned with the 2026 Tongji writing standard — added information description page (`\MakeInfoPage`), font-size constant system (`\tjfontchapter` etc.), and longtable continuation helper (`\tjlongtablecont`).

We deeply appreciate the efforts of these contributors, whose work has facilitated and assisted many students.

If you find this template helpful for your thesis or dissertation, we hope you will acknowledge and honor these contributors in your acknowledgements section.

## Acknowledgements

We have learned a lot from excellent open-source projects from top universities:

- [sjtug/SJTUThesis](https://github.com/sjtug/SJTUThesis): makefile & batchfile contributions.
- [stone-zeng/fduthesis](https://github.com/stone-zeng/fduthesis): workflows enhancements.

## Contact Information

For questions, please use [Discussions](https://github.com/TJ-CSCCG/TongjiThesis/discussions).
