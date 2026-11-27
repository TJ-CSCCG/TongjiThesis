<p align="center">
  <img src="figures/tongjithesis.png" alt="TongjiThesis" width="550">
</p>

<p align="center">
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/actions/workflows/test.yaml"><img src="https://github.com/TJ-CSCCG/TongjiThesis/actions/workflows/test.yaml/badge.svg" alt="CI"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/releases"><img src="https://img.shields.io/github/v/release/TJ-CSCCG/TongjiThesis?label=Release" alt="Release"></a>
  <a href="https://www.overleaf.com/latex/templates/tongjithesis-tongji-university-thesis-template/tfvdvyggqybn"><img src="https://img.shields.io/badge/Overleaf-Template-138A07" alt="Overleaf"></a>
  <a href="https://www.latex-project.org/lppl/lppl-1-3c/"><img src="https://img.shields.io/badge/License-LPPL--1.3c-blue" alt="License"></a>
  <a href="https://github.com/TJ-CSCCG/TongjiThesis/stargazers"><img src="https://img.shields.io/github/stars/TJ-CSCCG/TongjiThesis?style=flat" alt="Stars"></a>
  <img src="https://img.shields.io/badge/TeX%20Live-2026-blue" alt="TeX Live 2026">
</p>

<p align="center">
  中文 | <a href="README-EN.md">English</a>
</p>

同济大学本科毕业设计（论文）LaTeX 模板。

> [!NOTE]
> 完整样例 PDF 可在 [Release 页](https://github.com/TJ-CSCCG/TongjiThesis/releases) 下载，或查看 [Overleaf 模板 PDF](https://www.overleaf.com/latex/templates/tongjithesis-tongji-university-thesis-template/tfvdvyggqybn.pdf)。各选项的详细用法见编译后的模板使用指南（第 1 章）。

---

## 快速开始

| 方式               | 说明                                                                                                                                            |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| **Overleaf**       | 通过 [Overleaf 模板链接](https://www.overleaf.com/latex/templates/tongjithesis-tongji-university-thesis-template/tfvdvyggqybn) 直接使用，零配置 |
| **本地编译**       | 安装 [TeX Live 2026+](https://tug.org/texlive/quickinstall.html)，克隆仓库，运行 `make`                                                         |
| **GitHub Actions** | 在自己的 fork 中[运行工作流并下载正文或表单 PDF](#在-github-actions-中编译)                                                                     |

> [!TIP]
> 本模板的 CI 在 **TeX Live 2026** 上测试。本地编译遇到难以解释的错误时，请先检查 TeX Live 版本，并升级到 2026。
>
> 参考文献样式遵循 GB/T 7714-2025。若编译报 `gb7714-2025` 样式或 `gbt7714-2025-numeric.bst` 未找到，说明本地 `biblatex-gb7714-2015` / `gbt7714` 宏包版本过旧，尚未包含 2025 样式，更新即可（需 TeX Live ≥ 2026）：
>
> ```bash
> tlmgr update --self                         # tlmgr 提示需自更新时先执行
> tlmgr update gbt7714 biblatex-gb7714-2015
> ```
>
> macOS / Linux 系统级安装需在命令前加 `sudo`；Windows 用户请在**管理员权限**的命令行中运行（无需 `sudo`）。若使用 MiKTeX，请改用 MiKTeX Console 更新上述宏包。

## 使用方法

### 在线使用

#### 通过 Overleaf 模板直接使用

> [!IMPORTANT]
> 在使用 Overleaf 模板时，请检查编译器和主入口的设置：
>
> - 将 `main.tex` 文件设为主入口文件，而不是项目中的其他文件（如 `tongjithesis.cls`）；
> - 推荐使用 `XeLaTeX` 或 `LuaLaTeX` 编译器；本模板不支持 `pdfLaTeX` 等编译器。

#### 在 Overleaf 上导入本仓库

通过 `Code | Download ZIP` 下载本仓库的 ZIP 文件，拖拽上传至 [Overleaf](https://www.overleaf.com/) 即可。

#### 在 GitHub Actions 中编译

在自己的 fork 中打开 **Actions**，按页面提示启用工作流。之后可以用以下任一方式编译：

- 在 `master` 或 `dev` 分支推送论文源文件（例如 `chapters/metadata.tex`）的修改，会自动运行 `test` 工作流。
- 如果论文写在其他分支，打开 **Actions → test → Run workflow**，选择存放论文的分支，再点 **Run workflow**。仅修改 README 等被忽略的文件时也可以手动运行。

打开与本次提交对应的运行记录，在 **Summary → Artifacts** 中，每个压缩包都以其中的 PDF 命名。正文和三份表单分别编译：

| 需要的文件 | Artifact |
| --- | --- |
| 论文正文（`main.tex`，Linux 上的 XeLaTeX） | `tongjithesis-linux-xelatex` |
| 毕业设计任务书 | `tongjithesis-taskbook` |
| 开题报告 | `tongjithesis-proposal` |
| 中期报告 | `tongjithesis-midterm` |

以上压缩包保留 30 天；`all-compiled-documents` 包含本次运行的全部 PDF，保留 90 天。

带后缀的 `tongjithesis-linux-xelatex-*` 用于测试模板选项，`tongjithesis-ctan-example` 是发行包示例。若没有运行记录，先核对分支和[工作流的触发条件](.github/workflows/test.yaml)；若已有记录但缺少目标 PDF，打开对应的 `build` 或 `build-forms` 任务查看编译日志。

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
make taskbook           # compile taskbook.pdf (任务书)
make proposal           # compile proposal.pdf (开题报告)
make midterm            # compile midterm.pdf (中期报告)
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
.\make.bat taskbook       # compile taskbook.pdf (任务书)
.\make.bat proposal       # compile proposal.pdf (开题报告)
.\make.bat midterm        # compile midterm.pdf (中期报告)
.\make.bat forms          # compile taskbook.pdf, proposal.pdf, and midterm.pdf
.\make.bat help           # read the manual
```

##### 通过 VS Code 及 LaTeX Workshop 插件

安装 LaTeX Workshop 插件后，**直接打开本项目根目录**（即 `TongjiThesis` 文件夹）；打开其他目录时 `.vscode/settings.json` 不会生效。项目已预配置编译方案：打开 `main.tex`，在侧栏 TeX 面板中选择 `Recipe: latexmk (xelatex)` 即可编译，保存时也会自动编译。

##### 在 Docker 中使用

详细使用方法见 [TongjiThesis-env](https://github.com/TJ-CSCCG/TongjiThesis-env)。

### 模板配置

#### 文档类选项

在 `main.tex` 的 `\documentclass` 中配置：

```latex
\documentclass[
  doctype=thesis,       % 文档类型：thesis 论文正文（默认）；taskbook/proposal/midterm 见下方“任务书/开题报告/中期报告”
  oneside,              % 单面打印（默认），使用 twoside 可启用双面打印
  degree=bachelor,      % 学位类型：bachelor（默认），master/doctor 留作扩展
  field=science,        % 专业类别：science 理工科（默认）/ humanities 文科
  algo=algpseudocode,   % algpseudocode（默认）：algorithm+algorithmicx；algorithm2e：独立 algorithm2e 宏包
  minted=false,         % true：minted 代码高亮（需 Python+Pygments）；false：listings（默认）
  biblatex=true,        % true：biblatex+biber（默认）；false：bibtex+gbt7714
  fontset=auto,         % 字体集：auto（默认）选择已安装的、最接近 Word 模板字体的字体集，见下方“字体选择”
  times=false,          % true：使用系统 Times New Roman；false：使用 newtx（默认）
  fullwidthstop=circle, % 句号样式：circle 保留“。”（默认）/ dot 替换为“．”
]{tongjithesis}

\tjbibresource{bib/note.bib}  % 参考文献数据库（支持多文件，逗号分隔）；样式遵循 GB/T 7714-2025
```

> [!NOTE]
> 经管类属社科类。26 届为过渡期，可选 `field=science`（推荐）或 `field=humanities`；自 27 届起统一使用 `field=science`。

### 任务书 / 开题报告 / 中期报告

除正文 `main.tex` 外，模板还提供 3 份可独立编译的官方表格，与正文共用 `chapters/metadata.tex` 中的学院/专业/学生/课题信息（指导教师在 3 份表格中均为手写签字位，不预填）：

| 文档     | 入口文件        | 构建命令                                |
| -------- | --------------- | --------------------------------------- |
| 任务书   | `taskbook.tex`  | `make taskbook` / `.\make.bat taskbook`  |
| 开题报告 | `proposal.tex`  | `make proposal` / `.\make.bat proposal`  |
| 中期报告 | `midterm.tex`   | `make midterm` / `.\make.bat midterm`    |

一次性构建全部 3 个文档：`make forms` / `.\make.bat forms`。任务书的起讫周数由 `\taskbookperiod{起始年}{起始月}{起始日}{截止年}{截止月}{截止日}` 自动换算，无需手动填写。详见编译后的模板使用指南。

### 字体选择

默认的 `fontset=auto` 依次选择已安装的、字形最接近 Word 模板所用中易字体（宋体 SimSun、黑体 SimHei、楷体 KaiTi、仿宋 FangSong）的字体集，并在编译日志中写明所选的字体集：

1. `windows`：中易字体本身（Windows 自带，或放在项目的 `fonts/` 文件夹中）；
2. `founder`：方正书宋、黑体、楷体、仿宋（可从方正官网免费下载，或放在 `fonts/` 中）；
3. `fandol`：Fandol 字体（旧版 TeX Live 与 Overleaf 自带；作者已撤回，TeX Live 将移除）；
4. `texlive`：TeX Live 自带的免费字体（LXGW Neo ZhiSong、LXGW Neo XiHei、AR PL KaitiM GB、LXGW Zhuque Fangsong）。

没有选中 `windows` 时，编译会给出警告。要使用与 Word 模板相同的字体：

- **本地编译**：运行 `make fonts`（Windows：`.\make.bat fonts`），把中易字体下载到项目的 `fonts/` 文件夹。`make fonts FONTSET=founder`（Windows：`.\make.bat fonts founder`）下载方正字体。字体来自 [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex) 的发行版。
- **Overleaf**：从 [cjk-fonts-for-ctex 的最新发行版](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex/releases/latest) 下载 `windows.zip`，解压后把其中的字体文件上传到项目中名为 `fonts` 的文件夹。

也可以直接指定字体集：`windows`、`founder`、`adobe`、`mac`（macOS 自带的宋体-简等）、`fandol`、`texlive`。字体文件所在的文件夹由 `fontdir` 选项指定（默认 `fonts/`，须以 `/` 结尾）：字体集的文件在其中时从这里加载，否则按字体名从系统加载。

中文字体没有斜体，模板以楷体代替。宋体与黑体没有真粗体的字体集（`windows`、`founder`、`adobe`、`texlive`）以描边模拟加粗，描边宽度与 Word 相同（字号的 1/35）。

> [!NOTE]
> 字体版权归其所有者，请按其许可使用。把字体安装到 Linux 系统后，请运行 `fc-cache -fv` 刷新字体缓存。

### 代码高亮与算法排版

#### 代码高亮

1. **`listings`**（默认）：纯 LaTeX 实现，无外部依赖。适合大多数场景。
2. **`minted`**：基于 Python Pygments，语法高亮更丰富。在 `main.tex` 中设置 `minted=true` 即可启用。需要安装 Python 3.11–3.13 并确保 `pygments` 可用（`pip install pygments`）。若系统安装了多个 Python 版本，可通过 `\renewcommand{\MintedPython}{/path/to/python}` 指定 minted 使用的 Python 解释器。

#### 算法排版

1. **`algpseudocode`**（默认）：基于 `algorithm` + `algorithmicx` + `algpseudocode` 宏包，使用 `\State`、`\If`、`\For` 等命令编写伪代码。
2. **`algorithm2e`**：使用独立 `algorithm2e` 宏包，语法与默认方案不同。在 `main.tex` 中设置 `algo=algorithm2e` 即可切换。

## 贡献与项目历史

详见 [CONTRIBUTING.md](CONTRIBUTING.md)。面向 AI 编码代理的架构说明与开发约定见 [AGENTS.md](AGENTS.md)。

## 开源协议

该项目使用 [LPPL-1.3c 许可证](https://www.latex-project.org/lppl/lppl-1-3c/)。详见 [LICENSE](https://github.com/TJ-CSCCG/TongjiThesis/blob/master/LICENSE)。

## 联系方式

如有问题，请通过 [Discussions](https://github.com/TJ-CSCCG/TongjiThesis/discussions) 提问。
