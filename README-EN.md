<p align="center">
  <img src="figures/tongjithesis.png" alt="TongjiThesis" width="550">
</p>

<p align="center">
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/actions/workflows/ci.yml"><img src="https://github.com/TJ-CSCCG/TongjiThesis/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
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
| **GitHub Actions** | [Build and download the thesis or forms](#compiling-in-github-actions) in your fork                                                                     |

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

Open **Actions** in your fork and enable workflows if prompted. You can then compile in either of these ways:

- Push a change to a thesis source file, such as `chapters/metadata.tex`, on `master` or `dev` to start the `CI` workflow automatically.
- If you keep your thesis on another branch, open **Actions → CI → Run workflow**, select your thesis branch, then click **Run workflow**. This also works when you have only changed ignored files such as the README.

Open the run for your commit. Under **Summary → Artifacts**, each archive is named after the PDF inside it. The thesis and the three forms are built separately:

| Document | Artifact |
| --- | --- |
| Thesis (`main.tex`, XeLaTeX on Linux) | `tongjithesis-linux-xelatex` |
| Task book | `tongjithesis-taskbook` |
| Proposal | `tongjithesis-proposal` |
| Midterm report | `tongjithesis-midterm` |

These archives are kept for 30 days. `all-compiled-documents` holds every PDF of the run and is kept for 90 days.

The `tongjithesis-linux-xelatex-*` and `tongjithesis-linux-lualatex-*` artifacts with a suffix exercise template options, and `tongjithesis-ctan-example` contains the distribution example. If no run appears, check the branch and the [workflow triggers](.github/workflows/ci.yml). If a run exists but your PDF is missing, open the corresponding `build` or `build-forms` job and check its compilation log.

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
  fontset=auto,         % Font set: auto (default) picks the installed set closest to the Word template's fonts; see "Font Selection" below
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

The default `fontset=auto` picks the installed font set whose glyphs are closest to the Zhongyi fonts the Word template uses (SimSun, SimHei, KaiTi, FangSong), and names the set it chose in the compilation log:

1. `windows`: the Zhongyi fonts themselves (shipped with Windows, or placed in the project's `fonts/` folder);
2. `founder`: Founder ShuSong, Hei, Kai and FangSong (free to download from Founder, or placed in `fonts/`);
3. `fandol`: the Fandol fonts (shipped with older TeX Live and with Overleaf; withdrawn by their authors and due to leave TeX Live);
4. `texlive`: free fonts shipped with TeX Live (LXGW Neo ZhiSong, LXGW Neo XiHei, AR PL KaitiM GB, LXGW Zhuque Fangsong).

The compilation warns when it does not pick `windows`. To use the same fonts as the Word template:

- **Local compilation**: run `make fonts` (Windows: `.\make.bat fonts`) to download the Zhongyi fonts into the project's `fonts/` folder. `make fonts FONTSET=founder` (Windows: `.\make.bat fonts founder`) downloads the Founder fonts. The fonts come from the releases of [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex).
- **Overleaf**: download `windows.zip` from the [latest cjk-fonts-for-ctex release](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex/releases/latest), unzip it, and upload the font files into a folder named `fonts` in your project.

You can also name a set directly: `windows`, `founder`, `adobe`, `mac` (Songti SC and the other macOS fonts), `fandol` or `texlive`. The `fontdir` option sets the folder holding font files (default `fonts/`): `windows`, `founder`, `adobe` and `fandol` load their files from it when they are there, otherwise their fonts are looked up by name on the system; `mac` and `texlive` always use the system's or TeX Live's fonts. `fontset=auto` chooses a set only when all four of its fonts are present.

Chinese fonts have no italics, so the template uses Kai instead. The sets without a real bold Song and Hei (`windows`, `founder`, `adobe`, `texlive`) fake bold by stroking the outlines, with the same stroke width as Word (1/35 of the font size).

> [!NOTE]
> The fonts' copyright belongs to their owners; use them under their licences. After installing fonts on Linux, run `fc-cache -fv` to refresh the font cache.

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
