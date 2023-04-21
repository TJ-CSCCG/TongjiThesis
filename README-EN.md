# :page_facing_up: Tongji University Undergraduate Thesis Template (STEM)

English | [中文](README.md)

> * **Note**: By using this template, you will obtain a **pdf** file as output. However, during the process of undergraduate thesis, there may be situations where you need to submit files in docx or other formats. In such cases, you can use some **pdf to docx conversion tools**, such as: [pdf2go.pdf-to-word](https://www.pdf2go.com/pdf-to-word)).
> * You do **not need to worry** about whether abandoning the docx template of the 1 system and choosing this LaTeX template will be affected by formatting issues. After all, those of us who use this template ([2017-ganler](https://github.com/ganler), [2018-skyleaworlder](https://github.com/skyleaworlder)) have not been required to reformat our papers due to formatting issues.

## Sample Display

> The complete sample can be found in [Template Output Sample Display (Full Version)](https://github.com/TJ-CSCCG/tongji-undergrad-thesis/discussions/21) or in the pdf download link under "Assets" in the [Release page](https://github.com/TJ-CSCCG/tongji-undergrad-thesis/releases).

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

#### i. Use tlmgr

Download TeXLive and use `tlmgr` to download packages:

```shell
# The following commands aims at installing packages upon TeXLive without any packages.
# You can also install BasicTex: https://mirrors.chevalier.io/CTAN/systems/mac/mactex/mactex-basictex-20210325.pkg
sudo tlmgr update --self

sudo tlmgr install adjustbox algorithm \
    cases caption chngcntr collectbox ctex enumerate enumitem environ extarrows fancybox fancyhdr \
    lastpage latexmk longtable mathptmx minted multirow needspace rsfs setspace subfigure \
    tcolorbox texcount texliveonfly tikz titling \
    tocloft trimspaces ucs verbatim xcolor xecjk zhnumber

sudo tlmgr update --self --all
```

#### ii. Build the project through Makefile

Thanks to the Makefile file of the [SJTUThesis](https://github.com/sjtug/SJTUThesis) project, you can build the project through Makefile:

```shell
make all                      # compile main.pdf
make ENGINE=$ENGINE all       # use $ENGINE(where $ENGINE=-xelatex or -lualatex) to compile main.pdf
make clean                    # rm intermediate files
make cleanall                 # rm all intermediate files (including .pdf)
make wordcount                # wordcount
```

### 4. Using on Windows

#### i. Install TeXLive

Download `install-tl-windows.exe` from [here](https://www.tug.org/texlive/acquire-netinstall.html).

#### ii. Build the project through Batchfile

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

## How to contribute to this project?

Please refer to [How to pull request](CONTRIBUTING.md/#how-to-pull-request).

## Open Source License

This project uses the **“Do What The Fuck You Want To Public License” (WTFPLv3.1)**.

```text
              DO WHAT THE FUCK YOU WANT TO PUBLIC LICENCE
                         Version 3.1, July 2019
                     https://ph.dtf.wtf/u/wtfplv31

by Sam Hocevar <sam@hocevar.net>
   theiostream <matoe@matoe.co.cc>
   dtf         <wtfpl@dtf.wtf>

              DO WHAT THE FUCK YOU WANT TO PUBLIC LICENCE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

0. You just DO WHAT THE FUCK YOU WANT TO.
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
