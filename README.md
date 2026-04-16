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
  中文 | <a href="README-EN.md">English</a>
</p>

符合同济大学本科毕业设计论文官方格式要求的 LaTeX 模板。支持 XeLaTeX / LuaLaTeX 编译，提供 `minted` 和 `listings` 两种代码高亮方案，兼容 `biblatex` 和 `bibtex` 两种引用方式。在 Linux、macOS、Windows 三平台 CI 持续测试。

<p align="center">
    <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/TongjiThesis/preview/main_page-0001.jpg" width="23%">
    <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/TongjiThesis/preview/main_page-0002.jpg" width="23%">
    <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/TongjiThesis/preview/main_page-0005.jpg" width="23%">
    <img src="https://media.githubusercontent.com/media/TJ-CSCCG/TJCS-Images/TongjiThesis/preview/main_page-0038.jpg" width="23%">
</p>

> [!NOTE]
> 完整样例可见 [模板输出样例展示（完整版）](https://github.com/TJ-CSCCG/TongjiThesis/discussions/21)、[Release 页](https://github.com/TJ-CSCCG/TongjiThesis/releases) 中 "Assets" 下的 PDF 下载链接或 [Overleaf 模版 PDF](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn.pdf)。

## 主要特性

- 基于 `ctexbook` 文档类，支持 `\frontmatter` / `\mainmatter` / `\backmatter` / `\appendix` 结构
- 符合 2026 版同济大学本科毕业设计（论文）撰写规范（小四正文，1.5 倍行距，小三章标题）
- 支持 `XeLaTeX` 和 `LuaLaTeX` 双编译器
- 支持 `biblatex`（默认）和 `bibtex` 双引用后端，通过 `\makereferences` 统一输出
- 支持 `minted`（默认）和 `listings` 双代码高亮方案
- 提供 `longlisting` 环境，支持跨页代码块
- 内置信息说明页（`\MakeInfoPage`），符合 2026 版官方模板要求
- 支持单面 / 双面打印，双面模式自动添加装订线
- 键值对文档类选项，配置灵活
- Linux / macOS / Windows 三平台 CI 持续测试

---

## 快速开始

| 方式               | 说明                                                                                                                                             |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Overleaf**       | 通过 [Overleaf 模板链接](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn) 直接使用，零配置 |
| **本地编译**       | 安装 [TeX Live 2026+](https://tug.org/texlive/quickinstall.html)，克隆仓库，运行 `make`                                                          |
| **GitHub Actions** | Fork 本仓库，push 即可触发自动编译，在 Artifacts 中下载 PDF                                                                                      |

> [!TIP]
> 本模板的 CI 基于 **TeX Live 2026** 进行测试。如果您在本地编译时遇到难以解释的编译错误，请首先检查并升级您的 TeX Live 至 2026 版本。旧版 TeX Live 中的宏包版本可能与本模板不兼容。

## 使用方法

### 在线使用

#### 通过 Overleaf 模板直接使用

您可以通过 [Overleaf 模板链接](https://www.overleaf.com/latex/templates/tongji-university-undergraduate-thesis-template/tfvdvyggqybn) 直接使用本模板。

> [!IMPORTANT]
> 在使用 Overleaf 模板时，请检查编译器和主入口的设置：
>
> - 将 `main.tex` 文件设为主入口文件，而不是项目中的其他文件（如 `tongjithesis.cls`）；
> - 推荐使用 `XeLaTeX` 和 `LuaLaTeX` 编译器，本模板不支持某些编译器（如 `pdfLaTeX`）。

#### 在 Overleaf 上导入本仓库

- 通过本仓库主页项目文件列表上方的 `Code | Download ZIP` 下载本仓库；
- 打开 [Overleaf](https://www.overleaf.com/)；
- 通过拖拽下载的 `zip` 文件上传至 Overleaf。

#### 在 GitHub Actions 中编译

项目以 `.github/workflows/*.yaml` 配置了 GitHub Actions，push 代码到 fork 仓库或 template-generated 仓库均可触发测试。可通过 commit 对应的 workflow run 中的 `Summary | Artifacts` 获得多平台构建产物。

（通过勾选 `Settings | Actions | General | Allow all actions and reusable workflows` 打开 GitHub Actions）

### 本地使用

#### 安装 TeX 发行版

我们建议参照[官方快速安装指南](https://tug.org/texlive/quickinstall.html)安装 TeX Live（Windows、Linux）或 MacTeX（macOS）。

#### 构建项目

我们推荐使用命令行构建项目，也支持通过 VS Code 的 LaTeX Workshop 插件构建。

##### 通过命令行

###### Makefile (Linux/macOS)

```shell
make all                # compile main.pdf
make ENGINE=$ENGINE all # use $ENGINE (where $ENGINE=-xelatex or -lualatex) to compile main.pdf
make clean              # rm intermediate files
make cleanall           # rm all intermediate files (including .pdf)
make wordcount          # wordcount
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

<details><summary><b>通过 VS Code 及 LaTeX Workshop 插件</b></summary>

在 VS Code 中安装 LaTeX Workshop 插件，然后**直接打开本项目根目录**（即 `TongjiThesis` 文件夹，而非其上层文件夹，否则 `.vscode/settings.json` 配置无法生效）。

因为我们已经在 `.vscode/settings.json` 中配置了 LaTeX Workshop 插件，所以您只需要：

- 选中 `main.tex` 文件；
- 点击左侧边栏中带有 $\TeX$ 图标的按钮；
- 点击 `Build LaTeX project` 列表中的 `Recipe: latexmk (xelatex)` 编译 `.pdf` 文件。

或者，LaTeX Workshop 插件会在您保存文件时自动编译。

</details>

<details><summary><b>在 Docker 中使用</b></summary>

详细使用方法见 [TongjiThesis-env](https://github.com/TJ-CSCCG/TongjiThesis-env)。

</details>

### 模板配置

#### 文档类选项

本模板提供以下文档类选项，可以在 `main.tex` 中进行配置：

```latex
\documentclass[
  oneside,           % 单面打印（默认），使用 twoside 可启用双面打印
  degree=bachelor,   % 学位类型：bachelor（默认），master/doctor 留作扩展
  fullwidthstop=false, % 是否将中文句号"。"替换为西文句号"．"，默认为false
  fontset=fandol,    % 使用的字体集，默认为 fandol
  times=false,       % 是否使用 Times New Roman 字体，默认为 false
  minted=true,       % 是否使用 minted 包进行代码高亮，默认为 true
  biblatex=true,     % 是否使用 biblatex 管理参考文献，默认为 true
]{tongjithesis}

\tjbibresource{bib/note.bib}  % 指定参考文献数据库文件（支持多文件，逗号分隔）
```

<details><summary><b>各选项详细说明</b></summary>

##### 单双面打印选项

- `oneside`：单面打印（默认）
- `twoside`：双面打印，会调整页边距和装订线

##### 字体选项

- `fontset=fandol`：使用 Fandol 字体集（默认）
- `fontset=adobe`：使用 Adobe 字体集（需要安装 Adobe 字体）
- `times=false`：使用 `newtx` 包提供的字体（默认）
- `times=true`：使用 Times New Roman 字体

##### 中文标点选项

- `fullwidthstop=false`：保持中文句号"。"不变（默认）
- `fullwidthstop=true`：将中文句号"。"替换为西文句号"．"

##### 参考文献选项

- `biblatex=true`：使用 `biblatex`（biber 后端）管理参考文献（默认）
- `biblatex=false`：使用 `bibtex` 配合 `gbt7714` 宏包管理参考文献

使用 `\tjbibresource{file1.bib,file2.bib}` 指定参考文献数据库文件，使用 `\makereferences` 输出参考文献列表。

</details>

<details><summary><b>渲染生僻字</b></summary>

由于本模版默认使用 Fandol 字体，对于姓名、专有名词等生僻字的支持可能不够完善。我们在本模版 GitHub 仓库的 [`fonts`](https://github.com/TJ-CSCCG/TongjiThesis/tree/fonts) 分支中提供了 Adobe 字体集，您可以下载、安装这些字体，然后在 `main.tex` 中通过 `fontset=adobe` 选项来使用 Adobe 字体集：

```latex
\documentclass[
  oneside,
  fontset=adobe,
  % 其他选项...
]{tongjithesis}
```

这样修改后，LaTeX 将使用 Adobe 字体集来渲染文档。

**注意**：将 Adobe 字体文件放置在项目根目录下并在 `main.tex` 中指定字体路径的方式并不总是有效。因此，我们建议您将 Adobe 字体文件安装到系统字体目录中。经测试，在 Overleaf 项目的根目录下放置 Adobe 字体文件，并只在使用 LuaLaTeX 编译的方式是有效的，但这种方式可能会导致编译速度变慢。

</details>

#### 代码高亮选项

本模板提供两种代码高亮解决方案：

1. **`minted` 包**（基于 Python）：提供高级的语法高亮功能，需要 Python 环境。
   - 通过在 `main.tex` 中设置 `minted=true`（默认）启用
   - 需要安装 Python 及 Pygments 库（`pip install pygments`）
   - 需要将 Python 添加到系统环境变量 `PATH` 中，
     - 或者在 `main.tex` 中指定 Python 路径（见下文）
   - 编译时需添加 `-shell-escape` 参数（本模板已添加）

2. **`listings` 包**（纯 LaTeX）：不依赖外部程序，在任何环境都能使用。
   - 通过在 `main.tex` 中设置 `minted=false` 启用
   - 无需额外安装任何程序

如果您不希望安装 Python 或遇到 `minted` 相关错误，可以在 `main.tex` 中将 `minted=true` 修改为 `minted=false`。使用 `minted=false` 时，模板将自动使用 `listings` 包处理所有代码，无需其他配置。

<details><summary>使用 <code>minted</code> 但不想将 Python 添加到环境变量 <code>PATH</code> 中？</summary>

可以在 `main.tex` 文件中添加重定向 `minted` 宏包的 Python 路径：

```latex
\renewcommand{\MintedPython}{/path/to/your/python}
```

</details>

## 如何为该项目贡献代码？

详见[贡献指南](CONTRIBUTING.md#提交-pull-request)。

## 开源协议

该项目使用 [LPPL-1.3c 许可证](https://www.latex-project.org/lppl/lppl-1-3c/)。详见 [LICENSE](https://github.com/TJ-CSCCG/TongjiThesis/blob/master/LICENSE) 文件。

## 项目历史

- 该项目起源于 [YukuanHU](https://github.com/YukuanHu) 的本科毕业设计论文，论文于 2019.05.24 上传；
- 2021.05.09 起，[ganler](https://github.com/ganler) 以上述项目为基础，增强其功能（项目结构与平台适配）并开始维护新项目。
- 2022.05.12 起，[skyleaworlder](https://github.com/skyleaworlder) 开始贡献本项目，并将其整合进 [TJ-CSCCG](https://github.com/TJ-CSCCG)，并持续对该项目进行更新和改进，目前已经成为一个完善的本科毕业论文模板。
- 2023.04 起，[RizhongLin](https://github.com/RizhongLin) 开始贡献本项目，并负责项目的维护和更新。
- 2025.04 更新，实现基于键值对的类选项，支持更灵活的配置。
- 2026 更新，迁移至 `ctexbook` 基类，新增 `biblatex`/`bibtex` 双后端、`longlisting` 跨页代码环境、`\makereferences` 统一参考文献输出，CI 升级至 TeX Live 2026；对齐 2026 版撰写规范，新增信息说明页（`\MakeInfoPage`）、字号常量体系（`\tjfontchapter` 等）与续表辅助命令（`\tjlongtablecont`）。

我们非常感谢以上贡献者的付出，他们的工作为更多同学提供了方便和帮助。

在使用本模板时，如果您觉得本项目对您的毕业设计或论文有所帮助，我们希望您可以在您的致谢部分感谢并致以敬意。

## 致谢

我们从顶尖高校的优秀开源项目中学到了很多：

- [sjtug/SJTUThesis](https://github.com/sjtug/SJTUThesis): makefile & batchfile
- [stone-zeng/fduthesis](https://github.com/stone-zeng/fduthesis): workflows

## 联系方式

如有问题，请通过 [Discussions](https://github.com/TJ-CSCCG/TongjiThesis/discussions) 提问。
