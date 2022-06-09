# :page_facing_up: 同济大学本科生毕业设计论文模板（理工类）

中文 | [English](README-EN.md)

> * **注意**：使用该模板你会获得 **pdf** 文件作为输出。但在毕业设计过程中可能存在需要提交 docx 等格式文件的场合，这时你可以使用一些 **pdf 转 docx 工具**，比如：[pdf2go.pdf-to-word](https://www.pdf2go.com/pdf-to-word))。
> * 你 **不需要担心** “抛弃 1 系统的 docx 模板而选用本 LaTeX 模板是否会受到影响”，毕竟使用该模板的我们（[2017-ganler](https://github.com/ganler), [2018-skyleaworlder](https://github.com/skyleaworlder)）都没有因格式问题而被勒令重新排版论文。

## 使用方法

### 1. 直接在 **Overleaf** 上使用（Overleaf 模板）

**点这里跳转至 Overleaf** 👉 [![svg of overleaf-tongjithesis](https://img.shields.io/badge/overleaf-tongjithesis-green.svg)](https://www.overleaf.com/latex/templates/tongji-undergrad-thesis/dfdvqsmpfcgk)

**但请注意！上方的 Overleaf 模板并未及时更新**。因此建议想要使用最新模板的同学们在 Overleaf 上创建自己的项目，具体操作请看[该小节](#2-在-overleaf-上使用最新版本)。

> **注意！** 请检查 Overleaf 项目中对 **编译器** 与 **主入口** 的配置：
>
> * 将 `main.tex` 设为主入口，而非项目中的其他 `.tex` 文件（尤其是 `tongjithesis.cls` 或 `tongjithesis.sty`）；
> * 推荐将 `XeLaTeX` 设置为编译器，本项目不支持某些编译器（如 `pdfLaTeX`）。

### 2. 在 **Overleaf** 上使用最新版本

* 通过本仓库主页项目文件列表上方的 “Code | Download ZIP” 下载本仓库；
* 打开 [Overleaf](https://www.overleaf.com/)；
* 通过拖拽下载的 `zip` 文件上传至 Overleaf。

### 3. 在 Mac / Linux 上使用

#### i. 使用 tlmgr

通过 [此处](https://tug.org/texlive/acquire.html) 下载 TeXLive，并使用 `tlmgr` 下载宏包：

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

#### ii. 通过 Makefile 构建项目

> 感谢 [SJTUThesis](https://github.com/sjtug/SJTUThesis) 项目的 Makefile 文件。

你可以通过下列指令完成对应操作：

```shell
make all                      # compile main.pdf
make clean                    # rm intermediate files
make cleanall                 # rm all intermediate files (including .pdf)
make wordcount                # wordcount
```

### 4. 在 Windows 上使用

#### i. 安装 TeXLive

通过 [此处](https://www.tug.org/texlive/acquire-netinstall.html) 下载 `install-tl-windows.exe`。

#### ii. 通过 Batchfile 构建项目

> 感谢 [SJTUThesis](https://github.com/sjtug/SJTUThesis) 项目的 Compile.bat 文件。

你可以通过下列指令完成对应操作：

```bat
.\make.bat                      # the same to "make.bat thesis"
.\make.bat thesis               # compile main.pdf
.\make.bat clean                # clean all work files by latexmk -c
.\make.bat cleanall             # clean all work files and main.pdf by latexmk -C
.\make.bat wordcount            # wordcount
.\make.bat help                 # read the manual
```

### 5. 在 VSCode 上使用

#### i. 配置 VSCode

在插件市场中安装 LaTeX Workshop 插件，此后下载该项目，并在该项目根目录打开。（LaTeX Workshop 只是一个插件，仍需要下载对应平台下的 `TeXLive`）

> **注意**：下列配置已被项目中 `.vscode/settings.json` 包含。正常情况下，启动 LaTeX Workshop 插件时会自动装载配置。（`.vscode/settings.json` 中的配置会覆盖全局配置文件 `settings.json` 中对应选项，因此不必修改全局配置文件）

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

#### ii. 通过 Workshop 提供的功能编译项目

* 点击左侧边栏中带有 TEX 图标的 LaTeX 按钮；
* 点击 `Build LaTeX project` 列表中的 `Recipe: latexmk (xelatex)` 编译 `.pdf` 文件。

## 如何为该项目贡献代码？

还请查看 [How to pull request](CONTRIBUTING.md/#how-to-pull-request)。

## 开源协议

该项目使用 **“你想干啥就干啥” 协议**（WTFPLv3.1）。

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

## 有关突出贡献的说明

* 该项目起源于 [YukuanHU](https://github.com/YukuanHu) 的本科毕业设计论文，论文于 2019.05.24 上传；
* 2021.05.09 起，[Ganler](https://github.com/ganler) 以上述项目为基础，增强其功能（项目结构与平台适配）并开始维护新项目。

## 致谢

我们从顶尖高校的优秀开源项目中学到了很多：

* [sjtug/SJTUThesis](https://github.com/sjtug/SJTUThesis): makefile & batchfile

## 联系方式

```python
# Python
f'jiawei#@$.edu'.replace('#', '6').replace('$', 'illinois')
```
