# :page_facing_up: Overleaf-Compatible Undergraduate Thesis Template (Tongji Univ.)

English | [中文](README.md)

**NOTE**:

* Till May 26th, 2021, our "great"🙄 `1.tongji.edu` is not able to support uploading `.pdf` files (but only MS Word files). But you may simply convert the generated PDF to `docx` using some online tools (e.g., [pdf2go.pdf-to-word](https://www.pdf2go.com/pdf-to-word))

## Use it on **Overleaf** NOW!

**CLICK ME** 👉 [![svg of overleaf-tongjithesis](https://img.shields.io/badge/overleaf-tongjithesis-green.svg)](https://www.overleaf.com/latex/templates/tongji-undergrad-thesis/dfdvqsmpfcgk)

Note that **the overleaf template might not be up-to-date** so it is suggested to create your own overleaf project manually (see the [section](#use-latest-version-on-overleaf) below).

**NOTICE!** Check **Compiler** and **Main document** you use in overleaf settings:

* Please select `main.tex` as the main file. Other files except `main.tex` should not be the value of main document option.
* Please compile it with `XeLaTeX` (suggested) or some other supported compiler (e.g. `pdfLaTeX` is **NOT** supported).

## Use latest version on Overleaf

* Download this repo `Code | Download ZIP`;
* Open [Overleaf](https://www.overleaf.com/);
* Click upload project and drag the `.zip` file into Overleaf panel;

## Compile it locally on Mac/Linux/Windows

```shell
# Install BasicTex: https://mirrors.chevalier.io/CTAN/systems/mac/mactex/mactex-basictex-20210325.pkg
sudo tlmgr update --self

sudo tlmgr install texliveonfly
sudo tlmgr install latexmk
sudo tlmgr install adjustbox
sudo tlmgr install tcolorbox
sudo tlmgr install collectbox
sudo tlmgr install ucs
sudo tlmgr install environ
sudo tlmgr install titling
sudo tlmgr install enumitem
sudo tlmgr install rsfs
sudo tlmgr install tocloft
sudo tlmgr install xcolor
sudo tlmgr install trimspaces
sudo tlmgr install zhnumber
sudo tlmgr install ctex
sudo tlmgr install texcount
sudo tlmgr install needspace
sudo tlmgr install xecjk
sudo tlmgr install subfigure
sudo tlmgr install cases
sudo tlmgr install algorithms
sudo tlmgr install multirow

sudo tlmgr update --self --all
```

### Makefile

Credit: https://github.com/sjtug/SJTUThesis

```shell
make all                      # compile main.pdf
make clean                    # rm intermediate files
make cleanall                 # rm all intermediate files (including .pdf)
make wordcount                # wordcount
```

### Batchfile

Credit: https://github.com/sjtug/SJTUThesis

```bat
.\make.bat                      # the same to "make.bat thesis"
.\make.bat thesis               # compile main.pdf
.\make.bat clean                # clean all work files by latexmk -c
.\make.bat cleanall             # clean all work files and main.pdf by latexmk -C
.\make.bat wordcount            # wordcount
.\make.bat help                 # read the manual
```

### LaTeXMK + XeLaTeX on LaTeX-Workshop

Add the following attribute to your `settings.json`:

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

## Call for contribution

* First, read [this(CONTRIBUTING)](CONTRIBUTING.md) to know how to cooperate with git and GitHub.
* Then, read [this(ROADMAP)](ROADMAP.md) to know our "wishlist".
* Finally, fork [this repository](https://github.com/TJ-CSCCG/tongji-undergrad-thesis) and begin your contribution.

## LICENSE

We follow WTFPLv3.1 as our license.

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

## Credit

Initial template provided by [YukuanHU](https://github.com/YukuanHu), maintained/promoted by [Ganler](https://github.com/ganler).

## Thanks

We learned a lot from the leading university open-source repositories:

* https://github.com/sjtug/SJTUThesis (makefile & batchfile)

## Contact

```python
# Python
f'jiawei#@$.edu'.replace('#', '6').replace('$', 'illinois')
```
