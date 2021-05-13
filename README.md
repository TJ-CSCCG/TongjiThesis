# Overleaf-Compatible Undergraduate Thesis Template (Tongji Univ.)

**Main Credit: Yukuan HU (Department of Mathematic, class of 2015)**

Ganler only made little effort to make it compatible with latest XeLatex (May, 2021) environment on Overleaf.

**NOTE: Please select `main.tex` as the main file and compile it with `XeLaTeX` or `LuaLaTex`.**

## Compile it locally on Mac (on LaTeX-Workshop)

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
sudo tlmgr install needspace
sudo tlmgr install xecjk
sudo  tlmgr install subfigure 
sudo  tlmgr install cases 
sudo  tlmgr install algorithms 
sudo  tlmgr install multirow
sudo  tlmgr install catchfile

sudo tlmgr update --self --all
```

### XeLaTeX

Add the following attribute to your `setting.json`:

```json
"latex-workshop.latex.recipe.default": "latexmk (xelatex)",
"latex-workshop.latex.tools": [
    {
        "name": "xelatexmk",
        "command": "latexmk",
        "args": [
            "-xelatex",
            "-aux-directory=_out",
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
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

### LuaLaTeX

```shell
# This important for 10.15+ Mac
sudo tlmgr conf texmf OSFONTDIR /System/Library/AssetsV2/com_apple_MobileAsset_Font6/
luaotfload-tool -vvv --update --force
```

`setting.json`

```json
"latex-workshop.latex.recipe.default": "lualatex-mac",
    "latex-workshop.latex.tools": [
        {
            "name": "lualatex",
            "command": "lualatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-shell-escape",
                "-pdf",
                "%DOC%"
            ]
        },
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "lualatex-mac",
            "tools": [
                "lualatex",
            ]
        }
    ],
```

---

all rights reserved by Yukuan HU.