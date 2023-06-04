# :page_facing_up: Tongji University Undergraduate Thesis Template (STEM)

English | [中文](README.md)

> * **Note**: By using this template, you will obtain a **pdf** file as output. However, during the process of undergraduate thesis, there may be situations where you need to submit files in docx or other formats. In such cases, you can use some **pdf to docx conversion tools**, such as: [pdf2go.pdf-to-word](https://www.pdf2go.com/pdf-to-word)).
> * You do **not need to worry** about whether abandoning the docx template of the 1 system and choosing this LaTeX template will be affected by formatting issues. After all, those of us who use this template ([2017-ganler](https://github.com/ganler), [2018-skyleaworlder](https://github.com/skyleaworlder)) have not been required to reformat our papers due to formatting issues.

## Sample Display

> The complete sample can be found in [Template Output Sample Display (Full Version)](https://github.com/TJ-CSCCG/tongji-undergrad-thesis/discussions/21), in the pdf download link under "Assets" in the [Release page](https://github.com/TJ-CSCCG/tongji-undergrad-thesis/releases) or [Overleaf Template PDF](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn.pdf).

The following displays the "Cover", "Abstract in Chinese", "Table of Contents", "Main Content", "References" and "Acknowledgements" in order.

<p align="center">
      <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/tongji-undergrad-thesis/preview/main_page-0001.jpg" width="30%">
      <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/tongji-undergrad-thesis/preview/main_page-0002.jpg" width="30%">
      <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/tongji-undergrad-thesis/preview/main_page-0004.jpg" width="30%">
      <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/tongji-undergrad-thesis/preview/main_page-0005.jpg" width="30%">
      <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/tongji-undergrad-thesis/preview/main_page-0010.jpg" width="30%">
      <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/tongji-undergrad-thesis/preview/main_page-0011.jpg" width="30%">
</p>

## Usage

### 1. Directly use via **Overleaf** template

You can access our Overleaf template and use it directly through the following link: [![svg of overleaf-tongjithesis](https://img.shields.io/badge/Overleaf-TJ--CSCCG%2Ftongji--undergrad--thesis-green)](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn)

Please note that the Overleaf template is updated in a timely manner. We encourage you to use the template directly to write your undergraduate thesis and also to import the template into your own Overleaf project for use. Please refer to the next section of this document for specific instructions.

> **Note!** When using the Overleaf template, be sure to check the compiler and main entry settings:
> 
> * Set the `main.tex` file as the main entry file, not other `.tex` files in the project (especially `tongjithesis.cls` or `tongjithesis.sty`);
> * It is recommended to use `XeLaTeX` and `LuaLaTeX` compilers. This template does not support some compilers (such as `pdfLaTeX`).

### 2. Import this repository on **Overleaf**

* Download this repository via "Code | Download ZIP" above the project file list on this repository's main page;
* Open [Overleaf](https://www.overleaf.com/);
* Upload the downloaded `zip` file to Overleaf by dragging and dropping it.

### 3. Using on Mac / Linux

#### i. Install Python

- For Mac: Python comes pre-installed on most Macs. If you don't already have it, you can download and install it from the official website: https://www.python.org/downloads/mac-osx/
- For Linux: Install Python by typing the following command in Terminal:
```shell
sudo apt-get install python3
```

After installing Python, you need to set the environment variable ``PATH`` and add the path to Python to it. This will allow you to call the `minted` macro package correctly in LaTeX.

#### ii. Install `pygmentize` using `pip`

Enter the following command in the terminal:
```shell
pip install Pygments
```

Note: If you encounter permissions problems during the installation process, you can run the above command from a command prompt with administrator privileges.

#### iii. Use tlmgr

Download TeXLive and use `tlmgr` to download packages:

```shell
# The following commands aims at installing packages upon TeXLive without any packages.
# You can also install BasicTex: https://mirrors.chevalier.io/CTAN/systems/mac/mactex/mactex-basictex-20210325.pkg
sudo tlmgr update --self

sudo tlmgr install adjustbox algorithmicx algorithms biber biblatex biblatex-gb7714-2015 bibtex booktabs \ 
    caption carlisle cases catchfile chinese-jfm chngcntr cleveref collectbox ctex dvips \ 
    enumitem environ extarrows fancybox fancyhdr fancyvrb float framed fvextra \ 
    gbt7714 gsftopk helvetic hologo ifplatform lastpage latexmk lineno \ 
    minted multirow mwe natbib needspace newtx nth oberdiek pdftexcmds realscripts rsfs setspace siunitx subfig \
    tcolorbox texcount texliveonfly threeparttable threeparttablex times titling tocloft \ 
    trimspaces txfonts ucs upquote was xcolor xecjk xstring zhnumber

sudo tlmgr update --self --all
```

#### iv. Build the project through Makefile

Thanks to the Makefile file of the [SJTUThesis](https://github.com/sjtug/SJTUThesis) project, you can build the project through Makefile:

```shell
make all                      # compile main.pdf
make ENGINE=$ENGINE all       # use $ENGINE(where $ENGINE=-xelatex or -lualatex) to compile main.pdf
make clean                    # rm intermediate files
make cleanall                 # rm all intermediate files (including .pdf)
make wordcount                # wordcount
```

### 4. Using on Windows

#### i. Install Python

1. Download the Python installer: Download the Python installer from the [Python official website](https://www.python.org/downloads/windows/) (note: the downloaded version needs to match your operating system version and bit number).

2. Run the Python installer: Double-click the downloaded installer and follow the prompts to install it. During installation, remember to check the `Add Python 3.x to PATH` option so that Python can be used from the command line.

#### ii. Install `pygments` using `pip`

Enter the following command in the terminal:
```shell
pip install Pygments
```

Note: If you encounter permissions problems during the installation process, you can run the above command from a command prompt with administrator privileges.

Note: If you are concerned about the potential environmental contamination risks of adding a specific version of Python to your environment paths and wish to use a Python environment manager application, proceed as follows:
- Create a new Python environment and install the `pygments` module.
- Follow the comments in `main.tex` which specify the environment path directly in the file.

#### iii. Install TeXLive

Download `install-tl-windows.exe` from [here](https://www.tug.org/texlive/acquire-netinstall.html).

Note: A data pack of about 8GB will be downloaded during the installation process, please be patient.

#### iv. Build the project through Batchfile

> Thanks to the Compile.bat file of the [SJTUThesis](https://github.com/sjtug/SJTUThesis) project.

You can complete the corresponding operation with the following command:

```bat
.\make.bat                      # the same to "make.bat thesis"
.\make.bat thesis               # compile main.pdf
.\make.bat thesis $ENGINE       # use $ENGINE(where $ENGINE=-xelatex or -lualatex) to compile main.pdf
.\make.bat clean                # clean all work files by latexmk -c
.\make.bat cleanall             # clean all work files and main.pdf by latexmk -C
.\make.bat wordcount            # wordcount
.\make.bat help                 # read the manual
```

At this point, you are ready to write your paper with LaTex. If you prefer to operate in a full UI environment rather than the command line, please continue with the following.

### 5. Using on VSCode

#### i. Configure VSCode

Install the LaTeX Workshop extension in the VSCode marketplace, then download this project and open it in the root directory. (LaTeX Workshop is just an extension, you still need to download the corresponding `TeXLive` for your platform)

> **Note**: The following configurations are already included in the project's `.vscode/settings.json` file. Normally, when you start the LaTeX Workshop extension, it will automatically load the configuration. (The configuration in `.vscode/settings.json` will override the corresponding options in the global configuration file `settings.json`, so you do not need to modify the global configuration file.)

```json
"latex-workshop.latex.recipe.default": "latexmk (xelatex)",
"latex-workshop.latex.tools": [
    {
        "name": "xelatexmk",
        "command": "latexmk",
        "args": [
            "-xelatex",
            "-synctex=1",
            "-quiet",
            "-interaction=nonstopmode",
            "-file-line-error",
            "-halt-on-error",
            "-shell-escape",
            "%DOC%"
        ]
    }
],
"latex-workshop.latex.recipes": [
    {
        "name": "latexmk (xelatex)",
        "tools": [
            "xelatexmk"
        ]
    }
]
```

#### ii. Compile the project using Workshop features

* Click the LaTeX button with the TEX icon on the left sidebar.
* Click `Recipe: latexmk (xelatex)` in the `Build LaTeX project` list to compile the `.pdf` file.

### 6. Compile on GitHub Actions

The project has been configured with GitHub Actions in `.github/workflows/*.yaml`, which can be triggered by pushing code to a forked repository or template-generated repository. Multi-platform build artifacts can be obtained through `Summary | Artifacts` in the corresponding workflow run of the commit.

(Open GitHub Actions by checking `Settings | Actions | General | Allow all actions and reusable workflows`)

### 7. Using Docker

See [tongji-undergrad-thesis-env](https://github.com/TJ-CSCCG/tongji-undergrad-thesis-env) for detailed instructions.

## Use double-sided printing version (optional)

If you need to use the two-sided printing version, please change `\documentclass[oneside]{tongjithesis}` to `\documentclass[twoside]{tongjithesis}` in line 1 of `main.tex`.

## Use more complete Adobe fonts (optional)

### Style modification

In order to use the more complete Adobe fonts from the font library, you need to make the following modifications:

Find the following code snippet on line 10 of `style/tongjithesis.cls`:

```latex
\LoadClass[UTF8,a4paper,fontset=fandol]{ctexart}
```

and modify it to:

```latex
\LoadClass[UTF8,a4paper,fontset=adobe]{ctexart}
```

With this modification, LaTeX will use the Adobe font set to render the document.

### Font installation

The steps to install fonts are as follows:

1. In our repository root directory, we have attached four font files from Adobe (`AdobeFangsongStd-Regular.otf`, `AdobeKaitiStd-Regular.otf`, `AdobeHeitiStd-Regular.otf`, `AdobeSongStd-Light.otf`). If you use our template directly on Overleaf, you don't need to install it, but it should be noted that the compilation speed may be slightly slower. Therefore, we recommend that you compile locally.
2. If you use LaTeX on Windows, macOS or Linux, you need to install these four font files manually. Once installed, you are ready to compile.

Note the support for the following compilation methods:

* If you are using Overleaf, only compiling with LuaLaTeX is supported.
* If you compile locally on Windows, macOS or Linux, you can choose to use XeLaTeX or LuaLaTeX.

You can see the specific effect in Section 1.2.1 "Testing Rare Words" of the template document.

With the steps above, you will be able to use Adobe font sets and render documents correctly.

## How to contribute to this project?

Please refer to [How to pull request](CONTRIBUTING.md/#how-to-pull-request).

## Open Source License

This project uses the [LPPL-1.3c license](https://www.latex-project.org/lppl/lppl-1-3c/).

```text
%% tongji-undergrad-thesis
%% Copyright 2023 TJ-CSCCG
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.
%
% This work has the LPPL maintenance status "maintained".
%
% This Current Maintainer of this work is R. Lin.
%
% This work consists of all the *.tex, *.cls, *.cfg, and *.sty files in
%   https://github.com/TJ-CSCCG/tongji-undergrad-thesis
```

## Notes on outstanding contributions

* This project originated from [YukuanHU](https://github.com/YukuanHu)'s undergraduate thesis, which was uploaded on May 24, 2019.
* Since May 9, 2021, [ganler](https://github.com/ganler) has been maintaining a new project based on the above project, with enhanced functionality (project structure and platform adaptation).
* Starting on May 12, 2022, [skyleaworlder](https://github.com/skyleaworlder) started contributing to this project and integrated it into [TJ-CSCCG](http://github.com/TJ-CSCCG). They have continued to update and improve this project, and it has now become a well-established template for undergraduate theses.

We are very grateful for the contributions of these contributors, whose work has provided convenience and help to many students.

If you find this project helpful for your undergraduate thesis or dissertation, we hope you can acknowledge and express your gratitude in your acknowledgements.

## Acknowledgements

We have learned a lot from the excellent open source projects of top universities:

* [sjtug/SJTUThesis](https://github.com/sjtug/SJTUThesis): makefile & batchfile
* [stone-zeng/fduthesis](https://github.com/stone-zeng/fduthesis): workflows

## Contact us

```python
# Python
[
    f'jiawei#@$.edu'.replace('#', '6').replace('$', 'illinois'),
    'jgli22@$.edu.cn'.replace('$', 'm.fudan'),
    'rizhonglin@!.edu.cn'.replace('!', 'tongji')
]
```
