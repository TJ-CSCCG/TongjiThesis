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
> 完整样例可见 [Release 页](https://github.com/TJ-CSCCG/TongjiThesis/releases) 的 PDF 下载或 [Overleaf 模版 PDF](https://www.overleaf.com/latex/templates/tongjithesis-tongji-university-thesis-template/tfvdvyggqybn.pdf)。各选项的详细用法见编译后的模板使用指南（第 1 章）。

---

## 快速开始

| 方式               | 说明                                                                                                                                            |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| **Overleaf**       | 通过 [Overleaf 模板链接](https://www.overleaf.com/latex/templates/tongjithesis-tongji-university-thesis-template/tfvdvyggqybn) 直接使用，零配置 |
| **本地编译**       | 安装 [TeX Live 2026+](https://tug.org/texlive/quickinstall.html)，克隆仓库，运行 `make`                                                         |
| **GitHub Actions** | Fork 本仓库，push 即可触发自动编译，在 Artifacts 中下载 PDF                                                                                     |

> [!TIP]
> 本模板的 CI 基于 **TeX Live 2026** 进行测试。如果您在本地编译时遇到难以解释的编译错误，请首先检查并升级您的 TeX Live 至 2026 版本。

## 使用方法

### 在线使用

#### 通过 Overleaf 模板直接使用

> [!IMPORTANT]
> 在使用 Overleaf 模板时，请检查编译器和主入口的设置：
>
> - 将 `main.tex` 文件设为主入口文件，而不是项目中的其他文件（如 `tongjithesis.cls`）；
> - 推荐使用 `XeLaTeX` 和 `LuaLaTeX` 编译器，本模板不支持某些编译器（如 `pdfLaTeX`）。

#### 在 Overleaf 上导入本仓库

通过 `Code | Download ZIP` 下载本仓库的 ZIP 文件，拖拽上传至 [Overleaf](https://www.overleaf.com/) 即可。

#### 在 GitHub Actions 中编译

Fork 本仓库后 push 即可触发 CI，在 workflow run 的 `Summary | Artifacts` 下载 PDF。首次需在 `Settings | Actions | General` 中启用 Actions。

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

##### 通过 VS Code 及 LaTeX Workshop 插件

安装 LaTeX Workshop 插件后，**直接打开本项目根目录**（即 `TongjiThesis` 文件夹，否则 `.vscode/settings.json` 无法生效）。项目已预配置编译方案：打开 `main.tex`，在侧栏 TeX 面板中选择 `Recipe: latexmk (xelatex)` 即可编译，保存时也会自动编译。

##### 在 Docker 中使用

详细使用方法见 [TongjiThesis-env](https://github.com/TJ-CSCCG/TongjiThesis-env)。

### 模板配置

#### 文档类选项

在 `main.tex` 的 `\documentclass` 中配置：

```latex
\documentclass[
  oneside,              % 单面打印（默认），使用 twoside 可启用双面打印
  degree=bachelor,      % 学位类型：bachelor（默认），master/doctor 留作扩展
  field=science,        % 专业类别：science 理工科（默认）/ humanities 文科
  fullwidthstop=circle, % 句号样式：circle 保留"。"（默认）/ dot 替换为"．"
  fontset=fandol,       % 字体集，传递给 ctex，默认为 fandol
  times=false,          % true：使用系统 Times New Roman；false：使用 newtx（默认）
  minted=true,          % true：minted 代码高亮（需 Python+Pygments）；false：listings
  biblatex=true,        % true：biblatex+biber（默认）；false：bibtex+gbt7714
]{tongjithesis}

\tjbibresource{bib/note.bib}  % 指定参考文献数据库文件（支持多文件，逗号分隔）
```

> [!NOTE]
> 经管类属社科类，26 届为过渡期可选 `field=science`（推荐）或 `field=humanities`；自 27 届起统一使用 `field=science`。

### 字体选择

- **Windows 用户**：可直接使用 `fontset=windows`，系统自带 SimSun / SimHei / KaiTi / FangSong 等字体，覆盖更广。
- **跨平台用户**：推荐默认的 `fontset=fandol`（随 TeX Live 安装，零配置）。如需更广字符覆盖，可从 [cjk-fonts-for-ctex](https://github.com/TJ-CSCCG/cjk-fonts-for-ctex) 下载 `adobe` / `founder` / `windows` 等字体并安装到系统，然后切换 `fontset`。

> [!NOTE]
> 安装新字体后请运行 `fc-cache -fv` 刷新字体缓存。

### 代码高亮

1. **`minted`**（默认）：基于 Python Pygments，语法高亮更丰富。需安装 Python 并确保 `pygments` 可用（`pip install pygments`）。
2. **`listings`**：纯 LaTeX 实现，无外部依赖。

在 `main.tex` 中设置 `minted=false` 即可切换。遇到 `minted` 相关错误时，改为 `minted=false` 即可。

## 贡献与项目历史

详见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 开源协议

该项目使用 [LPPL-1.3c 许可证](https://www.latex-project.org/lppl/lppl-1-3c/)。详见 [LICENSE](https://github.com/TJ-CSCCG/TongjiThesis/blob/master/LICENSE)。

## 联系方式

如有问题，请通过 [Discussions](https://github.com/TJ-CSCCG/TongjiThesis/discussions) 提问。
