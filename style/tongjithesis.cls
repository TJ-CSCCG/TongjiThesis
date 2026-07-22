%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tongjithesis -- Tongji University Thesis Template
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tongjithesis}[v1.4.3 Tongji University Thesis Class] %x-release-please-version
%% TongjiThesis
%% Copyright 2023-2026 TJ-CSCCG
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status "maintained".
%
% The Current Maintainer of this work is R. Lin.
%
% This work consists of the files tongjithesis.cls and tongjithesis.cfg,
% and all accompanying *.tex files in
%   https://github.com/TJ-CSCCG/TongjiThesis

% ==========================================
% Option Declaration
% ==========================================
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=tongjithesis,
  prefix=tongjithesis@,
  setkeys=\kvsetkeys
}

% Define fontset option (default is fandol)
\DeclareStringOption[fandol]{fontset}
% Define fullwidthstop option: circle（默认，保留 。）或 dot（替换为 ．）
\DeclareStringOption[circle]{fullwidthstop}
% Define times option (default is false)
\DeclareBoolOption[false]{times}
% Define minted option (default is false)
\DeclareBoolOption[false]{minted}
% Define biblatex option (default is true)
\DeclareBoolOption[true]{biblatex}
% Define degree option: bachelor (default), master, doctor
\DeclareStringOption[bachelor]{degree}
% Define field option: science (default, 理工科), humanities (文科 — 人文/法学/外语/艺术)
% 经管类属社科：编号要求依理工，撰写依理工模版。26 届为过渡期，可选 science 或
% humanities；自 27 届起统一使用 science。
\DeclareStringOption[science]{field}
% Define algo option: algpseudocode (default, algorithm + algorithmicx + algpseudocode),
% algorithm2e (standalone algorithm2e package)
\DeclareStringOption[algpseudocode]{algo}
% Define doctype option: which document \MakeDocument renders.
% thesis (default) — full thesis flow, unaffected (call \MakeCover/\MakeInfoPage as before)
% taskbook  — 毕业设计（论文）任务书；proposal — 开题报告；midterm — 中期报告
\DeclareStringOption[thesis]{doctype}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*

% Validate type option and set boolean flags
\RequirePackage{etoolbox}
\newif\iftongjithesis@bachelor
\expandafter\ifstrequal\expandafter{\tongjithesis@degree}{bachelor}{%
  \tongjithesis@bachelortrue
}{%
  \ClassWarning{tongjithesis}{type=\tongjithesis@degree\space is reserved for future use. Falling back to bachelor format}%
  \tongjithesis@bachelortrue
}
\newif\iftongjithesis@humanities
\expandafter\ifstrequal\expandafter{\tongjithesis@field}{humanities}{%
  \tongjithesis@humanitiestrue
}{%
  \expandafter\ifstrequal\expandafter{\tongjithesis@field}{science}{}{%
    \ClassWarning{tongjithesis}{field=\tongjithesis@field\space is unknown. Falling back to science format}%
  }%
}
\newif\iftongjithesis@algorithmtwoe
\expandafter\ifstrequal\expandafter{\tongjithesis@algo}{algorithm2e}{%
  \tongjithesis@algorithmtwoetrue
}{}{}
\let\iftjalgorithmtwoe\iftongjithesis@algorithmtwoe
\newif\iftongjithesis@doctype@taskbook
\newif\iftongjithesis@doctype@proposal
\newif\iftongjithesis@doctype@midterm
\expandafter\ifstrequal\expandafter{\tongjithesis@doctype}{taskbook}{%
  \tongjithesis@doctype@taskbooktrue
}{%
  \expandafter\ifstrequal\expandafter{\tongjithesis@doctype}{proposal}{%
    \tongjithesis@doctype@proposaltrue
  }{%
    \expandafter\ifstrequal\expandafter{\tongjithesis@doctype}{midterm}{%
      \tongjithesis@doctype@midtermtrue
    }{%
      \expandafter\ifstrequal\expandafter{\tongjithesis@doctype}{thesis}{}{%
        \ClassWarning{tongjithesis}{doctype=\tongjithesis@doctype\space is unknown. Falling back to thesis}%
      }%
    }%
  }%
}

% ==========================================
% Class Loading
% ==========================================
% 加载 ctexbook 类
\LoadClass[UTF8,a4paper,zihao=-4,fontset=none]{ctexbook}  % zihao=-4 must match \tjfontbody (小四号)

% Load our CJK fontset definition (fontspec is now available via ctexbook)
\IfFileExists{tongji-cjk-font-\tongjithesis@fontset.def}
  {\input{tongji-cjk-font-\tongjithesis@fontset.def}}
  {\ClassError{tongjithesis}{Unknown fontset: \tongjithesis@fontset}{}}

% ==========================================
% Formatting Constants (官方模板规范)
% ==========================================
% Font sizes
\newcommand{\tjfonttitle}{\zihao{-2}}        % 课题名称：小二号
\newcommand{\tjfontchapter}{\zihao{-3}}      % 章标题：小三号
\newcommand{\tjfontheading}{\zihao{4}}       % 摘要 / 目录 / 参考文献 / 谢辞标题：四号
\newcommand{\tjfontbody}{\zihao{-4}}         % 正文 / 二三级标题 / 关键词 / 摘要正文：小四号
\newcommand{\tjfontcaption}{\zihao{5}}       % 表题 / 图题：五号
\newcommand{\tjfontcover}{\zihao{-3}}        % 封面表格字段值：小三号（与 \tjfontchapter 同字号，语义分离）
\newcommand{\tjfonttable}{\zihao{-5}\fontsize{9}{18}\linespread{1}\selectfont} % 表内文字：小五号，行距 18 磅（官方规范；\linespread{1} 隔离全文 1.625 倍行距）
\newcommand{\tjfontinfotitle}{\zihao{3}}     % 信息说明页标题：三号（仅此页专用）
% Spacing
% Word 的 "0.5 行" 按单倍行距字体行高计算（≈ 字号 × 1.2 × 0.5 = 0.6em），
% 与段落自身行距无关；不能用 0.5\baselineskip（会被 \setstretch 拉伸）。
\newcommand{\tjskipbeforesec}{0.6em}            % 段前 0.5 行（Word 口径）
\newcommand{\tjskipaftersec}{0.6em}             % 段后 0.5 行（Word 口径）
% 行距（近似 Word 模板行距倍数；LaTeX 与 Word 的度量略有差异）
\newcommand{\tjlinespread}{1.625}            % 正文 / 摘要：Word 1.5 倍
\newcommand{\tjtoclinespread}{1.625}         % 目录：Word 1.5 倍
% 信息说明页行距（官方规范固定值，linespread = 目标磅数 ÷ (字号 × 1.2)）
\newcommand{\tjinfofieldspread}{1.6667}   % 四号宋体 28 磅：28÷(14×1.2)≈5/3
\newcommand{\tjinfoabstractspread}{1.25}  % 摘要小四 18 磅：18÷(12×1.2)=5/4（精确）
\newcommand{\tjinfotitlevspace}{0.8em}    % 多行课题名称后的间距补偿（在四号上下文中解析）
\newcommand{\tjcoverlinestretch}{0.8}   % 封面字段 parbox 行距倍率（压缩行距以适配窄框）
% Cover text：理工=毕业设计（论文）；文科=毕业论文（设计）
\iftongjithesis@humanities
  \newcommand{\tjcovertext}{毕业论文（设计）}
\else
  \newcommand{\tjcovertext}{毕业设计（论文）}
\fi
% Header text：理工=毕业设计（论文）；文科=毕业论文（设计）
\iftongjithesis@humanities
  \newcommand{\tjheadertext}{毕业论文（设计）}
\else
  \newcommand{\tjheadertext}{毕业设计（论文）}
\fi

% ==========================================
% Required Packages
% ==========================================
% Page layout
% headheight 43pt ≈ 1.14cm logo (≈32pt) + 小四号正文行 (≈11pt)；防止 fancyhdr headheight warning
\setlength{\headheight}{43pt}
% 页边距按同济本科毕业设计（论文）/毕业论文（设计）官方 Word 模板复刻；
% 任务书/开题报告/中期报告使用各自官方模板的页边距（A4，上 2.3cm/下 1.0cm/
% 左右各 3.17cm，左右对称），与论文正文的装订页边距（左 3.3cm/右 1.8cm）不同。
\iftongjithesis@doctype@taskbook
  \RequirePackage[a4paper,top=2.3cm,bottom=1.0cm,left=3.17cm,right=3.17cm]{geometry}
\else\iftongjithesis@doctype@proposal
  \RequirePackage[a4paper,top=2.3cm,bottom=1.0cm,left=3.17cm,right=3.17cm]{geometry}
\else\iftongjithesis@doctype@midterm
  \RequirePackage[a4paper,top=2.3cm,bottom=1.0cm,left=3.17cm,right=3.17cm]{geometry}
\else
  \RequirePackage[a4paper,top=4.0cm,bottom=2.7cm,left=3.3cm,right=1.8cm]{geometry}
\fi\fi\fi
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{eso-pic}
\RequirePackage{emptypage}

% Typography and text formatting
\RequirePackage[T1]{fontenc}
\RequirePackage{setspace}
\RequirePackage[inline]{enumitem}
\RequirePackage{alphalph}
\RequirePackage{circledsteps}
\RequirePackage[normalem]{ulem}
\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{hologo}
\RequirePackage{graphicx}

% Table of contents
% [titles]: 让 ctex 保留其 \contentsname/\listfigurename 等中文名；tocloft 不会覆盖。
% 副作用：ToC 标题由 class 的 \chapter* 渲染，\cft*toctitle* 钩子失效。
\RequirePackage[titles]{tocloft}

% Mathematics
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,amscd}
% @ is already a letter in a .cls file; no \makeatletter needed here or below.
\iftongjithesis@times
  \RequirePackage{fontspec}%
  \setmainfont{Times New Roman}%
\else
  \RequirePackage{newtx}%
  \defaultfontfeatures{Ligatures = TeX}%
\fi

\RequirePackage{upgreek}

% Circled number rendering (Unicode 0–50 + circledsteps 51+)
\InputIfFileExists{tongji-circled.def}{}{\ClassError{tongjithesis}{Missing tongji-circled.def}{}}

% Tables and figures
\RequirePackage{float}
\RequirePackage{multirow}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{threeparttable}
\RequirePackage{threeparttablex}
\RequirePackage{tabularx} % 三线表两端与页面对齐（官方规范）
% Caption customization (must load before subcaption, which internally loads caption)
\RequirePackage{caption}
\DeclareCaptionLabelSeparator{tj@twospace}{\ ~}
\DeclareCaptionFont{tj@songti}{\songti}
\DeclareCaptionFont{tj@caption}{\tjfontcaption}
\captionsetup{labelsep=tj@twospace,font={tj@caption,tj@songti}}
% 代码块标题与代码框之间留出呼吸空间（listings / minted）
\captionsetup[lstlisting]{skip=12pt}
\captionsetup[listing]{skip=12pt}

\RequirePackage{subcaption}
% Override subcaption default `font+=smaller` so sub-captions match main caption size.
% Other settings (labelsep, labelformat, skip) inherit defaults — labelsep follows the
% global tj@twospace from line above; labelformat=parens renders `(a)` style.
\captionsetup[sub]{font={tj@caption,tj@songti}}

% Algorithms and code listings
\iftongjithesis@algorithmtwoe
  \RequirePackage[ruled,linesnumbered,algochapter]{algorithm2e}
  \let\c@algorithm\c@algocf
  \renewcommand{\thealgocf}{\thealgorithm}
\else
  \RequirePackage{algorithm}
  \RequirePackage{algorithmicx}
  \RequirePackage{algpseudocode}
\fi

% Always load listings package first (mandatory)
\RequirePackage{listings}
\definecolor{bg}{rgb}{0.96,0.96,0.96}
\definecolor{commentcolor}{rgb}{0.24,0.48,0.48}
\definecolor{stringcolor}{rgb}{0.73,0.13,0.13}
\definecolor{keywordcolor}{rgb}{0.0,0.502,0.0}
\lstset{
  backgroundcolor=\color{bg},
  basicstyle=\small\ttfamily\linespread{1.0}\selectfont,
  keywordstyle=\color{keywordcolor}\bfseries,
  commentstyle=\color{commentcolor}\itshape,
  stringstyle=\color{stringcolor},
  numbers=left,
  numberstyle=\small\color{gray},
  numbersep=12pt,
  xleftmargin=2.5em,
  xrightmargin=2mm,     % equal to framesep; keeps frame right edge within text area
  frame=single,
  rulecolor=\color{gray!40},
  framesep=2mm,
  aboveskip=\baselineskip,
  belowskip=\smallskipamount,
  breaklines=true,
  showstringspaces=false,
  captionpos=b,
  tabsize=4,
  mathescape=true,
  escapeinside=||,
  belowskip=0pt,
}
\renewcommand{\lstlistingname}{代码}
\renewcommand{\lstlistlistingname}{代码列表}

% Enhanced verbatim support (pure TeX, no Python dependency).
% fvextra extends fancyvrb with breaklines/breakanywhere/\Verb/bgcolor/etc.
% Loaded BEFORE minted so minted (which pulls in fancyvrb internally) sees the extensions.
% \fvset aligned with \lstset and \setminted so Verbatim / lstlisting / minted
% blocks share one visual treatment: gray bg, thin frame, left line numbers, mathescape.
\RequirePackage{fvextra}
\fvset{
  frame=single,
  framesep=2mm,
  rulecolor=\color{gray!40},
  numbers=left,
  numbersep=12pt,
  xleftmargin=2.5em,
  fontsize=\small,
  baselinestretch=1,
  tabsize=4,
  breaklines=true,
  mathescape=true
}
% fvextra v1.8.0 (2024-09-14) introduced bgcolor; guard for older TeX Live
\@ifpackagelater{fvextra}{2024/09/14}{%
  \fvset{bgcolor=bg}%
}{}

% Conditionally load minted package (optional)
\iftongjithesis@minted
  \RequirePackage[chapter]{minted}
  \setminted{linenos,
    frame=single,
    framesep=2mm,
    rulecolor=\color{gray!40},
    fontsize=\small,
    breaklines,
    mathescape,
    escapeinside=||}
  % fvextra v1.8.0 (2024-09-14) introduced bgcolor; guard for older TeX Live
  \@ifpackagelater{fvextra}{2024/09/14}{%
    \setminted{bgcolor=bg}%
  }{}
  \renewcommand{\listingscaption}{代码}

  % When using minted, DO NOT redefine the listing environment
  % It's already defined by the minted package
\else
  % When not using minted, create compatibility layer
  \newfloat{listing}{htbp}{lop}
  \floatname{listing}{代码}

  % Define a fake minted environment that forwards to listings
  \newenvironment{minted}[2][]{%
    \begin{lstlisting}[language=#2,#1]%
  }{%
    \end{lstlisting}%
  }

  % Define inputminted command
  \newcommand{\inputminted}[3][]{\lstinputlisting[language=#2,#1]{#3}}
\fi

% Non-float listing environment for cross-page code with captions.
% Normalise lstlisting's \belowskip inside this env so it matches minted's
% natural trailing (~10pt); combined with skip=2pt, both engines yield the
% same ~12pt gap between code and caption. The \lstset call is group-local
% to the environment, so regular (non-longlisting) lstlisting blocks keep
% their configured belowskip.
\newenvironment{longlisting}
  {\captionsetup{type=listing,skip=2pt}\lstset{belowskip=10pt}}
  {\medskip}

\RequirePackage{tcolorbox}
\RequirePackage{verbatim}  % kept for \comment / \verbatiminput; lowercase `verbatim` env is a kernel feature

% Cross-referencing and hyperlinks
\RequirePackage[colorlinks,allcolors=black,unicode=true]{hyperref}
\RequirePackage{nameref}
\RequirePackage[nameinlink,noabbrev]{cleveref}

% Units and graphics
\RequirePackage{siunitx}[=v2]
\RequirePackage{pgf}
\RequirePackage{tikz}

% ==========================================
% Bibliography Configuration
% ==========================================
% 参考文献样式遵循 GB/T 7714-2025。所需宏包版本（均随 TeX Live 2026+ 分发）：
%   - biblatex 路径：biblatex-gb7714-2015 >= v1.1w（提供 gb7714-2025 样式）
%   - bibtex   路径：gbt7714 >= v2.2.0（提供 gbt7714-2025-numeric.bst）
% 版本过旧会报「style/bst not found」错误；升级步骤见 README「快速开始」提示。
\iftongjithesis@biblatex
  \RequirePackage[
    backend=biber,
    style=gb7714-2025,
    gbpunctwidth=mixed,   % GB/T 7714-2025：除“.”与“[]”用半角外，其余标识符用全角
    natbib=true,
  ]{biblatex}
  % 参考文献序号左对齐至页边距，悬挂统一为 0.74cm（与 Word 模板一致）。
  % 0.74cm 为最小宽度；若实际最宽标签（如 [100]+ 三位数引用）超过 0.74cm，
  % 则使用实际宽度，避免标签溢出与正文首字符重叠。
  \defbibenvironment{bibliography}
    {\list
       {\printtext[labelnumberwidth]{%
          \printfield{labelprefix}%
          \printfield{labelnumber}}}
       {\setlength{\labelwidth}{\labelnumberwidth}%
        \ifdim\labelwidth<0.74cm \setlength{\labelwidth}{0.74cm}\fi
        \setlength{\labelsep}{0pt}%
        \setlength{\leftmargin}{\labelwidth}%
        \setlength{\itemindent}{0pt}%
        \setlength{\itemsep}{\bibitemsep}%
        \setlength{\parsep}{\bibparsep}%
        \renewcommand*{\makelabel}[1]{##1\hfill}}}
    {\endlist}
    {\item}
\else
  \RequirePackage[sort&compress, bibpunct=GB]{gbt7714}   % GB=全角标点（除“.”“[]”外），与 biblatex 的 gbpunctwidth=mixed 对齐
  \bibliographystyle{gbt7714-2025-numeric}
  \setlength{\bibsep}{3pt}
  % 参考文献序号左对齐至页边距，悬挂统一为 0.74cm（与 Word 模板一致）。
  % gbt7714 已将 \@biblabel 改为 [#1]\hfill（左对齐）。natbib（gbt7714 内部加载）
  % 重写了 thebibliography，绕过 book.cls 的 \@openbib@code 钩子，因此须直接
  % 替换 numeric 模式下的列表参数宏 \@bibsetup（natbib 默认 \let 至 \NAT@bibsetnum）。
  % 0.74cm 为最小宽度；若实际最宽标签更宽（如 [100]+），则使用实际宽度。
  % \AtBeginDocument 确保替换在 natbib 自身 \NAT@set@cites 钩子（同样在 \AtBeginDocument）
  % 之后生效；用独立辅助宏 \tj@bibsetup 避免 \xdef 展开期 ## 参数歧义。
  \newcommand{\tj@bibsetup}[1]{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \ifdim\labelwidth<0.74cm \setlength{\labelwidth}{0.74cm}\fi
    \setlength{\leftmargin}{\labelwidth}%
    \setlength{\labelsep}{0pt}%
    \setlength{\itemsep}{\bibsep}%
    \setlength{\parsep}{\z@}}
  \AtBeginDocument{\let\@bibsetup\tj@bibsetup}
\fi

% \tjbibresource{file1,file2,...} — register bib files (preamble only)
\newcommand{\tj@bibfiles}{}
\iftongjithesis@biblatex
  \newcommand{\tjbibresource}[1]{%
    \def\do##1{\addbibresource{##1}}%
    \docsvlist{#1}%
  }
\else
  \newcommand{\tjbibresource}[1]{%
    \def\tj@bibfiles{#1}%
  }
\fi

% \makereferences — output bibliography chapter
\iftongjithesis@biblatex
  \newcommand{\makereferences}{%
    \printbibliography[heading=bibintoc,title=参考文献]%
  }
\else
  \newcommand{\makereferences}{%
    \addcontentsline{toc}{chapter}{参考文献}%
    \bibliography{\tj@bibfiles}%
  }
\fi

% ==========================================
% General Configurations
% ==========================================

% Line spacing
\setstretch{\tjlinespread}  % 设置全文行距

% Display math spacing — 公式段前 0 行，段后 0 行（官方规范）
% 公式前后不额外增加间距，仅依靠正文 1.5 倍行距的自然行间过渡。
\abovedisplayskip 0\p@
\abovedisplayshortskip 0\p@
\belowdisplayskip \abovedisplayskip
\belowdisplayshortskip 0\p@

% Table float spacing — 表格/图片上下与正文之间各空一行（官方规范）
\setlength{\textfloatsep}{\baselineskip}
\setlength{\intextsep}{\baselineskip}
\setlength{\floatsep}{0.5\baselineskip}

% 图居中（官方规范）
\AtBeginEnvironment{figure}{\centering}

% 禁止 twoside 模式下拉伸垂直间距
% book 文档类在 twoside 模式下默认启用 \flushbottom，强制所有页面底部对齐，
% 这会拉伸 \parskip 等带 stretch 的垂直间距，导致标题附近的空行行距不均匀。
% \raggedbottom 允许页面底部自然变化，保证全文行距一致。
% 使用 \AtEndOfClass 确保在所有 class 级代码执行完毕后覆盖。
\AtEndOfClass { \raggedbottom }

% ==========================================
% Page Layout
% ==========================================

% 画边界线（使用 eso-pic + savebox，避免 fancyput 与 listings 的跨页冲突）
% Pre-render binding line content into saved boxes, all centered in 1em width
\newlength{\bindwidth}
\setlength{\bindwidth}{1em}
\newsavebox{\tjbindpipe}
\newsavebox{\tjbindZ}
\newsavebox{\tjbindD}
\newsavebox{\tjbindX}
\AtBeginDocument{%
  \sbox{\tjbindpipe}{\makebox[\bindwidth][c]{\rule{0.4pt}{3mm}}}%
  \sbox{\tjbindZ}{\makebox[\bindwidth][c]{\zihao{5}装}}%
  \sbox{\tjbindD}{\makebox[\bindwidth][c]{\zihao{5}订}}%
  \sbox{\tjbindX}{\makebox[\bindwidth][c]{\zihao{5}线}}%
}

% Flag to suppress binding line on cover page
\newif\iftjbindingline
\tjbindinglinetrue

% Helper macro: draw binding line column at a given x position
% Coordinates empirically matched to the official Tongji thesis template.
% eso-pic \AtPageLowerLeft origin: (0,0) at bottom-left of A4 page.
\newcommand{\tj@bindingcolumn}[1]{%
  \put(\LenToUnit{#1},\LenToUnit{23.60cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{23.12cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{22.65cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{22.16cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{21.68cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{21.20cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{20.72cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{20.24cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{19.76cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{19.29cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{18.80cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{18.32cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{17.84cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{17.37cm}){\usebox{\tjbindZ}}%
  \put(\LenToUnit{#1},\LenToUnit{16.88cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{16.40cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{15.92cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{15.44cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{14.96cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{14.50cm}){\usebox{\tjbindD}}%
  \put(\LenToUnit{#1},\LenToUnit{14.00cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{13.52cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{13.04cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{12.56cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{12.07cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{11.60cm}){\usebox{\tjbindX}}%
  \put(\LenToUnit{#1},\LenToUnit{11.12cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{10.63cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{10.15cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{9.68cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{9.20cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{8.71cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{8.24cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{7.76cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{7.27cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{6.79cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{6.32cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{5.84cm}){\usebox{\tjbindpipe}}%
  \put(\LenToUnit{#1},\LenToUnit{5.35cm}){\usebox{\tjbindpipe}}%
}

% Oneside: x=1.6cm from left edge
% Twoside even page: binding on right side at 21 - 1.6 = 19.4cm
\@ifclasswith{tongjithesis}{twoside}{%
  \AddToShipoutPictureBG{%
    \iftjbindingline
      \AtPageLowerLeft{%
        \ifodd\value{page}%
          \tj@bindingcolumn{1.6cm}%
        \else
          \tj@bindingcolumn{19.4cm}%
        \fi
      }%
    \fi
  }%
}{%
  \AddToShipoutPictureBG{%
    \iftjbindingline
      \AtPageLowerLeft{%
        \tj@bindingcolumn{1.6cm}%
      }%
    \fi
  }%
}

% 双横线页眉：两条 0.5pt 细线替代默认的单粗线。
% fancyhdr 仅在 \headrulewidth>0pt 时调用 \headrule，故保留默认 0.4pt 即可触发，
% 实际线宽由 \tjdoubleheadrule 内部的 \hrule \@height 控制。
\newcommand{\tjdoubleheadrule}{%
  \hrule\@height0.5pt\@width\headwidth
  \vskip1pt
  \hrule\@height0.5pt\@width\headwidth}

% 设置摘要与目录页样式（如页眉、页脚等）
\fancypagestyle{firststyle}{
  \fancyhf{}
  \fancyhead[LO]{\hspace*{1cm}\includegraphics[height=1.14cm]{figures/tongji-header.pdf}~}
  \fancyhead[RE]{~\includegraphics[height=1.14cm]{figures/tongji-header.pdf}\hspace*{1cm}}
  \fancyhead[RO,LE]{\tjfontbody ~\tjheadertext~\\}
  \fancyfoot[C]{\tjfontbody \thepage}
  \renewcommand{\headrule}{\tjdoubleheadrule}
  \renewcommand{\footrulewidth}{0pt}
}

% 设置正文页样式（如页眉、页脚等）
\fancypagestyle{mainstyle}{
  \fancyhf{}
  \fancyhead[LO]{\hspace*{1cm}\includegraphics[height=1.14cm]{figures/tongji-header.pdf}~}
  \fancyhead[RE]{~\includegraphics[height=1.14cm]{figures/tongji-header.pdf}\hspace*{1cm}}
  \fancyhead[RO,LE]{\tjfontbody ~\tjheadertext~\\}
  \fancyfoot[RO]{{\tjfontbody 共\quad \pageref{LastPage}\quad 页\quad 第\quad \thepage \quad 页}}
  \fancyfoot[LE]{{\tjfontbody 第\quad \thepage \quad 页\quad 共\quad \pageref{LastPage}\quad 页}}
  \renewcommand{\headrule}{\tjdoubleheadrule}
  \renewcommand{\footrulewidth}{1.8pt}
}

% 自动设置前言和正文的页面样式
% ctexbook 的 \chapter 会将首页设为 plain 样式，需要重定义 plain 以匹配当前样式
\let\tj@origfrontmatter\frontmatter
\renewcommand{\frontmatter}{%
  \tj@origfrontmatter
  \pagenumbering{Roman}%
  \pagestyle{firststyle}%
  \fancypagestyle{plain}{\pagestyle{firststyle}}%
}
\let\tj@origmainmatter\mainmatter
\renewcommand{\mainmatter}{%
  \tj@origmainmatter
  \pagestyle{mainstyle}%
  \fancypagestyle{plain}{\pagestyle{mainstyle}}%
}
% 附录（2026 spec）：
%   「附录」作为未编号 H1 章节标题（四号黑体居中），写入目录。
%   附录内的小节使用 A. B. C. 编号（与正文 chapter.section 解耦），
%   浮动体 (figure/table/equation/…) 随节编号为 A.1、A.2、B.1 …
%   \appendixsection / \appendixsubsection 是 \section / \subsection 的别名，
%   保持 chapters/appendix.tex 的语义；用户也可直接用 \section / \subsection。
\let\tj@origappendix\appendix
\renewcommand{\appendix}{%
  \tj@origappendix
  \ctexset{chapter/format={\centering\heiti\tjfontheading}}%
  \chapter*{附录}%
  \addcontentsline{toc}{chapter}{附录}%
  % 附录内小节：A B C … Z AA AB …（alphalph 包提供，>26 自动延伸）
  \setcounter{section}{0}%
  \renewcommand{\thesection}{\AlphAlph{\value{section}}}%
  \renewcommand{\thesubsection}{\thesection.\arabic{subsection}}%
  % 浮动体随节编号 (A.1, A.2, B.1, …)
  \counterwithin{figure}{section}%
  \counterwithin{table}{section}%
  \counterwithin{equation}{section}%
  \counterwithin{algorithm}{section}%
  \counterwithin{listing}{section}%
  \@ifundefined{c@lstlisting}{}{\counterwithin{lstlisting}{section}}%
  \counterwithin{thm}{section}%
  \counterwithin{cor}{section}%
  \counterwithin{lem}{section}%
  \counterwithin{prop}{section}%
  \counterwithin{conj}{section}%
  \counterwithin{assume}{section}%
  \counterwithin{dfn}{section}%
  \counterwithin{exmp}{section}%
  \counterwithin{rem}{section}%
  % 理工科：「A. 节名」；文科：「（A） 节名」（括号来自正文 section/name 延续，无点号）
  \iftongjithesis@humanities
    \ctexset{section/number={\thesection},section/aftername={\hspace{0.5em}}}%
  \else
    \ctexset{section/name={,},section/number={\thesection},section/aftername={.\hspace{0.5em}}}%
  \fi
}
\newcommand{\appendixsection}{\section}
\newcommand{\appendixsubsection}{\subsection}
% Backmatter headings use 四号 (references, acknowledgements) per 2026 spec.
% The \ctexset override is intentionally permanent for the rest of the document
% (backmatter is always the final structural division).
\let\tj@origbackmatter\backmatter
\renewcommand{\backmatter}{%
  \tj@origbackmatter
  \ctexset{chapter/format={\centering\heiti\tjfontheading}}%
}

% ==========================================
% Typography and Font Settings
% ==========================================

% 表格内所有字体均为小五
\AtBeginEnvironment{table}{\tjfonttable}
\AtBeginEnvironment{tabular}{\tjfonttable}
\AtBeginEnvironment{tabular*}{\tjfonttable}
\AtBeginEnvironment{tabularx}{\tjfonttable}
\AtBeginEnvironment{longtable}{\tjfonttable}
\AtBeginEnvironment{tablenotes}{\tjfonttable}

% 续表行：五号宋体，右对齐，右空2格（规范要求）
% 用法：在 longtable 的 \endhead 中，列头重复前调用 \tjlongtablecont{列数}
\newcommand{\tjlongtablecont}[1]{%
  \multicolumn{#1}{r@{\hspace{2em}}}{\zihao{5}\songti 续表~\thetable}\\%
}

% ==========================================
% Lists and Enumerations
% ==========================================

% 设置有序列表与无序列表格式
\setlistdepth{2}

\setlist[enumerate]{nosep,labelsep=0pt}
\setlist[enumerate,1]{label=（\arabic*）,left=2em,nosep,labelsep=0pt,wide=\parindent}
\setlist[enumerate,2]{label=\TJCircled{\tj@cval{enumii}},nosep,labelsep=0pt,labelwidth=1em,listparindent=0pt}

\setlist[itemize]{nosep}
\setlist[itemize,1]{wide=\parindent}
\setlist[itemize,2]{wide=2\parindent}

% ==========================================
% Table of Contents Formatting
% ==========================================

% 在上述修改基础上，符合模板标题对齐要求
% \renewcommand{\cftdot}{.}
\renewcommand{\cftdotsep}{1}
% 目录缩进：章无缩进，节 2em，小节 4em（与标题缩进保持一致）；目录行距由 \tjtoclinespread 控制
\setlength{\cftchapindent}{0em}
\setlength{\cftsecindent}{2em}
\setlength{\cftsubsecindent}{4em}
\setlength{\cftsecnumwidth}{1.5em}
\setlength{\cftsubsecnumwidth}{2em}
\setlength{\cftsubsubsecnumwidth}{2.5em}
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\renewcommand{\contentsname}{目\hspace{0.5em}录}
\renewcommand{\cfttoctitlefont}{\hfill\heiti\tjfontheading}
\renewcommand{\cftaftertoctitle}{\hfill}
% 目录标题后留一空行（匹配官方 Word 模板）
% tocloft[titles] 下 \cftaftertoctitleskip 无效——\tableofcontents 内部走 \chapter*，
% 所以直接在 \@starttoc 前注入 \vspace。
% 标题“前”的空行由页面上边距 + ctex chapter beforeskip 提供，此处不再额外注入以免产生孤儿页。
\patchcmd{\tableofcontents}{\@starttoc{toc}}{\vspace{\baselineskip}\@starttoc{toc}}%
  {}{\ClassWarning{tongjithesis}{Failed to patch \string\tableofcontents\space for title spacing}}
\renewcommand{\cftchapfont}{\songti\tjfontbody}
\renewcommand{\cftsecfont}{\songti\tjfontbody}
\renewcommand{\cftsubsecfont}{\songti\tjfontbody}
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}}
\renewcommand{\cftsecdotsep}{\cftdotsep}
\renewcommand{\cftchappagefont}{\tjfontbody}
\renewcommand{\cftsecpagefont}{\tjfontbody}
\renewcommand{\cftsubsecpagefont}{\tjfontbody}

% 目录行距：对应 Word「1.5 倍行距」——使用 \tjtoclinespread
\let\tj@origtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
  \begin{spacing}{\tjtoclinespread}\tj@origtableofcontents\end{spacing}%
}

% ==========================================
% Chapter/Section Numbering and Formatting
% ==========================================

% 设置图表编号和章节相关联
\RequirePackage{chngcntr}
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}
\counterwithin{equation}{chapter}
\counterwithin{algorithm}{chapter}
% listing counter: created by minted (minted=true) or \newfloat (minted=false)
% lstlisting counter: created by listings package
% Both are bound to chapter, then lstlisting is aliased to listing.
\AtBeginDocument{%
  \counterwithin{listing}{chapter}%
  \@ifundefined{c@lstlisting}{}{%
    \counterwithin{lstlisting}{chapter}%
    \let\c@lstlisting\c@listing
  }%
}

% 设置正文页内章节标题格式
\ctexset{
  chapter={%
    format={\centering\heiti\tjfontchapter},
    nameformat={},
    name={},
    number={\arabic{chapter}},
    aftername={\quad},
    break={\cleardoublepage},  % oneside 下等同 \clearpage；twoside 下章首始于奇数页，由 emptypage 抑制页眉
    % Negative beforeskip: absolute value (16pt) is the vertical space above
    % the heading; the negative sign suppresses first paragraph indent (ctex convention).
    beforeskip={-16pt},
    afterskip={\tjskipaftersec},
  },
  section={%
    format={\heiti\tjfontbody},
    aftername={\hspace{0.5em}},
    beforeskip={\tjskipbeforesec},
    afterskip={\tjskipaftersec},
  },
  subsection={%
    format={\heiti\tjfontbody},
    aftername={\hspace{0.5em}},
    beforeskip={\tjskipbeforesec},
    afterskip={\tjskipaftersec},
    indent={2em},
  },
  subsubsection={%
    format={\heiti\tjfontbody},
    numbering=true,
    number={\AlphAlph{\value{subsubsection}}},
    aftername={.\hspace{0.5em}},
    beforeskip={\tjskipbeforesec},
    afterskip={\tjskipaftersec},
    indent={2em},
    aftertitle={\par},
  },
  paragraph={%
    format={\heiti\tjfontbody},
    numbering=true,
    number={\alphalph{\value{paragraph}}},
    aftername={.\hspace{0.5em}},
    beforeskip={\tjskipbeforesec},
    afterskip={\tjskipaftersec},
    indent={2em},
    aftertitle={\par},
    % ctex's chinese-book scheme makes paragraph run-in by default; with run-in the
    % afterskip is emitted as horizontal \hskip via \CTEX@heading@glue, which combines
    % with \parindent to give "parindent + afterskip" indent on the body. Force display.
    runin=false,
  },
  appendix/name={},
}

\setcounter{secnumdepth}{5}

% 文科类专业（field=humanities）：章节编号改用中文数字体系
% 理工科（science，默认）：1 / 1.1 / 1.1.1 / A. / a.
% 文科  （humanities）  ：一、/（一）/ 1. / （1） / ①②③
\iftongjithesis@humanities
  \renewcommand{\thechapter}{\chinese{chapter}}
  \renewcommand{\thesubsection}{\arabic{subsection}}
  \renewcommand{\thesubsubsection}{\arabic{subsubsection}}
  \ctexset{
    chapter/number    = {\chinese{chapter}},
    chapter/aftername = {、},
    % 括号写入 name 而非 number，使 \thesection 保持裸数字（供 tocloft/cref 使用）
    section/name      = {（,）},
    section/number    = {\chinese{section}},
    % section/aftername = {\hspace{0.5em}},
    subsection/number    = {\arabic{subsection}},
    subsection/aftername = {.\hspace{0.5em}},
    % 同理：括号写入 name，\thesubsubsection 保持裸数字
    subsubsection/name     = {（,）},
    subsubsection/number   = {\arabic{subsubsection}},
    subsubsection/aftername = {\hspace{0.5em}},
    paragraph/number    = {\TJCircled{\the\c@paragraph}},
    paragraph/aftername = {\hspace{0.5em}},
  }
  % TOC 目录列宽与分隔符
  % h1
  \renewcommand{\cftchapaftersnum}{\!、}
  \setlength{\cftchapnumwidth}{2.5em}
  % h2
  \setlength{\cftsecindent}{2.5em}
  \setlength{\cftsecnumwidth}{2.5em}
  % h3
  \renewcommand{\cftsubsecaftersnum}{.\hspace*{0.5em}}
  \setlength{\cftsubsecnumwidth}{1.5em}
  % 浮动体编号：文科采用全文连续编号（1, 2, 3…），不带章节前缀
  \counterwithout{figure}{chapter}
  \counterwithout{table}{chapter}
  \counterwithout{equation}{chapter}
  \counterwithout{algorithm}{chapter}
  % listing/lstlisting 在 \AtBeginDocument 中绑定；定理类环境在 \newtheorem 后定义，
  % 均需在 document 开始后解绑，确保顺序正确
  \AtBeginDocument{%
    \counterwithout{listing}{chapter}%
    \@ifundefined{c@lstlisting}{}{%
      \counterwithout{lstlisting}{chapter}%
    }%
    \counterwithout{thm}{chapter}%
    \counterwithout{cor}{chapter}%
    \counterwithout{lem}{chapter}%
    \counterwithout{prop}{chapter}%
    \counterwithout{conj}{chapter}%
    \counterwithout{assume}{chapter}%
    \counterwithout{dfn}{chapter}%
    \counterwithout{exmp}{chapter}%
    \counterwithout{rem}{chapter}%
  }%
\fi

% 脚注编号使用①②③… (官方模板规范)
\renewcommand{\thefootnote}{\TJCircled{\the\c@footnote}}


% ==========================================
% Float Settings
% ==========================================

% 设置浮动体的 caption 位置
\floatstyle{plaintop}       % 表格的 caption 在表格上方
\restylefloat{table}
\floatstyle{plain}
\restylefloat{listing}      % minted 默认 ruled，\newfloat 默认 plain；统一为 plain
\sloppy

% ==========================================
% Math and Theorem Environments
% ==========================================
\theoremstyle{definition}

\newtheorem{thm}{定理\hspace{0.05pt}}[chapter]
\newtheorem{cor}{推论\hspace{0.05pt}}[chapter]
\newtheorem{lem}{引理\hspace{0.05pt}}[chapter]
\newtheorem{prop}{命题\hspace{0.05pt}}[chapter]
\newtheorem{conj}{猜想\hspace{0.05pt}}[chapter]
\newtheorem{assume}{假设\hspace{0.05pt}}[chapter]
\newtheorem{dfn}{定义\hspace{0.05pt}}[chapter]
\newtheorem{exmp}{例\hspace{0.05pt}}[chapter]
\newtheorem{rem}{注\hspace{0.05pt}}[chapter]
\newtheorem*{pf}{证明}

% Math commands
\providecommand{\dd}{\mathop{}\!\mathrm{d}}
\providecommand{\ee}{\mathrm{e}}
\providecommand{\ii}{\mathrm{i}}
\providecommand{\jj}{\mathrm{j}}
\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\providecommand\pkg[1]{\href{https://ctan.org/pkg/#1}{\sffamily#1}}

% ==========================================
% Algorithm and Code Listing Settings
% ==========================================

% 伪代码
\iftongjithesis@algorithmtwoe
  \SetAlgorithmName{算法}{算法}{算法列表}
  \SetKwInput{KwIn}{输入}
  \SetKwInput{KwOut}{输出}
  \gdef\algocf@Vspace{\vskip\baselineskip\relax}
  \AtBeginEnvironment{algorithm}{\linespread{1.0}\selectfont}
  \AfterEndEnvironment{algorithm}{\vspace{\baselineskip}}
\else
  \renewcommand{\algorithmicrequire}{\textbf{输入: }}
  \renewcommand{\algorithmicensure}{\textbf{输出: }}
  \AtBeginEnvironment{algorithmic}{\linespread{1.0}\selectfont}
  \renewenvironment{algorithm}
  {
    \vskip\baselineskip
    \refstepcounter{algorithm}% New algorithm
    \hrule height.8pt depth0pt \kern2pt% \@fs@pre for \@fs@ruled
    \renewcommand{\caption}[2][\relax]{% 使用中文 caption
      {\raggedright\textbf{算法~\thealgorithm} ##2\par}%
      \ifx\relax##1\relax % #1 is \relax
        \addcontentsline{loa}{algorithm}{\protect\numberline{\thealgorithm}##2}%
      \else % #1 is not \relax
        \addcontentsline{loa}{algorithm}{\protect\numberline{\thealgorithm}##1}%
      \fi
      \kern2pt\hrule\kern2pt
    }
  }{
    \kern2pt\hrule\relax
    \vskip\baselineskip
  }% \@fs@post for \@fs@ruled
\fi

% ==========================================
% Cross-Referencing Commands
% ==========================================

% 交叉引用
% \ref/\cref: Chinese numerals sit flush against Chinese chars — no ~ spacing needed
\iftongjithesis@humanities
  \newcommand*{\chapref}[1]{第\ref{#1}章}
  \newcommand*{\secref}[1]{第\ref{#1}节}
\else
  \newcommand*{\chapref}[1]{第~\ref{#1}~章~}
  \newcommand*{\secref}[1]{第~\ref{#1}~节~}
\fi
\newcommand*{\algoref}[1]{算法~\ref{#1}~}
\renewcommand*{\eqref}[1]{式~(\ref{#1})~}
\newcommand*{\tabref}[1]{\tablename~\ref{#1}~}
\newcommand*{\figref}[1]{\figurename~\ref{#1}~}

% Cross-reference formats: 名字放进 #2…#3 让 nameinlink 全段可点（图/表/式 等整词都参与超链接）
\crefformat{listing}{#2代码~#1#3}
\crefmultiformat{listing}{#2代码~#1#3}{和#2代码~#1#3}{、#2代码~#1#3}{和#2代码~#1#3}
\crefrangeformat{listing}{#3代码~#1#4~至#5代码~#2#6}
\crefformat{lstlisting}{#2代码~#1#3}
\crefmultiformat{lstlisting}{#2代码~#1#3}{和#2代码~#1#3}{、#2代码~#1#3}{和#2代码~#1#3}
\crefrangeformat{lstlisting}{#3代码~#1#4~至#5代码~#2#6}
\newcommand*{\listingref}[1]{\lstlistingname~\ref{#1}~}

% Configure references in Chinese
% "第X章/节" pattern: number is wrapped, needs full multi/range formats
\iftongjithesis@humanities
  \crefformat{chapter}{#2第#1章#3}
  \crefmultiformat{chapter}{#2第#1章#3}{和#2第#1章#3}{、#2第#1章#3}{和#2第#1章#3}
  \crefrangeformat{chapter}{#3第#1章#4至#5第#2章#6}
  \crefformat{section}{#2第#1节#3}
  \crefmultiformat{section}{#2第#1节#3}{和#2第#1节#3}{、#2第#1节#3}{和#2第#1节#3}
  \crefrangeformat{section}{#3第#1节#4至#5第#2节#6}
\else
  \crefformat{chapter}{#2第~#1~章#3}
  \crefmultiformat{chapter}{#2第~#1~章#3}{和#2第~#1~章#3}{、#2第~#1~章#3}{和#2第~#1~章#3}
  \crefrangeformat{chapter}{#3第~#1~章#4至#5第~#2~章#6}
  \crefformat{section}{#2第~#1~节#3}
  \crefmultiformat{section}{#2第~#1~节#3}{和#2第~#1~节#3}{、#2第~#1~节#3}{和#2第~#1~节#3}
  \crefrangeformat{section}{#3第~#1~节#4至#5第~#2~节#6}
\fi
\crefformat{subsection}{#2第~#1~小节#3}
\crefmultiformat{subsection}{#2第~#1~小节#3}{和#2第~#1~小节#3}{、#2第~#1~小节#3}{和#2第~#1~小节#3}
\crefrangeformat{subsection}{#3第~#1~小节#4至#5第~#2~小节#6}
% "名称~X" pattern: ~ separates CJK name from digit; whole reference wrapped in hyperlink.
% --- Common float/equation types ---
\crefformat{equation}{#2式~(#1)#3}
\crefmultiformat{equation}{#2式~(#1)#3}{和#2式~(#1)#3}{、#2式~(#1)#3}{和#2式~(#1)#3}
\crefrangeformat{equation}{#3式~(#1)#4~至#5式~(#2)#6}
\crefformat{figure}{#2图~#1#3}
\crefmultiformat{figure}{#2图~#1#3}{和#2图~#1#3}{、#2图~#1#3}{和#2图~#1#3}
\crefrangeformat{figure}{#3图~#1#4~至#5图~#2#6}
\crefformat{table}{#2表~#1#3}
\crefmultiformat{table}{#2表~#1#3}{和#2表~#1#3}{、#2表~#1#3}{和#2表~#1#3}
\crefrangeformat{table}{#3表~#1#4~至#5表~#2#6}
\crefformat{algorithm}{#2算法~#1#3}
\crefmultiformat{algorithm}{#2算法~#1#3}{和#2算法~#1#3}{、#2算法~#1#3}{和#2算法~#1#3}
\crefrangeformat{algorithm}{#3算法~#1#4~至#5算法~#2#6}
\crefformat{algocf}{#2算法~#1#3}
\crefmultiformat{algocf}{#2算法~#1#3}{和#2算法~#1#3}{、#2算法~#1#3}{和#2算法~#1#3}
\crefrangeformat{algocf}{#3算法~#1#4~至#5算法~#2#6}
\crefformat{FancyVerbLine}{#2第~#1~行#3}
\crefmultiformat{FancyVerbLine}{#2第~#1~行#3}{和#2第~#1~行#3}{、#2第~#1~行#3}{和#2第~#1~行#3}
\crefrangeformat{FancyVerbLine}{#3第~#1~行#4至#5第~#2~行#6}
% --- Theorem types (single + multi for consistency) ---
\crefformat{thm}{#2定理~#1#3}
\crefmultiformat{thm}{#2定理~#1#3}{和#2定理~#1#3}{、#2定理~#1#3}{和#2定理~#1#3}
\crefformat{cor}{#2推论~#1#3}
\crefmultiformat{cor}{#2推论~#1#3}{和#2推论~#1#3}{、#2推论~#1#3}{和#2推论~#1#3}
\crefformat{lem}{#2引理~#1#3}
\crefmultiformat{lem}{#2引理~#1#3}{和#2引理~#1#3}{、#2引理~#1#3}{和#2引理~#1#3}
\crefformat{prop}{#2命题~#1#3}
\crefmultiformat{prop}{#2命题~#1#3}{和#2命题~#1#3}{、#2命题~#1#3}{和#2命题~#1#3}
\crefformat{conj}{#2猜想~#1#3}
\crefformat{assume}{#2假设~#1#3}
\crefformat{dfn}{#2定义~#1#3}
\crefformat{exmp}{#2例~#1#3}
\crefformat{rem}{#2注~#1#3}
\crefformat{pf}{#2证明~#1#3}
\crefformat{proof}{#2证明~#1#3}

% Configure connecting words
\newcommand{\crefpairconjunction}{ 和~}
\newcommand{\crefmiddleconjunction}{、}
\newcommand{\creflastconjunction}{ 和~}
\newcommand{\crefpairgroupconjunction}{ 和}
\newcommand{\crefmiddlegroupconjunction}{、}
\newcommand{\creflastgroupconjunction}{ 和}
\newcommand{\crefrangeconjunction}{ 至~}

% ==========================================
% Logo Commands
% ==========================================

\providecommand{\XeTeX}{\hologo{XeTeX}}
\providecommand{\BibTeX}{\hologo{BibTeX}}
\providecommand{\BibLaTeX}{\textsc{Bib}\LaTeX}
\providecommand{\LuaTeX}{\hologo{LuaTeX}}
\DeclareRobustCommand{\TongjiThesis}{%
  \texorpdfstring{%
    T{\scshape ongji}\kern.08em T{\scshape hesis}%
  }{TongjiThesis}%
}

% ==========================================
% Cover and User Information Commands
% ==========================================

% 设置封面信息盒子（information 环境）
\newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}}
\let\oldtabular\tabular
\let\endoldtabular\endtabular
\newenvironment{information}[1][h!]{
  \renewcommand{\arraystretch}{1.5}
  \setlength{\tabcolsep}{8pt}
  \tjfontcover\oldtabular[#1]
}{\renewcommand{\arraystretch}{1.2}\endoldtabular
}

\newlength{\covertextwidth}
\newlength{\covermaxwidth}
\newlength{\coverparwidth}

\newcommand{\ulinecentered}[1]{
  \bgroup
  \let\\\relax
  \setlength{\covertextwidth}{\widthof{#1}}
  \egroup
  \setlength{\covermaxwidth}{20em}
  \ifdim\covertextwidth > \covermaxwidth
    \ifdim\covertextwidth > 1.95\covermaxwidth
      \setlength{\coverparwidth}{0.53\covertextwidth}
      \pgfmathsetmacro{\coverscale}{\covermaxwidth / \coverparwidth}
      \uline{%
        \scalebox{\coverscale}[1]{%
          \parbox[b]{\coverparwidth}{%
            \centering
            \renewcommand{\baselinestretch}{\tjcoverlinestretch}\selectfont
            #1%
          }%
        }%
      }
    \else
      \uline{%
        \parbox[b]{\covermaxwidth}{%
          \centering
          \renewcommand{\baselinestretch}{\tjcoverlinestretch}\selectfont
          #1%
        }%
      }
    \fi
  \else
    \uline{%
      \makebox[\covermaxwidth][c]{%
        \parbox[b]{\covermaxwidth}{%
          \centering
          \renewcommand{\baselinestretch}{\tjcoverlinestretch}\selectfont
          #1%
        }%
      }%
    }
  \fi
}

\def\tj@titlecnbreak@opt[#1]{\unskip\ignorespaces}
\def\tj@titlecnbreak@star*{%
  \@ifnextchar[{\tj@titlecnbreak@opt}{\unskip\ignorespaces}%
}
\newcommand{\tjtitlecninlinebreak}{%
  \unskip
  \@ifnextchar*{\tj@titlecnbreak@star}{%
    \@ifnextchar[{\tj@titlecnbreak@opt}{\ignorespaces}%
  }%
}
\newcommand{\tjtitlecninline}[1]{%
  \begingroup
    \let\\\tjtitlecninlinebreak
    #1%
  \endgroup
}
\def\tj@titleenbreak@opt[#1]{\unskip\space\ignorespaces}
\def\tj@titleenbreak@star*{%
  \@ifnextchar[{\tj@titleenbreak@opt}{\unskip\space\ignorespaces}%
}
\newcommand{\tjtitleeninlinebreak}{%
  \unskip
  \@ifnextchar*{\tj@titleenbreak@star}{%
    \@ifnextchar[{\tj@titleenbreak@opt}{\space\ignorespaces}%
  }%
}
\newcommand{\tjtitleeninline}[1]{%
  \begingroup
    \let\\\tjtitleeninlinebreak
    #1%
  \endgroup
}

\newcommand{\tj@abstractblock}[2]{%
  \par\nointerlineskip
  \begingroup
    \setbox\@tempboxa\vbox{%
      \hsize=\linewidth
      \parindent=0pt
      \parbox[t]{\linewidth}{%
        \centering
        #1%
        \strut #2\strut\par
      }%
    }%
    \box\@tempboxa
  \endgroup
  \par\nointerlineskip
}

% 论文基本信息配置
\newcommand{\school}[1]{\def\tongjischool{#1}}
\newcommand{\major}[1]{\def\tongjimajor{#1}}
\newcommand{\student}[2]{\def\tongjiauthornumber{#1}\def\tongjiauthor{#2}}
\newcommand{\thesistitle}[2]{\def\tongjithesistitle{#1}\def\tongjithesissubtitle{#2}}
\newcommand{\thesistitleeng}[2]{\def\tongjithesistitleeng{#1}\def\tongjithesissubtitleeng{#2}}
\newcommand{\abstracttitle}[2]{\def\tongjiabstracttitle{#1}\def\tongjiabstractsubtitle{#2}}
\newcommand{\abstracttitleeng}[2]{\def\tongjiabstracttitleeng{#1}\def\tongjiabstractsubtitleeng{#2}}
\newcommand{\thesisadvisor}[1]{\def\tongjithesisadvisor{#1}}
\newcommand{\thesisdate}[3]{\def\tongjithesisyear{#1}\def\tongjithesismonth{#2}\def\tongjithesisday{#3}}

% 设置封面
\newcommand{\MakeCover}{
  \begin{titlepage}
    \begin{center}
      \global\tjbindinglinefalse
      \pagestyle{empty}% 防止多页封面在第二页出现页码（titlepage 只 \thispagestyle empty）
      \vfill

      \includegraphics[height=2.5cm]{figures/tongji.pdf}\\

      \tjfonttitle\MakeUppercase{\textbf{\tongjiuniversityeng}}\\
      % \vskip 20pt

      % 封面大标题：初号黑体（官方模板规范，理工/文科不同）
      \zihao{-0}\heiti{\tjcovertext}\\
      \vspace{60pt}

      \begin{information}{M{5em}M{22em}}
        \tjfonttitle\heiti{课题名称} & \ulinecentered{\tjfonttitle\heiti{\tongjithesistitle}} \\
        \tjfonttitle\heiti{副\enskip{}标\enskip{}题} & \ulinecentered{\tjfonttitle\heiti{\tongjithesissubtitle}} \\
        \tjfonttitle\heiti{学\quad{}\quad{}院} & \ulinecentered{\tjfonttitle\heiti{\tongjischool}} \\
        \tjfonttitle\heiti{专\quad{}\quad{}业} & \ulinecentered{\tjfonttitle\heiti{\tongjimajor}} \\
        \tjfonttitle\heiti{学生姓名} & \ulinecentered{\tjfonttitle\heiti{\tongjiauthor}} \\
        \tjfonttitle\heiti{学\quad{}\quad{}号} & \ulinecentered{\tjfonttitle\heiti{\tongjiauthornumber}} \\
        \tjfonttitle\heiti{指导教师} & \ulinecentered{\tjfonttitle\heiti{\tongjithesisadvisor}} \\
        \tjfonttitle\heiti{日\quad{}\quad{}期} & \ulinecentered{\tjfonttitle\heiti{\tongjithesisyear{}年\tongjithesismonth{}月\tongjithesisday{}日}} \\
      \end{information}

      \vfill
    \end{center}
  \end{titlepage}
  \global\tjbindinglinetrue
}

% 设置信息说明页
\newcommand{\infotype}[1]{\def\tongjiinfotype{#1}}
\newcommand{\infoabstract}[1]{\def\tongjiinfoabstract{#1}}
\newcommand{\infodrawings}[1]{\def\tongjiinfodrawings{#1}}
\newcommand{\infowordcount}[1]{\def\tongjiinfowordcount{#1}}
\newcommand{\infothesiswords}[1]{\def\tongjiinfothesiswords{#1}}
\newcommand{\infomaterials}[1]{\def\tongjiinfomaterials{#1}}
\newsavebox{\tj@titlebox}
\newlength{\tj@titledp}
\newcommand{\infoline}[2]{%
  \noindent #1：#2\par\vspace{0.5em}
}

% Internal helpers for checkbox rendering (used only inside \MakeInfoPage)
\newcommand{\tjchecked}{\rlap{$\checkmark$}$\square$}
\newcommand{\tjunchecked}{$\square$}
\newcommand{\tjcheckbox}[1]{%
  \ifthenelse{\equal{\tongjiinfotype}{#1}\OR
              \(\equal{#1}{design}\AND\equal{\tongjiinfotype}{engineering}\)}%
    {\tjchecked}{\tjunchecked}%
}
\newcommand{\ulinebox}[2][c]{%
  \uline{\makebox[#2][#1]{\phantom{X}}}%
}

\newcommand{\MakeInfoPage}{%
  \begin{titlepage}
    \global\tjbindinglinefalse
    \pagestyle{empty}% 防止信息页溢出到第二页时出现页码（titlepage 只 \thispagestyle empty）

    \begin{center}
      \tjfontinfotitle\heiti 同济大学本科\tjheadertext 信息说明页
    \end{center}

    \vspace{1em}

    {\tjfontheading\songti\linespread{\tjinfofieldspread}\selectfont  % 四号宋体，行距 28 磅
    \setlength{\parindent}{0pt}

    \savebox{\tj@titlebox}{\parbox[t]{\dimexpr\linewidth-5em\relax}{%
      \tjtitlecninline{\tongjithesistitle}%
      \ifx\tongjithesissubtitle\empty\else——\tjtitlecninline{\tongjithesissubtitle}\fi
    }}%
    \infoline{课题名称}{\usebox{\tj@titlebox}}%
    \settodepth{\tj@titledp}{\usebox{\tj@titlebox}}%
    \addtolength{\tj@titledp}{-\dp\strutbox}%
    \ifdim\tj@titledp>0pt\vspace{\tjinfotitlevspace}\fi

    \infoline{成果类型}{\tjcheckbox{design}\,毕业设计\quad \tjcheckbox{thesis}\,毕业论文}%

    \infoline{学科专业}{\tongjimajor}%

    \infoline{内容简述（请用300字以内简要概述）}{%
      \par\vspace{0.2em}
      % 摘要正文用小四号（规范正文字号），外层字段标签为四号
      {\tjfontbody\linespread{\tjinfoabstractspread}\selectfont% 小四 18 磅
       \setlength{\parindent}{2em}\tongjiinfoabstract\par}
    }

    % 按成果类型只显示对应行（官方模板为二选一）
    \ifthenelse{\equal{\tongjiinfotype}{design}\OR\equal{\tongjiinfotype}{engineering}}{%
      \infoline{毕业设计}{主要图纸~\ifx\tongjiinfodrawings\empty \ulinebox{4em} \else \underline{\makebox[4em][c]{\tongjiinfodrawings}} \fi~张，正文总字数~\ifx\tongjiinfowordcount\empty \ulinebox{6em} \else \underline{\makebox[6em][c]{\tongjiinfowordcount}} \fi~字}%
    }{%
      \infoline{毕业论文}{正文总字数~\ifx\tongjiinfothesiswords\empty \ulinebox{6em} \else \underline{\makebox[6em][c]{\tongjiinfothesiswords}} \fi~字}%
    }%

    \infoline{随附资料}{%
      \ifx\tongjiinfomaterials\empty
        \par\vspace{0.5em}
      \else
        \begin{enumerate}[label=\arabic*.,leftmargin=2em,labelsep=0.5em,itemsep=0.2em,parsep=0pt,topsep=0pt] \tongjiinfomaterials \end{enumerate}
      \fi
    }%
    （请列出所有提交的支撑材料名称，如：毕业设计--全套图纸、毕业作品、计算书、程序代码、附录等）
    }
  \end{titlepage}
  \setstretch{\tjlinespread}
  \global\tjbindinglinetrue
}

% 设置中文摘要页（毕业设计时标题改为"设计总说明"）
\newcommand{\MakeAbstract}[2]{
  \vspace*{0.1em}
  \tj@abstractblock{\bfseries\heiti\tjfonttitle}{%
    \ifdefempty{\tongjiabstracttitle}{%
      \tjtitlecninline{\tongjithesistitle}%
    }{%
      \tongjiabstracttitle
    }%
  }
  \ifdefempty{\tongjiabstractsubtitle}{%
    \ifx\tongjithesissubtitle\empty\else
      \vspace{0.6em}%
      \tj@abstractblock{\bfseries\heiti\zihao{3}}{\tjtitlecninline{\tongjithesissubtitle}}% 副标题：三号（官方模板规范）
    \fi
  }{%
    \vspace{0.6em}%
    \tj@abstractblock{\bfseries\heiti\zihao{3}}{\tongjiabstractsubtitle}%
  }
  \vspace{0.8em}
  \tj@abstractblock{\heiti\tjfontheading}{%
    \ifthenelse{\equal{\tongjiinfotype}{engineering}}{设计总说明}{摘\hspace{0.5em}要}
  }
  \vspace{1.6em}

  \begin{spacing}{\tjlinespread}
    \setlength{\parindent}{2em}
    \songti\tjfontbody #1
    \par
  \end{spacing}

  \songti\tjfontbody
  \vspace{\baselineskip}
  {\noindent\textbf{关键词：}#2}\par
}

% 设置英文摘要页
\newcommand{\MakeAbstractEng}[2]{
  \clearpage
  \vspace*{0.1em}
  \tj@abstractblock{\tjfonttitle\bfseries}{%
    \ifdefempty{\tongjiabstracttitleeng}{%
      \tjtitleeninline{\tongjithesistitleeng}%
    }{%
      \tongjiabstracttitleeng
    }%
  }
  \ifdefempty{\tongjiabstractsubtitleeng}{%
    \ifx\tongjithesissubtitleeng\empty\else
      \vspace{0.6em}%
      \tj@abstractblock{\zihao{3}\bfseries}{\tjtitleeninline{\tongjithesissubtitleeng}}% 副标题：三号（官方模板规范）
    \fi
  }{%
    \vspace{0.6em}%
    \tj@abstractblock{\zihao{3}\bfseries}{\tongjiabstractsubtitleeng}%
  }
  \vspace{0.8em}
  \tj@abstractblock{\tjfontheading\bfseries}{ABSTRACT}
  \vspace{1.6em}

  \begin{spacing}{\tjlinespread}
    \setlength{\parindent}{2em}
    \tjfontbody #1
    \par
  \end{spacing}

  \tjfontbody
  \vspace{\baselineskip}
  {\noindent\textbf{Key words: }#2}\par
}

% ==========================================
% Task Book / Proposal / Mid-term Report Commands
% ==========================================
% 任务书（doctype=taskbook）、开题报告（doctype=proposal）、中期报告（doctype=midterm）
% 与正文论文共用 chapters/metadata.tex 中的学院/专业/学生/课题/指导教师信息；
% \MakeDocument 依据 doctype 分派到 \MakeTaskBook / \MakeProposal / \MakeMidterm，
% 三者仅渲染封面表格与签字区（如 \MakeCover 之于论文封面），正文各段落内容
% 由 chapters/{taskbook,proposal,midterm}_body.tex 提供，写作者可直接编辑替换。

\definecolor{tjnotegray}{HTML}{ADADAD}
\definecolor{tjhintgray}{HTML}{747474}

% 任务书专用信息：起讫时间（其余字段复用 \school/\major/\student/\thesistitle/…）
% 周数由起讫日期自动换算（向上取整），无需手动填写。
\RequirePackage{pgfcalendar}
\newcount\tj@julianstart
\newcount\tj@julianend
\newcount\tj@weeks
% 数值零填充（如 9 -> 09），供拼接 ISO 日期字符串（yyyy-mm-dd）使用；
% \numexpr 先规整输入（容忍调用方已自行补零，如 09 不会被重复补零）
\newcommand{\tj@zeropad}[1]{%
  \ifnum\numexpr#1\relax<10 0\the\numexpr#1\relax\else\the\numexpr#1\relax\fi
}
\newcommand{\taskbookperiod}[6]{%
  \def\tongjitaskbookstartyear{#1}\def\tongjitaskbookstartmonth{#2}\def\tongjitaskbookstartday{#3}%
  \def\tongjitaskbookendyear{#4}\def\tongjitaskbookendmonth{#5}\def\tongjitaskbookendday{#6}%
  \pgfcalendardatetojulian{#1-\tj@zeropad{#2}-\tj@zeropad{#3}}{\tj@julianstart}%
  \pgfcalendardatetojulian{#4-\tj@zeropad{#5}-\tj@zeropad{#6}}{\tj@julianend}%
  \ifnum\tj@julianend<\tj@julianstart
    \ClassError{tongjithesis}{\string\taskbookperiod: end date is before start date}{Swap the start/end date arguments of \string\taskbookperiod.}%
  \fi
  % \numexpr's "/" rounds to nearest (ties away from zero), not truncates,
  % so a plain (delta+7-1)/7 ceiling-division trick silently over-counts by
  % one week for many date ranges. \divide truncates (unlike \numexpr's "/"),
  % so compute the sum with \numexpr and only then \divide.
  \tj@weeks=\numexpr\tj@julianend-\tj@julianstart+7\relax
  \divide\tj@weeks by 7
  \edef\tongjitaskbookweeks{\the\tj@weeks}%
}

% 表格环境：复用封面 information 环境的排版参数（字号、行距），供课题信息表/
% 签字区使用。官方模板不绘制表格边框，仅靠下划线呈现填空位置（与 \MakeCover
% 的 information 环境一致），故不设置任何竖线或 \hline。
% 可选参数为 tabcolsep（默认 8pt，与 information 一致）；必须在 \oldtabular
% 开始解析列格式前设定——tabcolsep 一旦用于构建列间距，在表格主体内再
% \setlength 为时已晚（且直接放在 tabular 主体内并非合法位置）。
\newenvironment{tjformtable}[2][8pt]{%
  \renewcommand{\arraystretch}{1.8}
  \setlength{\tabcolsep}{#1}
  \noindent\tjfontcover\oldtabular{#2}
}{%
  \endoldtabular
}

% 课题信息表：任务书/开题报告/中期报告共用（官方模板同源）
% 合并单元格宽度（22em）与 \MakeCover 的 M{5em}M{22em} 保持一致，
% 以匹配 \ulinecentered 内部固定的 20em 折行/缩放阈值（\covermaxwidth）。
% 姓名/学号列较窄，改用不受该阈值影响的纯下划线 \uline。
% 姓名/学号行实际展开为 4 个独立列（其余行经 multicolumn 合并为 2 列），
% 4 列比 2 列多出一倍的 \tabcolsep 开销，故此表专用更紧凑的 tabcolsep
% 以确保整表宽度不超出 \linewidth（\MakeCover 的 8pt 是为 2 列表设计的）。
\newcommand{\tj@formsubjecttable}{%
  \begin{tjformtable}[1.5pt]{M{4.5em}M{9em}M{4em}M{9em}}
    课题名称 & \multicolumn{3}{M{22em}}{\ulinecentered{\tongjithesistitle}} \\
    副\enskip{}标\enskip{}题 & \multicolumn{3}{M{22em}}{\ulinecentered{\tongjithesissubtitle}} \\
    学\quad{}\quad{}院 & \multicolumn{3}{M{22em}}{\ulinecentered{\tongjischool}} \\
    专\quad{}\quad{}业 & \multicolumn{3}{M{22em}}{\ulinecentered{\tongjimajor}} \\
    学生姓名 & \uline{\tongjiauthor} & 学\enskip 号 & \uline{\tongjiauthornumber} \\
  \end{tjformtable}%
}

% 说明性文字（此项成稿删除）与提示性文字（内容提示，不删除）——两种灰色，语义不同
\newcommand{\tjformnote}[1]{{\tjfontbody\color{tjnotegray}\selectfont #1\par}}
\newcommand{\tjformhint}[1]{{\tjfontbody\color{tjhintgray}\selectfont #1\par}}

% 顶格小节标题（正文分节，不计入目录、不参与章节编号）
\newcommand{\tjformsection}[1]{%
  \par\vspace{\baselineskip}
  \noindent{\tjfontbody\selectfont #1}\par
  \vspace{0.5\baselineskip}
}

% 日期空白（年/月/日下划线填空）
\newcommand{\tjdateblank}{\ulinebox{3em}~年~\ulinebox{2em}~月~\ulinebox{2em}~日}

% 审核意见方框（指导教师/专业负责人意见 + 签名 + 日期）
% \fbox 的参数须一次性、完整地给出，不能跨 \newenvironment 的 begin/end 两段拆分
% （\fbox 按普通花括号参数扫描，而非 \begingroup/\endgroup 式分组）；
% 因此先用 lrbox 把 minipage 内容完整装入一个盒子寄存器，
% 再在 end 段一次性用 \fbox 包裹已装入完毕的盒子。
\newsavebox{\tj@reviewbox}
\newenvironment{tjreviewbox}{%
  \par\vspace{0.5\baselineskip}\noindent
  \begin{lrbox}{\tj@reviewbox}
  \begin{minipage}[t]{\dimexpr\linewidth-2\fboxsep-2\fboxrule-2pt\relax}\tjfontbody
}{%
  \end{minipage}
  \end{lrbox}
  \fbox{\usebox{\tj@reviewbox}}\par\vspace{0.5\baselineskip}
}

% 任务书/开题报告/中期报告全程不显示装订线：三者均为单独打印/提交的行政表格，
% 不与正文一同装订，且官方 Word 模板本身无该装饰。这与 \MakeCover/\MakeInfoPage
% 形成对比——后两者的装订线仅在封面/信息页本身关闭，此后随论文正文恢复；此处
% 恢复为 true 没有意义（\clearpage 而非 titlepage 的 \newpage 触发首页 shipout，
% 若在 \clearpage 前恢复为 true 会导致装订线错误地出现在封面页本身）。
% 三个命令均不将 \tjbindingline 恢复为 true——同一次编译内不会再调用 \MakeCover
% 等其他封面命令，故无需担心状态泄漏到其他文档。

% 任务书封面：课题信息表 + 起讫时间 + 指导教师/教学院长签字区
% 官方模板仅标题居中，信息表/签字区一律左对齐（不居中）——与 \MakeCover 的
% 论文封面（整体居中）是两种不同版式，此处以官方模板为准。
\newcommand{\MakeTaskBook}{%
  \global\tjbindinglinefalse
  \begin{center}
    \vspace*{2\baselineskip}
    \includegraphics[height=2cm]{figures/tongji.pdf}\\
    \vspace{1em}
    {\tjfonttitle\selectfont \tjheadertext 任务书}\par
    \vspace{2\baselineskip}
  \end{center}

  \tj@formsubjecttable

  \vspace{1em}
  \tjheadertext 起讫时间：自~\tongjitaskbookstartyear~年~\tongjitaskbookstartmonth~月~\tongjitaskbookstartday~日至~\tongjitaskbookendyear~年~\tongjitaskbookendmonth~月~\tongjitaskbookendday~日共~\tongjitaskbookweeks~周
  \vspace{1.5em}

  \begin{tjformtable}[4pt]{M{9em}M{5.5em}M{11.5em}}
    指导教师签名 & \ulinebox{5em} & \tjdateblank \\
    教学院长签名 & \ulinebox{5em} & \tjdateblank \\
  \end{tjformtable}
  \clearpage
}

% 开题报告封面：课题信息表（无起讫时间）+ 填表日期
\newcommand{\MakeProposal}{%
  \global\tjbindinglinefalse
  \begin{center}
    \vspace*{2\baselineskip}
    \includegraphics[height=2cm]{figures/tongji.pdf}\\
    \vspace{1em}
    {\tjfonttitle\selectfont \tjheadertext 开题报告}\par
    \vspace{2\baselineskip}
  \end{center}

  \tj@formsubjecttable

  \vspace{1.5em}
  填表日期：\tjdateblank
  \clearpage
}

% 中期报告封面：与开题报告共用同一表格结构（官方模板同源）
\newcommand{\MakeMidterm}{%
  \global\tjbindinglinefalse
  \begin{center}
    \vspace*{2\baselineskip}
    \includegraphics[height=2cm]{figures/tongji.pdf}\\
    \vspace{1em}
    {\tjfonttitle\selectfont \tjheadertext 中期报告}\par
    \vspace{2\baselineskip}
  \end{center}

  \tj@formsubjecttable

  \vspace{1.5em}
  填表日期：\tjdateblank
  \clearpage
}

% \MakeDocument：按 doctype 分派封面渲染；正文由 chapters/{taskbook,proposal,midterm}_body.tex 提供。
% doctype=thesis（默认）不使用本命令——论文封面/信息页仍由 \MakeCover/\MakeInfoPage 显式调用（main.tex 不变）。
\newcommand{\MakeDocument}{%
  \iftongjithesis@doctype@taskbook
    \MakeTaskBook
  \else\iftongjithesis@doctype@proposal
    \MakeProposal
  \else\iftongjithesis@doctype@midterm
    \MakeMidterm
  \else
    \ClassError{tongjithesis}{\string\MakeDocument\space requires doctype=taskbook|proposal|midterm}{Set doctype in \string\documentclass[doctype=taskbook]{tongjithesis}, or call \string\MakeTaskBook/\string\MakeProposal/\string\MakeMidterm directly.}%
  \fi\fi\fi
}

% ==========================================
% Configuration Input
% ==========================================

% 设置全角句号替换为全角点号
% fullwidthstop=dot：将句号（。U+3002）替换为全角句点（．U+FF0E）
% ctex/xeCJK 的 PunctStyle 仅控制标点间距，不做字符映射，故需 \catcode 方案
% 兼容旧版 boolean 写法（v1.3.1 及之前），true 同 dot
\newif\iftongjithesis@fullwidth@active
\tongjithesis@fullwidth@activefalse
\expandafter\ifstrequal\expandafter{\tongjithesis@fullwidthstop}{dot}
  {\tongjithesis@fullwidth@activetrue}{}
\expandafter\ifstrequal\expandafter{\tongjithesis@fullwidthstop}{true}
  {\tongjithesis@fullwidth@activetrue}{}
\iftongjithesis@fullwidth@active
  \catcode`\。=\active
  \newcommand{。}{\ifmmode\text{．}\else ．\fi}%
\fi

% 加载用户配置文件
% cfg is found via TEXINPUTS: locally via .latexmkrc (./style//), or alongside cls on CTAN/texmf.
\AtEndOfPackage{
  \InputIfFileExists{tongjithesis.cfg}{}{}
}
