%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tongjithesis -- Tongji University Thesis Template
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tongjithesis}[v1.5.0 Tongji University Thesis Class] %x-release-please-version
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
% 经管类属社科：编号要求依理工，撰写依理工模板。26 届为过渡期，可选 science 或
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
% \iftongjithesis@form：doctype 为 3 份行政表格之一（即非 thesis）。三者共享页边距、
% 封面版式等行为，凡“是否为行政表格”的判断都用本开关，避免同一条件写成三重嵌套。
\newif\iftongjithesis@form
\expandafter\ifstrequal\expandafter{\tongjithesis@doctype}{taskbook}{%
  \tongjithesis@doctype@taskbooktrue\tongjithesis@formtrue
}{%
  \expandafter\ifstrequal\expandafter{\tongjithesis@doctype}{proposal}{%
    \tongjithesis@doctype@proposaltrue\tongjithesis@formtrue
  }{%
    \expandafter\ifstrequal\expandafter{\tongjithesis@doctype}{midterm}{%
      \tongjithesis@doctype@midtermtrue\tongjithesis@formtrue
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
% Formatting Constants (官方规范)
% ==========================================
% 依据：同济大学本科生毕业设计（论文）撰写规范（附件2，2026 年 10 月修订）；
% 规范未写明的数值沿用 2026 届官方 Word 模板。
% Font sizes
\newcommand{\tjfonttitle}{\zihao{-2}}        % 课题名称：小二号
\newcommand{\tjfontchapter}{\zihao{-3}}      % 章标题：小三号
\newcommand{\tjfontheading}{\zihao{4}}       % 摘要 / 目录 / 参考文献 / 谢辞标题：四号
\newcommand{\tjfontbody}{\zihao{-4}}         % 正文 / 二三级标题 / 关键词 / 摘要正文：小四号
\newcommand{\tjfontcaption}{\zihao{5}}       % 表题 / 图题：五号
\newcommand{\tjfontcover}{\zihao{-3}}        % 封面表格字段值：小三号（与 \tjfontchapter 同字号，语义分离）
\newcommand{\tjfonttable}{\fontsize{10.5bp}{18bp}\linespread{1}\selectfont} % 表内文字：五号 10.5 磅（撰写规范“表中文字原则上采用宋体五号”），行距 18 磅（沿用 Word 模板）；Word 的“磅”即 bp；\linespread{1} 隔离全文 1.625 倍行距
\newcommand{\tjfontinfotitle}{\zihao{3}}     % 信息说明页标题：三号（仅此页专用）
\newcommand{\tjfontformtitle}{\zihao{-0}}    % 任务书 / 开题报告 / 中期报告封面标题：小初号（36pt）
% Spacing
% Word 的 “0.5 行” 按单倍行距字体行高计算（≈ 字号 × 1.2 × 0.5 = 0.6em），
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
% 任务书/开题报告/中期报告封面大标题专用：与 \tjheadertext 同义，但括号取半角，
% 使小初号（36pt）标题（如“毕业设计(论文)开题报告”）能在一行内排下。
\iftongjithesis@humanities
  \newcommand{\tjformheadertext}{毕业论文(设计)}
\else
  \newcommand{\tjformheadertext}{毕业设计(论文)}
\fi

% ==========================================
% Required Packages
% ==========================================
% Page layout
% headheight 43pt ≈ 1.14cm logo (≈32pt) + 小四号正文行 (≈11pt)；防止 fancyhdr headheight warning
\setlength{\headheight}{43pt}
% 页边距按同济本科毕业设计（论文）/毕业论文（设计）撰写规范设定；
% 任务书/开题报告/中期报告为 A4，上 2.3cm/下 1.0cm/左右各 3.17cm（左右对称），
% 与论文正文的装订页边距（左 3.3cm/右 1.8cm）不同。
\iftongjithesis@form
  \RequirePackage[a4paper,top=2.3cm,bottom=1.0cm,left=3.17cm,right=3.17cm]{geometry}
\else
  \RequirePackage[a4paper,top=4.0cm,bottom=2.7cm,left=3.3cm,right=1.8cm]{geometry}
\fi
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
  % Times New Roman 是微软字体，只在装了它的系统上存在；Linux 与 Overleaf 上没有，
  % 直接 \setmainfont 会以 “Package fontspec Error: The font ... cannot be found”
  % 中止编译——times=true 因此在多数环境下完全不可用。
  % 回退到 TeX Gyre Termes：TeX Live 自带、与 Times 度量兼容，且带真正的小型大写
  % 字形（Times New Roman 没有，\TongjiThesis / \BibLaTeX 两处 \scshape 在它下面
  % 会静默退回常规体）。
  % 回退按文件名加载，不按字体名：TeX Live 自带的字体没有注册到 fontconfig，
  % Linux 上按名字找不到（“The font "TeX Gyre Termes" cannot be found”），
  % 按文件名走 kpathsea 才是各平台都可靠的方式。
  \IfFontExistsTF{Times New Roman}
    {\setmainfont{Times New Roman}}
    {\setmainfont{texgyretermes}[
       Extension     = .otf,
       UprightFont   = *-regular,
       BoldFont      = *-bold,
       ItalicFont    = *-italic,
       BoldItalicFont= *-bolditalic,
     ]}%
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

  % Define a minted-compatible environment that forwards to listings.
  % Must be \lstnewenvironment, not a plain \newenvironment wrapper around
  % lstlisting: lstlisting reads its body verbatim, scanning the source for the
  % literal string \end{lstlisting}. That string never appears when the writer
  % closes with \end{minted}, so a plain wrapper swallows the rest of the file
  % and aborts with "no legal \end found".
  \lstnewenvironment{minted}[2][]{\lstset{language=#2,#1}}{}

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
% 数字列表与数字范围的连接词：siunitx 默认输出英文“and”“to”。撰写规范（十三）要求标点按
% GB/T 15834—2011《标点符号用法》使用：并列词语用顿号，数值范围用浪纹线“～”（规范正文亦写作“3～5个”）。
\sisetup{
  list-separator       = {、},
  list-final-separator = {和},
  list-pair-separator  = {和},
  range-phrase         = {～},
}
\RequirePackage{pgf}
\RequirePackage{tikz}

% ==========================================
% Bibliography Configuration
% ==========================================
% 参考文献样式遵循 GB/T 7714-2025。所需宏包版本（均随 TeX Live 2026+ 分发）：
%   - biblatex 路径：biblatex-gb7714-2015 >= v1.1w（提供 gb7714-2025 样式）
%   - bibtex   路径：gbt7714 >= v2.2.0（提供 gbt7714-2025-numeric.bst）
% 版本过旧会报“style/bst not found”错误；升级步骤见 README“快速开始”提示。
\iftongjithesis@biblatex
  \RequirePackage[
    backend=biber,
    style=gb7714-2025,
    gbpunctwidth=half,    % 撰写规范：参考文献与正文引用方括号内的标点统一采用半角
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
  % 以下四处改写 gb7714-2025 的默认输出，使其与 gbt7714 及 GB/T 7714—2025 的示例一致。
  % （1）DOI 与 CSTR：§7.8 示例写作“DOI:10.3760/…”，冒号后不留空格；
  %     样式原定义在冒号后加了 \addthinspace。
  \DeclareFieldFormat{doi}{%
    DOI\addcolon
    \ifhyperref
      {\href{https://doi.org/#1}{\nolinkurl{#1}}}
      {\nolinkurl{#1}}}
  \DeclareFieldFormat{cstr}{%
    CSTR\addcolon
    \ifhyperref
      {\href{https://cstr.cn/#1}{\nolinkurl{#1}}}
      {\nolinkurl{#1}}}
  % （2）更新或修改日期与引用日期：§7.6 示例写作“（2012-05-03）[2013-11-12]”，两者之间不留空格；
  %     样式原定义在引用日期前加了 \addthinspace。
  \renewbibmacro*{urldate}{%
    \printtext{\gbleftbracket}\printurldate\printtext{\gbrightbracket}}
  % （3）英文题名：§5.6 要求大小写“符合信息资源本身文种的习惯用法”，标准示例的题名与书名均为
  %     句首大写（sentence case），期刊名保留原样。与 gbt7714 的默认设置相同：title 与 booktitle
  %     改为句首大写，journal 不变；只处理英文文献（userd 是样式按题名判定的语种）。
  %     .bib 中需保持原样的专有名词与缩写须用花括号保护，如 {IEEE}、{LaTeX}，两种后端都会照录。
  %     副题名（subtitle、booksubtitle）整体小写，与 gbt7714 的 capitalizesubtitle=false 及示例
  %     “ARA：a flexible pipeline…”一致；\tj@mklowercase 沿用 biblatex 的花括号保护规则。
  \newcommand*{\tj@mksentencecase}[1]{%
    \iffieldequalstr{userd}{english}
      {\ifboolexpr{test {\ifcurrentfield{subtitle}} or test {\ifcurrentfield{booksubtitle}}}
         {\tj@mklowercase{#1}}
         {\MakeSentenceCase{#1}}}
      {#1}}
  \ExplSyntaxOn
  \cs_new_protected:Npn \tj@mklowercase #1
    { \exp_args:No \text_lowercase:n { \biblatex_text_sentencecase_preprocess:n {#1} } }
  \ExplSyntaxOff
  \renewcommand{\mktitlecase}{\tj@mksentencecase}
  \renewcommand{\mkbooktitlecase}{\tj@mksentencecase}
  % （4）姓名：§7.1.1 规定西文名可缩写为首字母（缩写名后不加点），汉语拼音名“宜用全称”。
  %     样式默认格式 gbnamefmt=lowercase 一律缩写名；全局改用 gbnamefmt=quanpin 又会把西文名
  %     也写成全称。因此逐个判断姓名：姓与名都是汉语拼音时改用样式的全拼格式 name:gbquanpin，
  %     其余仍按原格式缩写。判定规则照搬 gbt7714（gbt7714-2025-numeric.bst 的 is.name.pinyin）：
  %     没有前缀和后缀；姓是一个音节，或用连字符连接的两个音节；名是一个或两个音节，
  %     或用撇号隔开的两个音节；不区分大小写。音节表照录该文件的 pinyin.table1 至 table3，
  %     其中含 ü 的 4 个音节在 gbt7714 中永远不会匹配（它只接受 a 至 z），故未列入。
  \ExplSyntaxOn
  \str_const:Nn \c__tj_pinyin_syllables_str
    {
      ,
      a,ai,an,ang,ao,
      ba,bai,ban,bang,bao,bei,ben,beng,bi,bian,biao,bie,bin,bing,bo,bu,
      ca,cai,can,cang,cao,ce,cen,ceng,cha,chai,chan,chang,chao,che,chen,cheng,chi,chong,chou,
      chu,chuai,chuan,chuang,chui,chun,chuo,ci,cong,cou,cu,cuan,cui,cun,cuo,
      da,dai,dan,dang,dao,de,dei,deng,di,dia,dian,diao,die,ding,diu,dong,dou,du,duan,dui,dun,
      duo,
      e,ei,en,eng,er,
      fa,fan,fang,fei,fen,feng,fo,fou,fu,
      ga,gai,gan,gang,gao,ge,gei,gen,geng,gong,gou,gu,gua,guai,guan,guang,gui,gun,guo,
      ha,hai,han,hang,hao,he,hei,hen,heng,hong,hou,hu,hua,huai,huan,huang,hui,hun,huo,
      ji,jia,jian,jiang,jiao,jie,jin,jing,jiong,jiu,ju,juan,jue,jun,
      ka,kai,kan,kang,kao,ke,ken,keng,kong,kou,ku,kua,kuai,kuan,kuang,kui,kun,kuo,
      la,lai,lan,lang,lao,le,lei,leng,li,lia,lian,liang,liao,lie,lin,ling,liu,long,lou,lu,luan,
      lun,luo,lyu,lyue,
      ma,mai,man,mang,mao,me,mei,men,meng,mi,mian,miao,mie,min,ming,miu,mo,mou,mu,
      na,nai,nan,nang,nao,ne,nei,nen,neng,ni,nian,niang,niao,nie,nin,ning,niu,nong,nu,nuan,nuo,
      nyu,nyue,
      o,ou,
      pa,pai,pan,pang,pao,pei,pen,peng,pi,pian,piao,pie,pin,ping,po,pou,pu,
      qi,qia,qian,qiang,qiao,qie,qin,qing,qiong,qiu,qu,quan,que,qun,
      ran,rang,rao,re,ren,reng,ri,rong,rou,ru,ruan,rui,run,ruo,
      sa,sai,san,sang,sao,se,sen,seng,sha,shai,shan,shang,shao,she,shei,shen,sheng,shi,shou,shu,
      shua,shuai,shuan,shuang,shui,shun,shuo,si,song,sou,su,suan,sui,sun,suo,
      ta,tai,tan,tang,tao,te,teng,ti,tian,tiao,tie,ting,tong,tou,tu,tuan,tui,tun,tuo,
      wa,wai,wan,wang,wei,wen,weng,wo,wu,
      xi,xia,xian,xiang,xiao,xie,xin,xing,xiong,xiu,xu,xuan,xue,xun,
      ya,yan,yang,yao,ye,yi,yin,ying,yong,you,yu,yuan,yue,yun,
      za,zai,zan,zang,zao,ze,zei,zen,zeng,zha,zhai,zhan,zhang,zhao,zhe,zhei,zhen,zheng,zhi,
      zhong,zhou,zhu,zhua,zhuai,zhuan,zhuang,zhui,zhun,zhuo,zi,zong,zou,zu,zuan,zui,zun,zuo,
    }
  \str_new:N \l__tj_pinyin_family_str
  \str_new:N \l__tj_pinyin_given_str
  \seq_new:N \l__tj_pinyin_seq
  \bool_new:N \l__tj_pinyin_bool
  \prg_new_protected_conditional:Npnn \__tj_pinyin_if_syllable:n #1 { T, F, TF }
    {
      \str_if_in:NnTF \c__tj_pinyin_syllables_str { , #1 , }
        { \prg_return_true: } { \prg_return_false: }
    }
  \prg_generate_conditional_variant:Nnn \__tj_pinyin_if_syllable:n { e } { T, F, TF }
  % 由 #2 中的分隔符切开的每一段都必须是一个音节，且至多 #3 段
  \cs_new_protected:Npn \__tj_pinyin_check_parts:nnn #1#2#3
    {
      \seq_set_split:Nnn \l__tj_pinyin_seq {#2} {#1}
      \bool_set_true:N \l__tj_pinyin_bool
      \int_compare:nNnT { \seq_count:N \l__tj_pinyin_seq } > {#3}
        { \bool_set_false:N \l__tj_pinyin_bool }
      \seq_map_inline:Nn \l__tj_pinyin_seq
        { \__tj_pinyin_if_syllable:nF {##1} { \bool_set_false:N \l__tj_pinyin_bool } }
    }
  % 不含撇号的名：一个音节，或能切成两个音节
  \cs_new_protected:Npn \__tj_pinyin_check_given:n #1
    {
      \__tj_pinyin_if_syllable:nTF {#1}
        { \bool_set_true:N \l__tj_pinyin_bool }
        {
          \bool_set_false:N \l__tj_pinyin_bool
          \int_step_inline:nn { \str_count:n {#1} - 1 }
            {
              \bool_if:NF \l__tj_pinyin_bool
                {
                  \__tj_pinyin_if_syllable:eT { \str_range:nnn {#1} { 1 } {##1} }
                    {
                      \__tj_pinyin_if_syllable:eT { \str_range:nnn {#1} { ##1 + 1 } { -1 } }
                        { \bool_set_true:N \l__tj_pinyin_bool }
                    }
                }
            }
        }
    }
  % \tj@ifpinyinname{<是拼音>}{<不是拼音>}：在 biblatex 姓名格式内判断当前姓名
  \cs_new_protected:Npn \tj@ifpinyinname #1#2
    {
      \bool_set_false:N \l__tj_pinyin_bool
      \bool_lazy_and:nnT
        { \tl_if_empty_p:o { \namepartprefix } }
        { \tl_if_empty_p:o { \namepartsuffix } }
        {
          \str_set:Ne \l__tj_pinyin_family_str { \exp_not:o { \namepartfamily } }
          \str_set:Ne \l__tj_pinyin_family_str { \str_casefold:V \l__tj_pinyin_family_str }
          \str_set:Ne \l__tj_pinyin_given_str { \exp_not:o { \namepartgiven } }
          \str_set:Ne \l__tj_pinyin_given_str { \str_casefold:V \l__tj_pinyin_given_str }
          \__tj_pinyin_check_parts:Vnn \l__tj_pinyin_family_str { - } { 2 }
          \bool_if:NT \l__tj_pinyin_bool
            {
              \str_if_in:NnTF \l__tj_pinyin_given_str { ' }
                { \__tj_pinyin_check_parts:Vnn \l__tj_pinyin_given_str { ' } { 2 } }
                { \__tj_pinyin_check_given:V \l__tj_pinyin_given_str }
            }
        }
      \bool_if:NTF \l__tj_pinyin_bool {#1} {#2}
    }
  \cs_generate_variant:Nn \__tj_pinyin_check_parts:nnn { V }
  \cs_generate_variant:Nn \__tj_pinyin_check_given:n { V }
  \ExplSyntaxOff
  \letbibmacro{tj@name:gblowercase}{name:gblowercase}
  \renewbibmacro*{name:gblowercase}[4]{%
    \tj@ifpinyinname
      {\usebibmacro{name:gbquanpin}{#1}{\namepartgiven}{#3}{#4}}%
      {\usebibmacro{tj@name:gblowercase}{#1}{#2}{#3}{#4}}}
\else
  \RequirePackage[sort&compress, bibpunct=half]{gbt7714}   % 半角标点，与 biblatex 的 gbpunctwidth=half 对齐（撰写规范：参考文献标点统一采用半角）
  \bibliographystyle{gbt7714-2025-numeric}
  \setlength{\bibsep}{3pt}
  % 目录条目写在“参考文献”标题之后，页码与跳转锚点才落在标题所在页（与 biblatex 的 heading=bibintoc 一致）。
  % 其余沿用 natbib 对 book 类的定义。
  \renewcommand{\bibsection}{%
    \chapter*{\bibname\@mkboth{\MakeUppercase{\bibname}}{\MakeUppercase{\bibname}}}%
    \addcontentsline{toc}{chapter}{\bibname}%
  }
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

% 未编号一级标题（目录、插图/表格清单、参考文献、附录、谢辞）：撰写规范要求四号黑体居中，
% 区别于正文章标题的小三号。目录、清单与参考文献在分组内调用，
% \appendix 与 \backmatter 之后则一直生效。
\newcommand{\tj@unnumberedheadingformat}{\ctexset{chapter/format={\centering\heiti\tjfontheading}}}

% \makereferences — output bibliography chapter
\iftongjithesis@biblatex
  \newcommand{\makereferences}{%
    \begingroup
    \tj@unnumberedheadingformat
    \printbibliography[heading=bibintoc,title=参考文献]%
    \endgroup
  }
\else
  \newcommand{\makereferences}{%
    \begingroup
    \tj@unnumberedheadingformat
    \bibliography{\tj@bibfiles}%
    \endgroup
  }
\fi

% ==========================================
% General Configurations
% ==========================================

% Line spacing
\setstretch{\tjlinespread}  % 设置全文行距

% Display math spacing — 撰写规范（七）公式：“公式行行距1.5倍”，段前/段后 0 行。
%
% Word 里“段前 0 行 + 段后 0 行 + 行距 1.5 倍”指的是公式段落除 1.5 倍行距外不再
% 追加段间距——1.5 倍行距本身带来的行间留白仍然存在。LaTeX 的默认值正好对应这个
% 效果：\abovedisplayskip 12pt 对正文 \baselineskip 23.49pt 约为半行，与 Word 中
% 1.5 倍行距公式行的留白一致，因此正文公式沿用 LaTeX 默认值，不另行赋值。
%
% 注意不要把它写成 \abovedisplayskip 0\p@：TeX 在显示公式上下插入的是
% \abovedisplayskip / \belowdisplayskip 本身，而不是行距胶，置 0 会让公式紧贴上
% 一行，比规范要求更挤。（并且类文件层的一次性赋值本就无效——size1x.clo 把
% \normalsize、\small、\footnotesize 定义为「设置字号 + 重设这四个 skip」，
% \begin{document} 处的 \normalsize 会立刻改回默认值。）

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
% 附录：
%   “附录”作为未编号 H1 章节标题（四号黑体居中），写入目录。
%   附录内的小节使用 A. B. C. 编号（与正文 chapter.section 解耦），
%   浮动体 (figure/table/equation/…) 随节编号为 A.1、A.2、B.1 …
%   \appendixsection / \appendixsubsection 是 \section / \subsection 的别名，
%   保持 chapters/appendix.tex 的语义；用户也可直接用 \section / \subsection。
\let\tj@origappendix\appendix
\renewcommand{\appendix}{%
  \tj@origappendix
  \tj@unnumberedheadingformat
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
  % 理工科：“A. 节名”；文科：“（A） 节名”（括号来自正文 section/name 延续，无点号）
  \iftongjithesis@humanities
    \ctexset{section/number={\thesection},section/aftername={\hspace{0.5em}}}%
  \else
    \ctexset{section/name={,},section/number={\thesection},section/aftername={.\hspace{0.5em}}}%
  \fi
}
\newcommand{\appendixsection}{\section}
\newcommand{\appendixsubsection}{\subsection}
% Backmatter headings (acknowledgements) use 四号 per the spec.
% The \ctexset override is intentionally permanent for the rest of the document
% (backmatter is always the final structural division).
\let\tj@origbackmatter\backmatter
\renewcommand{\backmatter}{%
  \tj@origbackmatter
  \tj@unnumberedheadingformat
}

% ==========================================
% Typography and Font Settings
% ==========================================

% 表格内所有字体均为五号（\tjfonttable）
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
% 目录标题后留一空行
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

% 目录行距：对应 Word“1.5 倍行距”——使用 \tjtoclinespread
% 目录标题经 \chapter* 排出，spacing 分组内改用四号（\tj@unnumberedheadingformat）
\let\tj@origtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
  \begin{spacing}{\tjtoclinespread}\tj@unnumberedheadingformat\tj@origtableofcontents\end{spacing}%
}
% 插图清单、表格清单（main.tex 中按需启用）的标题与目录一致，用四号
\let\tj@origlistoffigures\listoffigures
\renewcommand{\listoffigures}{\begingroup\tj@unnumberedheadingformat\tj@origlistoffigures\endgroup}
\let\tj@origlistoftables\listoftables
\renewcommand{\listoftables}{\begingroup\tj@unnumberedheadingformat\tj@origlistoftables\endgroup}

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

% 脚注编号使用①②③… (官方规范)
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

% 算法环境把行距压回 \linespread{1.0}（\baselineskip 由 23.49pt 降到 14.45pt），
% 但 \abovedisplayskip / \belowdisplayskip 仍是正文行距下的 12pt——相对压缩后的
% 行距接近一整行空白，算法内的行间公式上下会多出明显空行。按正文里的同一比例
% （12pt ÷ 23.49pt ≈ 0.5 行）随当前行距缩放，两处算法实现都要挂。
\newcommand{\tj@algodisplayskips}{%
  \setlength\abovedisplayskip{0.5\baselineskip}%
  \setlength\abovedisplayshortskip{\z@}%
  \setlength\belowdisplayskip{0.5\baselineskip}%
  \setlength\belowdisplayshortskip{\z@}%
}

% 伪代码
\iftongjithesis@algorithmtwoe
  \SetAlgorithmName{算法}{算法}{算法列表}
  \SetKwInput{KwIn}{输入}
  \SetKwInput{KwOut}{输出}
  \gdef\algocf@Vspace{\vskip\baselineskip\relax}
  \AtBeginEnvironment{algorithm}{\linespread{1.0}\selectfont\tj@algodisplayskips}
  \AfterEndEnvironment{algorithm}{\vspace{\baselineskip}}
\else
  \renewcommand{\algorithmicrequire}{\textbf{输入: }}
  \renewcommand{\algorithmicensure}{\textbf{输出: }}
  \AtBeginEnvironment{algorithmic}{\linespread{1.0}\selectfont\tj@algodisplayskips}
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
  \newcommand*{\chapref}[1]{第~\ref{#1}~章}
  \newcommand*{\secref}[1]{第~\ref{#1}~节}
\fi
\newcommand*{\algoref}[1]{算法~\ref{#1}\tj@refnum}
\renewcommand*{\eqref}[1]{式~(\ref{#1})}
\newcommand*{\tabref}[1]{\tablename~\ref{#1}\tj@refnum}
\newcommand*{\figref}[1]{\figurename~\ref{#1}\tj@refnum}

% Cross-reference formats: 名字放进 #2…#3 让 nameinlink 全段可点（图/表/式 等整词都参与超链接）
\crefformat{listing}{#2代码~#1#3\tj@refnum}
\crefmultiformat{listing}{#2代码~#1#3\tj@refnum}{\tj@numsep 和#2代码~#1#3\tj@refnum}{、#2代码~#1#3\tj@refnum}{\tj@numsep 和#2代码~#1#3\tj@refnum}
\crefrangeformat{listing}{#3代码~#1#4~至#5代码~#2#6\tj@refnum}
\crefformat{lstlisting}{#2代码~#1#3\tj@refnum}
\crefmultiformat{lstlisting}{#2代码~#1#3\tj@refnum}{\tj@numsep 和#2代码~#1#3\tj@refnum}{、#2代码~#1#3\tj@refnum}{\tj@numsep 和#2代码~#1#3\tj@refnum}
\crefrangeformat{lstlisting}{#3代码~#1#4~至#5代码~#2#6\tj@refnum}
\newcommand*{\listingref}[1]{\lstlistingname~\ref{#1}~}

% Configure references in Chinese
% “第X章/节” pattern: number is wrapped, needs full multi/range formats
\iftongjithesis@humanities
  \crefformat{chapter}{#2第#1章#3\tj@refnotnum}
  \crefmultiformat{chapter}{#2第#1章#3\tj@refnotnum}{和#2第#1章#3\tj@refnotnum}{、#2第#1章#3\tj@refnotnum}{和#2第#1章#3\tj@refnotnum}
  \crefrangeformat{chapter}{#3第#1章#4至#5第#2章#6\tj@refnotnum}
  \crefformat{section}{#2第#1节#3\tj@refnotnum}
  \crefmultiformat{section}{#2第#1节#3\tj@refnotnum}{和#2第#1节#3\tj@refnotnum}{、#2第#1节#3\tj@refnotnum}{和#2第#1节#3\tj@refnotnum}
  \crefrangeformat{section}{#3第#1节#4至#5第#2节#6\tj@refnotnum}
\else
  \crefformat{chapter}{#2第~#1~章#3\tj@refnotnum}
  \crefmultiformat{chapter}{#2第~#1~章#3\tj@refnotnum}{和#2第~#1~章#3\tj@refnotnum}{、#2第~#1~章#3\tj@refnotnum}{和#2第~#1~章#3\tj@refnotnum}
  \crefrangeformat{chapter}{#3第~#1~章#4至#5第~#2~章#6\tj@refnotnum}
  \crefformat{section}{#2第~#1~节#3\tj@refnotnum}
  \crefmultiformat{section}{#2第~#1~节#3\tj@refnotnum}{和#2第~#1~节#3\tj@refnotnum}{、#2第~#1~节#3\tj@refnotnum}{和#2第~#1~节#3\tj@refnotnum}
  \crefrangeformat{section}{#3第~#1~节#4至#5第~#2~节#6\tj@refnotnum}
\fi
\crefformat{subsection}{#2第~#1~小节#3\tj@refnotnum}
\crefmultiformat{subsection}{#2第~#1~小节#3\tj@refnotnum}{和#2第~#1~小节#3\tj@refnotnum}{、#2第~#1~小节#3\tj@refnotnum}{和#2第~#1~小节#3\tj@refnotnum}
\crefrangeformat{subsection}{#3第~#1~小节#4至#5第~#2~小节#6\tj@refnotnum}
% “名称~X” pattern: ~ separates CJK name from digit; whole reference wrapped in hyperlink.
% --- Common float/equation types ---
\crefformat{equation}{#2式~(#1)#3\tj@refnum}
\crefmultiformat{equation}{#2式~(#1)#3\tj@refnum}{\tj@numsep 和#2式~(#1)#3\tj@refnum}{、#2式~(#1)#3\tj@refnum}{\tj@numsep 和#2式~(#1)#3\tj@refnum}
\crefrangeformat{equation}{#3式~(#1)#4~至#5式~(#2)#6\tj@refnum}
\crefformat{figure}{#2图~#1#3\tj@refnum}
\crefmultiformat{figure}{#2图~#1#3\tj@refnum}{\tj@numsep 和#2图~#1#3\tj@refnum}{、#2图~#1#3\tj@refnum}{\tj@numsep 和#2图~#1#3\tj@refnum}
\crefrangeformat{figure}{#3图~#1#4~至#5图~#2#6\tj@refnum}
\crefformat{table}{#2表~#1#3\tj@refnum}
\crefmultiformat{table}{#2表~#1#3\tj@refnum}{\tj@numsep 和#2表~#1#3\tj@refnum}{、#2表~#1#3\tj@refnum}{\tj@numsep 和#2表~#1#3\tj@refnum}
\crefrangeformat{table}{#3表~#1#4~至#5表~#2#6\tj@refnum}
\crefformat{algorithm}{#2算法~#1#3\tj@refnum}
\crefmultiformat{algorithm}{#2算法~#1#3\tj@refnum}{\tj@numsep 和#2算法~#1#3\tj@refnum}{、#2算法~#1#3\tj@refnum}{\tj@numsep 和#2算法~#1#3\tj@refnum}
\crefrangeformat{algorithm}{#3算法~#1#4~至#5算法~#2#6\tj@refnum}
\crefformat{algocf}{#2算法~#1#3\tj@refnum}
\crefmultiformat{algocf}{#2算法~#1#3\tj@refnum}{\tj@numsep 和#2算法~#1#3\tj@refnum}{、#2算法~#1#3\tj@refnum}{\tj@numsep 和#2算法~#1#3\tj@refnum}
\crefrangeformat{algocf}{#3算法~#1#4~至#5算法~#2#6\tj@refnum}
\crefformat{FancyVerbLine}{#2第~#1~行#3\tj@refnotnum}
\crefmultiformat{FancyVerbLine}{#2第~#1~行#3\tj@refnotnum}{和#2第~#1~行#3\tj@refnotnum}{、#2第~#1~行#3\tj@refnotnum}{和#2第~#1~行#3\tj@refnotnum}
\crefrangeformat{FancyVerbLine}{#3第~#1~行#4至#5第~#2~行#6\tj@refnotnum}
% --- Theorem types (single + multi for consistency) ---
\crefformat{thm}{#2定理~#1#3\tj@refnum}
\crefmultiformat{thm}{#2定理~#1#3\tj@refnum}{\tj@numsep 和#2定理~#1#3\tj@refnum}{、#2定理~#1#3\tj@refnum}{\tj@numsep 和#2定理~#1#3\tj@refnum}
\crefformat{cor}{#2推论~#1#3\tj@refnum}
\crefmultiformat{cor}{#2推论~#1#3\tj@refnum}{\tj@numsep 和#2推论~#1#3\tj@refnum}{、#2推论~#1#3\tj@refnum}{\tj@numsep 和#2推论~#1#3\tj@refnum}
\crefformat{lem}{#2引理~#1#3\tj@refnum}
\crefmultiformat{lem}{#2引理~#1#3\tj@refnum}{\tj@numsep 和#2引理~#1#3\tj@refnum}{、#2引理~#1#3\tj@refnum}{\tj@numsep 和#2引理~#1#3\tj@refnum}
\crefformat{prop}{#2命题~#1#3\tj@refnum}
\crefmultiformat{prop}{#2命题~#1#3\tj@refnum}{\tj@numsep 和#2命题~#1#3\tj@refnum}{、#2命题~#1#3\tj@refnum}{\tj@numsep 和#2命题~#1#3\tj@refnum}
\crefformat{conj}{#2猜想~#1#3\tj@refnum}
\crefformat{assume}{#2假设~#1#3\tj@refnum}
\crefformat{dfn}{#2定义~#1#3\tj@refnum}
\crefformat{exmp}{#2例~#1#3\tj@refnum}
\crefformat{rem}{#2注~#1#3\tj@refnum}
\crefformat{pf}{#2证明~#1#3\tj@refnum}
\crefformat{proof}{#2证明~#1#3\tj@refnum}

% Configure connecting words
\newcommand{\crefpairconjunction}{ 和~}
\newcommand{\crefmiddleconjunction}{、}
\newcommand{\creflastconjunction}{ 和~}
\newcommand{\crefpairgroupconjunction}{ 和}
\newcommand{\crefmiddlegroupconjunction}{、}
\newcommand{\creflastgroupconjunction}{ 和}
\newcommand{\crefrangeconjunction}{ 至~}

% 超链接在编号后结束，链接结尾会打断 xeCJK 的中西文自动间距，“如图 1.1所示”缺少空格。
% 编号结尾的引用格式（图、表、式、算法、代码、定理等）之后若紧跟汉字，补上 xeCJK 的中西文间距
% \CJKecglue；紧跟标点、空格或命令时什么也不加。章、节、行以汉字结尾，不需要。
% LuaTeX 下由 luatexja 处理间距，这里不做任何事。
\ExplSyntaxOn
\bool_new:N \g__tj_ref_num_bool
\cs_new_protected:Npn \__tj_ref_cjk_space:
  {
    \sys_if_engine_xetex:T
      {
        \peek_regex:nT { [\x{3400}-\x{4DBF}\x{4E00}-\x{9FFF}\x{F900}-\x{FAFF}] }
          { \CJKecglue }
      }
  }
% 引用格式以编号结尾：记下这一点，并处理格式内部紧跟的“和”
\cs_new_protected:cpn { tj@refnum }
  { \bool_gset_true:N \g__tj_ref_num_bool \__tj_ref_cjk_space: }
% 同类多项引用中，编号与后一项的“和”之间（XeTeX）
\cs_new_protected:cpn { tj@numsep }
  { \sys_if_engine_xetex:T { \CJKecglue } }
\cs_new_protected:cpn { tj@refnotnum }
  { \bool_gset_false:N \g__tj_ref_num_bool }
% 整条引用结束后：最后一项以编号结尾时，按后面的字符补间距
\cs_new_protected:cpn { tj@refcjkspace }
  {
    \bool_if:NT \g__tj_ref_num_bool
      { \bool_gset_false:N \g__tj_ref_num_bool \__tj_ref_cjk_space: }
  }
\ExplSyntaxOff
\AtBeginDocument{%
  \NewCommandCopy\tj@cref@orig\cref
  \RenewDocumentCommand\cref{sm}{\IfBooleanTF{#1}{\tj@cref@orig*{#2}}{\tj@cref@orig{#2}}\tj@refcjkspace}%
  \NewCommandCopy\tj@crefrange@orig\crefrange
  \RenewDocumentCommand\crefrange{smm}{\IfBooleanTF{#1}{\tj@crefrange@orig*{#2}{#3}}{\tj@crefrange@orig{#2}{#3}}\tj@refcjkspace}%
}

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

      % 封面大标题：初号黑体（官方规范，理工/文科不同）
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

% 复选框渲染：\tjchecked/\tjunchecked 是勾选/未勾选的字形本身；\tjcheckbox
% 是信息说明页“成果类型”专用的判断逻辑（含 design/engineering 二选一映射，
% 不通用）；\tjcheckboxeq{当前值}{目标值} 是通用版本——当前值等于目标值时
% 打勾，否则留空，供 \midtermdecision 等其他“多选一”复选框场景复用。
% 方框尺寸：复选框的 □ 应与正文汉字等宽等高，而 amssymb 的 $\square$
% 明显小于周围汉字，故按当前字号缩放到 \tj@checkboxsize（相对 em，随字号自适应）
% 并整体下沉 0.1em，使方框与汉字视觉等高、基线一致。不直接使用 U+25A1 全角字符，
% 是因为该字形在 fandol/mac/windows/adobe/founder 各 fontset 下的覆盖与宽度并不一致。
% 勾号与方框分别装入等宽盒子后用 \llap 叠印，使勾号居中于方框（而非左对齐）；
% 下沉量作用于整组而非仅方框，否则方框下沉而勾号不动，勾号尖端会越出方框上边框。
% 勾号另按 \tj@checkmarksize（小于方框边长）限高，确保落在方框内部。
% \mbox 包裹：\llap/\rlap 若为段首第一个盒子会触发 TeX 的伪断行（勾号脱落、方框变空），
% 故用 \mbox 强制水平模式，使复选框在段首（如中期报告审核意见框）也能正确渲染。
\newcommand{\tj@checkboxsize}{0.95em}
\newcommand{\tj@checkmarksize}{0.62em}
\newcommand{\tj@checkboxglyph}[1]{%
  \mbox{\raisebox{-0.1em}{%
    \makebox[\tj@checkboxsize][c]{\resizebox{\tj@checkboxsize}{!}{$\square$}}%
    \llap{\makebox[\tj@checkboxsize][c]{#1}}%
  }}%
}
\newcommand{\tjchecked}{\tj@checkboxglyph{\resizebox{!}{\tj@checkmarksize}{$\checkmark$}}}
\newcommand{\tjunchecked}{\tj@checkboxglyph{}}
\newcommand{\tjcheckbox}[1]{%
  \ifthenelse{\equal{\tongjiinfotype}{#1}\OR
              \(\equal{#1}{design}\AND\equal{\tongjiinfotype}{engineering}\)}%
    {\tjchecked}{\tjunchecked}%
}
\newcommand{\tjcheckboxeq}[2]{%
  \ifthenelse{\equal{#1}{#2}}{\tjchecked}{\tjunchecked}%
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

    % 按成果类型只显示对应行（成果类型二选一）
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
    （请列出所有提交的支撑材料名称，如：毕业设计-全套图纸、毕业作品、计算书、程序代码、附录等）
    }
  \end{titlepage}
  \setstretch{\tjlinespread}
  \global\tjbindinglinetrue
}

% 设置中文摘要页（毕业设计时标题改为“设计总说明”）
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
      \tj@abstractblock{\bfseries\heiti\zihao{3}}{\tjtitlecninline{\tongjithesissubtitle}}% 副标题：三号（官方规范）
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
      \tj@abstractblock{\zihao{3}\bfseries}{\tjtitleeninline{\tongjithesissubtitleeng}}% 副标题：三号（官方规范）
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
% 与正文论文共用 chapters/metadata.tex 中的学院/专业/学生/课题信息（指导教师
% 在 3 份表格中均为手写签字位，不预填，故不读取 \tongjithesisadvisor）；
% \MakeDocument 依据 doctype 分派到 \MakeTaskBook / \MakeProposal / \MakeMidterm，
% 三者仅渲染封面（任务书另含起讫时间与签字区，如 \MakeCover 之于论文封面），正文各段落内容
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

% 中期报告专用信息：专业审核意见的“同意/不同意”复选框（可选，默认留空——
% 该项通常由专业负责人在打印后手写勾选；若需要提前在电子版中标注，
% 可调用 \midtermdecision{agree} 或 \midtermdecision{disagree}）。
\newcommand{\midtermdecision}[1]{\def\tongjimidtermdecision{#1}}

% 表格环境：课题信息表 / 签字区专用，字段文字取四号宋体。
% 字体显式声明为 \songti：三份行政表格的课题信息表为四号宋体，与论文封面
% \MakeCover 的小二号黑体不同——两者共用版式（居中、定宽下划线）而非字体，
% 故此处不能依赖文档默认字族隐式生效。
% 本表不绘制边框，仅靠下划线呈现填空位置（与 \MakeCover 的 information
% 环境一致），故不设置任何竖线或 \hline。
% 可选参数为 tabcolsep（默认 8pt，与 information 一致）；必须在 \oldtabular
% 开始解析列格式前设定——tabcolsep 一旦用于构建列间距，在表格主体内再
% \setlength 为时已晚（且直接放在 tabular 主体内并非合法位置）。
\newenvironment{tjformtable}[2][8pt]{%
  \renewcommand{\arraystretch}{1.6}
  \setlength{\tabcolsep}{#1}
  \noindent\songti\zihao{4}\selectfont\oldtabular{#2}
}{%
  \endoldtabular
}

% 课题信息表：任务书/开题报告/中期报告共用。沿用论文封面 \MakeCover 的版式——
% 整体居中，每个字段独占一行，用 \ulinecentered 定宽下划线：下划线长度、位置
% 不随是否填写而变化（空则为纯下划线，内容过长则在定宽内居中换行），与论文
% 封面风格统一。
\newcommand{\tj@formsubjecttable}{%
  \begin{center}
    \begin{tjformtable}{M{5em}M{22em}}
      课题名称 & \ulinecentered{\tongjithesistitle} \\
      副\enskip{}标\enskip{}题 & \ulinecentered{\tongjithesissubtitle} \\
      学\quad{}\quad{}院 & \ulinecentered{\tongjischool} \\
      专\quad{}\quad{}业 & \ulinecentered{\tongjimajor} \\
      学生姓名 & \ulinecentered{\tongjiauthor} \\
      学\quad{}\quad{}号 & \ulinecentered{\tongjiauthornumber} \\
    \end{tjformtable}
  \end{center}%
}

% 说明性文字（此项成稿删除）与提示性文字（内容提示，不删除）——两种灰色，语义不同
\newcommand{\tjformnote}[1]{{\tjfontbody\color{tjnotegray}\selectfont #1\par}}
\newcommand{\tjformhint}[1]{{\tjfontbody\color{tjhintgray}\selectfont #1\par}}

% 一级小节标题：四号黑体，缩进 2 字符（正文分节，不计入目录、不参与章节编号）
\newcommand{\tjformsection}[1]{%
  \par\vspace{\baselineskip}%
  \noindent{\zihao{4}\heiti\selectfont\hspace{2em}#1}\par
  \vspace{0.5\baselineskip}%
}

% 二级小节标题：小四号黑体，缩进 2 字符，段前/段后各 0.5 行
% （撰写规范：2 级标题小四号黑体，序号与题名之间空一格）。
% 与 \tjformsection 一样采用手工编号——两级标题均不进入目录、不参与章节编号，
% 故不使用 enumerate：列表环境无法把序号本身也置为黑体，且会额外引入列表缩进。
\newcommand{\tjformsubsection}[1]{%
  \par\vspace{0.5\baselineskip}%
  \noindent{\tjfontbody\heiti\selectfont\hspace{2em}#1}\par
  \vspace{0.5\baselineskip}%
}

% 居中的说明性大标题（如中期报告首页的“填写说明”）：小二号黑体加粗
\newcommand{\tjformnotice}[1]{%
  \begin{center}
    \vspace*{3\baselineskip}
    {\zihao{-2}\heiti\bfseries\selectfont #1}\par
    \vspace{2\baselineskip}
  \end{center}%
}

% 说明性正文（\tjformnotice 标题之下的条目）：四号宋体，比正文各节的小四号大一号
\newenvironment{tjformnoticebody}{%
  \par\zihao{4}\selectfont
}{%
  \par
}

% 审核意见框内的字段标签（如“指导教师意见：”）：小四黑体。
% 标签单独成组，使紧随其后的灰色提示文字（\tjformnote/\tjformhint）保持宋体。
\newcommand{\tjformlabel}[1]{{\tjfontbody\heiti\selectfont #1}}

% 日期空白（年/月/日下划线填空）
\newcommand{\tjdateblank}{\ulinebox{3em}~年~\ulinebox{2em}~月~\ulinebox{2em}~日}

% 签字行：签名标签 + 定宽下划线 + 日期填空，右对齐。整行（含年/月/日）取黑体——
% 正文中的签字行（任务书末尾、开题/中期报告的审核意见框内）为黑体，与同框内的
% 宋体提示文字不同；任务书封面的签字行则属于封面信息表的一部分，随 \tjformtable
% 取四号宋体，不走本命令。
% #1（可选）：字号，默认小四；任务书正文末尾的签字行为四号，故显式传 \zihao{4}。
% #2：标签文字（如“指导教师签名”）；#3：签名下划线宽度。
\newcommand{\tjformsignature}[3][\tjfontbody]{%
  \begin{flushright}
    {#1\heiti\selectfont #2：\ulinebox{#3}\qquad\tjdateblank}%
  \end{flushright}%
}

% 数字填空：定宽下划线 + 居中数字（#2 为空则为纯下划线），使起讫日期等数字字段
% 无论填写与否都保持等长下划线。用 ulem 的 \uline（同 \ulinebox/\ulinecentered），
% 使全表下划线的粗细与位置一致。
\newcommand{\tjnumline}[2]{\uline{\makebox[#1][c]{#2}}}

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
% 不与正文一同装订，且作为独立行政表格本无该装饰。这与 \MakeCover/\MakeInfoPage
% 形成对比——后两者的装订线仅在封面/信息页本身关闭，此后随论文正文恢复；此处
% 恢复为 true 没有意义（\clearpage 而非 titlepage 的 \newpage 触发首页 shipout，
% 若在 \clearpage 前恢复为 true 会导致装订线错误地出现在封面页本身）。
% 三个命令均不将 \tjbindingline 恢复为 true——同一次编译内不会再调用 \MakeCover
% 等其他封面命令，故无需担心状态泄漏到其他文档。

% 任务书封面：课题信息表 + 起讫时间 + 指导教师/教学院长签字区。
% 版式沿用论文封面 \MakeCover：整体居中、下划线定宽（\ulinecentered），风格统一。
\newcommand{\MakeTaskBook}{%
  \global\tjbindinglinefalse
  \begin{center}
    \vspace*{2\baselineskip}
    \includegraphics[height=1.7cm]{figures/tongji.pdf}\\
    \vspace{1em}
    {\heiti\tjfontformtitle\selectfont \tjformheadertext 任务书}\par
    \vspace{3\baselineskip}
  \end{center}

  \tj@formsubjecttable

  \vspace{2\baselineskip}
  % 起讫时间：标签独占一行 + 日期区间另起一行，整体居中
  \begin{center}\zihao{4}\selectfont
    \tjformheadertext 起讫时间\\[0.5em]
    自~\tjnumline{2.4em}{\tongjitaskbookstartyear}~年~\tjnumline{1.5em}{\tongjitaskbookstartmonth}~月~\tjnumline{1.5em}{\tongjitaskbookstartday}~日至~\tjnumline{2.4em}{\tongjitaskbookendyear}~年~\tjnumline{1.5em}{\tongjitaskbookendmonth}~月~\tjnumline{1.5em}{\tongjitaskbookendday}~日共~\tjnumline{1.5em}{\tongjitaskbookweeks}~周
  \end{center}

  \vfill

  % 签字区：居中
  \begin{center}
    \begin{tjformtable}[2pt]{M{7em}M{8.6em}M{11.5em}}
      指导教师签名 & \ulinebox{8.6em} & \tjdateblank \\
      教学院长签名 & \ulinebox{8.6em} & \tjdateblank \\
    \end{tjformtable}
  \end{center}
  \vspace*{1.5cm}
  \clearpage
}

% 开题报告封面：课题信息表（无起讫时间）+ 填表日期
\newcommand{\MakeProposal}{%
  \global\tjbindinglinefalse
  \begin{center}
    \vspace*{2\baselineskip}
    \includegraphics[height=1.7cm]{figures/tongji.pdf}\\
    \vspace{1em}
    {\heiti\tjfontformtitle\selectfont \tjformheadertext 开题报告}\par
    \vspace{3\baselineskip}
  \end{center}

  \tj@formsubjecttable

  \vfill
  \begin{center}\zihao{4}\selectfont \tjdateblank\end{center}
  \vspace*{1.3cm}
  \clearpage
}

% 中期报告封面：与开题报告共用同一表格结构（三者同源）
\newcommand{\MakeMidterm}{%
  \global\tjbindinglinefalse
  \begin{center}
    \vspace*{2\baselineskip}
    \includegraphics[height=1.7cm]{figures/tongji.pdf}\\
    \vspace{1em}
    {\heiti\tjfontformtitle\selectfont \tjformheadertext 中期报告}\par
    \vspace{3\baselineskip}
  \end{center}

  \tj@formsubjecttable

  \vfill
  % 中期报告封面填表日期为三号——此处字号与开题报告（四号）不同
  \begin{center}\zihao{3}\selectfont \tjdateblank\end{center}
  \vspace*{1.3cm}
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
% cfg is found via TEXINPUTS: locally via latexmkrc (./style//), or alongside cls on CTAN/texmf.
\AtEndOfPackage{
  \InputIfFileExists{tongjithesis.cfg}{}{}
}
