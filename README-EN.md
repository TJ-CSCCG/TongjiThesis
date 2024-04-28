# :page_facing_up: Tongji University Undergraduate Thesis Template (STEM)

English | [中文](README.md)

## Sample Display

> [!NOTE]
> A complete sample can be found in [Template Output Sample Display (Full Version)](https://github.com/TJ-CSCCG/tongji-undergrad-thesis/discussions/21), in the pdf download link under "Assets" in the [Release page](https://github.com/TJ-CSCCG/tongji-undergrad-thesis/releases) or [Overleaf Template PDF](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn.pdf).

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

### Online Use

#### Using Directly via Overleaf Template

You can access and use our Overleaf template through the following link: [![svg of overleaf-tongjithesis](https://img.shields.io/badge/Overleaf-TJ--CSCCG%2Ftongji--undergrad--thesis-green)](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn)

> [!IMPORTANT]
> When using the Overleaf template, please check the compiler and main entry settings:
>
> - Set `main.tex` as the main entry file, instead of other `.tex` files in the project (especially `tongjithesis.cls` or `tongjithesis.sty`);
> - It is recommended to use the `XeLaTeX` or `LuaLaTeX` compilers, as some compilers (such as `pdfLaTeX`) are not supported by this template.

#### Importing This Repository on Overleaf

- Download this repository via `Code | Download ZIP` at the top of the repository home page file list;
- Open [Overleaf](https://www.overleaf.com/);
- Upload the downloaded `zip` file to Overleaf by dragging and dropping.

#### Compiling in GitHub Actions

The project is configured with GitHub Actions in `.github/workflows/*.yaml`. Pushing code to a fork repository or a template-generated repository will trigger tests. You can obtain build artifacts for multiple platforms from the `Summary | Artifacts` section of the workflow run associated with the commit.

(Enable GitHub Actions by checking `Settings | Actions | General | Allow all actions and reusable workflows`)

### Local Use

#### Installing $\TeX$ Distribution

We recommend installing TeX Live (Windows, Linux) or MacTeX (macOS) following the [official quick install guide](https://tug.org/texlive/quickinstall.html).

#### Supporting Code Highlighting

This template supports code highlighting by incorporating the `minted` package. The `minted` package requires Python support, so you need to install Python and use `pip` to install `Pygments`. Afterwards, add the Python path with `Pygments` installed to the environment variable `PATH`, or configure as follows to ensure $\LaTeX$ can correctly invoke the `minted` package.

<details><summary>Don't want to add this Python path to the environment variable `PATH`?</summary>

You can add a redirect to the Python path of the `minted` package in the `main.tex` file:

```latex
\renewcommand{\MintedPython}{/path/to/your/python}
```

</details>

If you do not need code highlighting, please comment out the related content in the `minted` package.

#### Building the Project

Due to the complex file structure of this template, we do not recommend using commands like `latexmk` that come with TeX Live for compilation.

We recommend building the project using the command line. Furthermore, we also support building the project in a complete UI environment using the LaTeX Workshop plugin in VS Code.

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

##### Using VS Code and LaTeX Workshop Plugin

###### Configuring VS Code

Install the LaTeX Workshop plugin in VS Code, and then open the root directory of this project.

###### Compile Project Using Workshop Features

Since we have configured the LaTeX Workshop plugin in `.vscode/settings.json`, you only need to:

- Select the `main.tex` file;
- Click the button with the $\TeX$ icon on the left sidebar;
- Click `Recipe: latexmk (xelatex)` from the `Build LaTeX project` list to compile the `.pdf` file.

Alternatively, the LaTeX Workshop plugin will automatically compile the file when you save it.

##### Using in Docker

For detailed usage, see [tongji-undergrad-thesis-env](https://github.com/TJ-CSCCG/tongji-undergrad-thesis-env).

### Other Features

#### Double-Sided Printing

If you need to use double-sided printing, simply change the first line in `main.tex` from

```latex
\documentclass[oneside]{tongjithesis}
```

to

```latex
\documentclass[twoside]{tongjithesis}
```

to enable it.

#### Rendering Rare Characters

Due to the default use of the Fandol font in this template, support for rare characters such as names and specific terms might not be adequate. We provide the Adobe font set in the [`fonts`](https://github.com/TJ-CSCCG/tongji-undergrad-thesis/tree/fonts) branch of our GitHub repository. You can download and install these fonts, and then change the line in `style/tongjithesis.cls` from

```latex
\LoadClass[UTF8,a4paper,fontset=fandol]{ctexart}
```

to

```latex
\LoadClass[UTF8,a4paper,fontset=adobe]{ctexart}
```

This modification will switch the rendering in the document to use the Adobe font set, enhancing support for rare characters.

> [!WARNING]
> Placing Adobe font files in the project's root directory and specifying the font path in `main.tex` is not always effective. Therefore, we recommend installing the Adobe fonts into the system font directory.
>
> Tests show that placing Adobe font files in the root directory of an Overleaf project and using LuaLaTeX for compilation works, but this method may slow down the compilation process.

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

## Project History

- This project originated from [YukuanHU](https://github.com/YukuanHu)'s undergraduate thesis, which was uploaded on May 24, 2019.
- Starting May 9, 2021, [ganler](https://github.com/ganler) enhanced the functionalities (project structure and platform compatibility) based on the original project and began maintaining it.
- As of May 12, 2022, [skyleaworlder](https://github.com/skyleaworlder) started contributing to the project, integrated it into [TJ-CSCCG](http://github.com/TJ-CSCCG), and has continued to update and improve it. It has now become a comprehensive undergraduate thesis template.
- From April 2023, [RizhongLin](https://github.com/RizhongLin) began contributing to and managing the project.

We deeply appreciate the efforts of these contributors, whose work has facilitated and assisted many students.

If you find this template helpful for your thesis or dissertation, we hope you will acknowledge and honor these contributors in your acknowledgements section.

## Acknowledgements

We have learned a lot from excellent open-source projects from top universities:

- [sjtug/SJTUThesis](https://github.com/sjtug/SJTUThesis): makefile & batchfile contributions.
- [stone-zeng/fduthesis](https://github.com/stone-zeng/fduthesis): workflows enhancements.

## Contact Information

```python
# Python
[
    f'jiawei#@$.edu'.replace('#', '6').replace('$', 'illinois'),
    f'jgli22@$.edu.cn'.replace('$', 'm.fudan'),
    f'rizhong.lin@$.%'.replace('$', 'epfl').replace('%', 'ch'),
]
```
