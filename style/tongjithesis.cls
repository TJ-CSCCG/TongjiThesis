%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tongjithesis -- Tongji University Thesis Template
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tongjithesis}[2026/03/27 v1.2.0 Tongji University Thesis Class]

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

% Define fullwidthstop option (default is false)
\DeclareBoolOption[false]{fullwidthstop}
% Define times option (default is false)
\DeclareBoolOption[false]{times}
% Define minted option (default is true)
\DeclareBoolOption[true]{minted}
% Define biblatex option (default is true)
\DeclareBoolOption[true]{biblatex}
% Define degree option: bachelor (default), master, doctor
\DeclareStringOption[bachelor]{degree}

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

% ==========================================
% Class Loading
% ==========================================
% 加载 ctexbook 类
\LoadClass[UTF8,a4paper,zihao=5]{ctexbook}

% ==========================================
% Formatting Constants (官方模板规范)
% ==========================================
% Font sizes
\newcommand{\tjfonttitle}{\zihao{-2}}       % 课题名称：小二号
\newcommand{\tjfontheading}{\zihao{4}}       % 一级标题 / 摘要标题 / 目录标题：四号
\newcommand{\tjfontbody}{\zihao{5}}          % 正文 / 二三级标题 / 关键词 / 摘要正文：五号
\newcommand{\tjfontcaption}{\small}          % 表题 / 图题：小五号（\small = \zihao{-5}）
\newcommand{\tjfonttable}{\zihao{-5}}        % 表内文字：小五号
% Spacing
\newcommand{\tjskipbeforesec}{.5\baselineskip}  % 段前 0.5 行
\newcommand{\tjskipaftersec}{.5\baselineskip}   % 段后 0.5 行
\newcommand{\tjlinespread}{1.5}               % 全文行距倍数（≈18磅 at 五号字）
% Header and cover text
\newcommand{\tjheadertext}{毕业设计（论文）}
\makeatletter
\newcommand{\tj@covertype}{本科毕业设计（论文）}
\makeatother

% ==========================================
% Required Packages
% ==========================================
% Page layout
\setlength{\headheight}{43pt}
\RequirePackage[a4paper,top=4.0cm,bottom=2.7cm,left=3.3cm,right=1.8cm]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{eso-pic}

% Typography and text formatting
\RequirePackage[T1]{fontenc}
\RequirePackage{setspace}
\RequirePackage[inline]{enumitem}
\RequirePackage{circledsteps}
\RequirePackage[normalem]{ulem}
\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{hologo}
\RequirePackage{graphicx}

% Table of contents
\RequirePackage[titles]{tocloft}

% Mathematics
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,amscd}
\makeatletter
\iftongjithesis@times
  \RequirePackage{fontspec}%
  \setmainfont{Times New Roman}%
\else
  \RequirePackage{newtxtext,newtxmath}%
\fi
\makeatother

\RequirePackage{upgreek}

% Tables and figures
\RequirePackage{float}
\RequirePackage{multirow}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{threeparttable}
\RequirePackage{threeparttablex}
\RequirePackage{subcaption}

% Algorithms and code listings
\RequirePackage{algorithm}
\RequirePackage{algorithmicx}
\RequirePackage{algpseudocode}

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
  framexleftmargin=2.5em,
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
  escapeinside=||
}
\renewcommand{\lstlistingname}{代码}
\renewcommand{\lstlistlistingname}{代码列表}

% Conditionally load minted package (optional)
\makeatletter
\iftongjithesis@minted
  \RequirePackage[chapter]{minted}
  \setminted{linenos,
    bgcolor=bg,
    fontsize=\small,
    breaklines,
    mathescape,
    escapeinside=||}
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

% Non-float listing environment for cross-page code with captions
\newenvironment{longlisting}{\captionsetup{type=listing}}{\medskip}
\makeatother

\RequirePackage{tcolorbox}
\RequirePackage{verbatim}

% Add enhanced verbatim support (no Python dependency)
\RequirePackage{fancyvrb}  % Enhanced verbatim environments
\fvset{
  frame=single,
  numbers=left,
  fontsize=\small,
  baselinestretch=1,
  tabsize=4
}

% Cross-referencing and hyperlinks
\RequirePackage[colorlinks,allcolors=black,unicode=true]{hyperref}
\RequirePackage{nameref}
\RequirePackage[nameinlink,noabbrev]{cleveref}

% Units and graphics
\RequirePackage{siunitx}[=v2]
\RequirePackage{tikz}

% Caption customization
\DeclareCaptionLabelSeparator{twospace}{\ ~}
\RequirePackage[font=small,labelsep=twospace]{caption}

% ==========================================
% Bibliography Configuration
% ==========================================
\makeatletter
\iftongjithesis@biblatex
  \RequirePackage[
    backend=biber,
    style=gb7714-2015,
    natbib=true,
  ]{biblatex}
\else
  \RequirePackage[sort&compress]{gbt7714}
  \bibliographystyle{gbt7714-numerical}
  \setlength{\bibsep}{3pt}
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
\makeatother

% ==========================================
% General Configurations
% ==========================================

% Line spacing
\setstretch{\tjlinespread}  % 设置全文行距

% ==========================================
% Page Layout
% ==========================================

% 重新定义 \cleardoublepage 命令
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{
  \clearpage
  {\pagestyle{empty}\origdoublepage}
}
\let\cleardoublepage\clearemptydoublepage

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
  \sbox{\tjbindZ}{\makebox[\bindwidth][c]{装}}%
  \sbox{\tjbindD}{\makebox[\bindwidth][c]{订}}%
  \sbox{\tjbindX}{\makebox[\bindwidth][c]{线}}%
}

% Flag to suppress binding line on cover page
\makeatletter
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
\makeatother

% 设置摘要与目录页样式（如页眉、页脚等）
\fancypagestyle{firststyle}{
  \fancyhf{}
  \fancyhead[LO,RE]{~ \includegraphics[height=1.14cm]{figures/tongji.pdf}~}
  \fancyhead[RO,LE]{\large ~\tjheadertext~\\}
  \fancyfoot[C]{\large \thepage}
  \renewcommand{\headrulewidth}{1.8pt}
  \renewcommand{\footrulewidth}{0pt}
}

% 设置正文页样式（如页眉、页脚等）
\fancypagestyle{mainstyle}{
  \fancyhf{}
  \fancyhead[LO,RE]{~ \includegraphics[height=1.14cm]{figures/tongji.pdf}~}
  \fancyhead[RO,LE]{\large ~\tjheadertext~\\}
  \fancyfoot[RO]{{\large 共\quad \pageref{LastPage}\quad 页\quad 第\quad \thepage \quad 页}}
  \fancyfoot[LE]{{\large 第\quad \thepage \quad 页\quad 共\quad \pageref{LastPage}\quad 页}}
  \renewcommand{\headrulewidth}{1.8pt}
  \renewcommand{\footrulewidth}{1.8pt}
}

% 自动设置前言和正文的页面样式
% ctexbook 的 \chapter 会将首页设为 plain 样式，需要重定义 plain 以匹配当前样式
\makeatletter
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
\makeatother
% Note: \backmatter is NOT redefined. The default ctexbook behavior
% (disabling chapter numbering, keeping page numbers continuous) is correct.

% ==========================================
% Typography and Font Settings
% ==========================================

% 表格内所有字体均为小五
\AtBeginEnvironment{table}{\tjfonttable}
\AtBeginEnvironment{tabular}{\tjfonttable}
\AtBeginEnvironment{tabularx}{\tjfonttable}
\AtBeginEnvironment{longtable}{\tjfonttable}
\AtBeginEnvironment{tablenotes}{\tjfonttable}

% ==========================================
% Lists and Enumerations
% ==========================================

% 设置有序列表与无序列表格式
\setlistdepth{2}

\setlist[enumerate]{nosep,labelsep=0pt}
\setlist[enumerate,1]{label=（\arabic*）,left=2em,nosep,labelsep=0pt,wide=\parindent}
\setlist[enumerate,2]{label=\Circled{\arabic*},nosep,labelsep=0pt,labelwidth=1em,listparindent=0pt}

\setlist[itemize]{nosep}
\setlist[itemize,1]{wide=\parindent}
\setlist[itemize,2]{wide=2\parindent}

% ==========================================
% Table of Contents Formatting
% ==========================================

% 修改目录编号与文字的间距，默认为 1em，强制修改为 0.5em
\makeatletter
\renewcommand{\numberline}[1]{%
  \settowidth\@tempdimb{#1\hspace{0.5em}}%
  \hb@xt@\@tempdimb{\@cftbsnum #1\@cftasnum\hfil}\@cftasnumb}
\makeatother

% 在上述修改基础上，符合模板标题对齐要求
\renewcommand{\cftdot}{$\cdot$}
\renewcommand{\cftdotsep}{1}
\setlength{\cftchapindent}{0em}
\setlength{\cftsecindent}{1em}
\setlength{\cftsubsecindent}{4em}
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\renewcommand{\contentsname}{\tjfontheading\heiti\textmd{目\hspace{0.5em}录}}
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

% 目录使用单倍行距（官方模板要求）
\apptocmd{\tableofcontents}{}{}{}% ensure command exists
\pretocmd{\tableofcontents}{\begin{spacing}{1.0}}{}{}
\apptocmd{\tableofcontents}{\end{spacing}}{}{}

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
\makeatletter
\AtBeginDocument{%
  \counterwithin{listing}{chapter}%
  \counterwithin{lstlisting}{chapter}%
  \let\c@lstlisting\c@listing
}
\makeatother

% 设置正文页内章节标题格式
\ctexset{
  chapter={%
    format={\centering\heiti\tjfontheading},
    nameformat={},
    name={},
    number={\arabic{chapter}},
    aftername={\quad},
    break={\clearpage},
    % Negative beforeskip: absolute value (16pt) is the vertical space above
    % the heading; the negative sign suppresses first paragraph indent (ctex convention).
    beforeskip={-16pt},
    afterskip={\tjskipaftersec},
  },
  section={%
    format={\heiti\tjfontbody},
    aftername={\space},
    beforeskip={\tjskipbeforesec},
    afterskip={\tjskipaftersec},
  },
  subsection={%
    format={\heiti\tjfontbody},
    aftername={\space},
    beforeskip={\tjskipbeforesec},
    afterskip={\tjskipaftersec},
    indent={2em},
  },
  subsubsection={%
    format={\heiti\tjfontbody},
    numbering=true,
    number={\Alph{subsubsection}},
    aftername={.\space},
    beforeskip={0pt},
    afterskip={0pt},
    indent={2em},
    aftertitle={\par},
  },
  paragraph={%
    format={\heiti\tjfontbody},
    numbering=true,
    number={\alph{paragraph}},
    aftername={.\space},
    beforeskip={0pt},
    afterskip={0pt},
    indent={2em},
    aftertitle={\par},
  },
  appendix/name={},
}

\setcounter{secnumdepth}{5}


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
\renewcommand{\algorithmicrequire}{\textbf{输入: }}
\renewcommand{\algorithmicensure}{\textbf{输出: }}
\makeatletter
\renewenvironment{algorithm}
{
  \vskip 20pt
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
  \vskip 20pt
}% \@fs@post for \@fs@ruled
\makeatother

% ==========================================
% Cross-Referencing Commands
% ==========================================

% 交叉引用
\newcommand*{\chapref}[1]{第~\ref{#1}~章~}
\newcommand*{\secref}[1]{第~\ref{#1}~节~}
\newcommand*{\algoref}[1]{算法~\ref{#1}~}
\renewcommand*{\eqref}[1]{公式（\ref{#1}）~}
\newcommand*{\tabref}[1]{\tablename~\ref{#1}~}
\newcommand*{\figref}[1]{\figurename~\ref{#1}~}

% Cross-reference names for code listings (both float types)
\crefformat{listing}{代码~#2#1#3}
\crefmultiformat{listing}{代码~#2#1#3}{和代码~#2#1#3}{、代码~#2#1#3}{和代码~#2#1#3}
\crefrangeformat{listing}{代码~#3#1#4~至代码~#5#2#6}
\crefformat{lstlisting}{代码~#2#1#3}
\crefmultiformat{lstlisting}{代码~#2#1#3}{和代码~#2#1#3}{、代码~#2#1#3}{和代码~#2#1#3}
\crefrangeformat{lstlisting}{代码~#3#1#4~至代码~#5#2#6}
\newcommand*{\listingref}[1]{\lstlistingname~\ref{#1}~}

% Configure references in Chinese
% "第X章/节" pattern: number is wrapped, needs full multi/range formats
\crefformat{chapter}{第~#2#1#3~章}
\crefmultiformat{chapter}{第~#2#1#3~章}{和第~#2#1#3~章}{、第~#2#1#3~章}{和第~#2#1#3~章}
\crefrangeformat{chapter}{第~#3#1#4~章至第~#5#2#6~章}
\crefformat{section}{第~#2#1#3~节}
\crefmultiformat{section}{第~#2#1#3~节}{和第~#2#1#3~节}{、第~#2#1#3~节}{和第~#2#1#3~节}
\crefrangeformat{section}{第~#3#1#4~节至第~#5#2#6~节}
\crefformat{subsection}{第~#2#1#3~小节}
\crefmultiformat{subsection}{第~#2#1#3~小节}{和第~#2#1#3~小节}{、第~#2#1#3~小节}{和第~#2#1#3~小节}
\crefrangeformat{subsection}{第~#3#1#4~小节至第~#5#2#6~小节}
% "名称~X" pattern: ~ separates CJK name from digit.
% --- Common float/equation types ---
\crefformat{equation}{式~#2#1#3}
\crefmultiformat{equation}{式~#2#1#3}{和式~#2#1#3}{、式~#2#1#3}{和式~#2#1#3}
\crefrangeformat{equation}{式~#3#1#4~至式~#5#2#6}
\crefformat{figure}{图~#2#1#3}
\crefmultiformat{figure}{图~#2#1#3}{和图~#2#1#3}{、图~#2#1#3}{和图~#2#1#3}
\crefrangeformat{figure}{图~#3#1#4~至图~#5#2#6}
\crefformat{table}{表~#2#1#3}
\crefmultiformat{table}{表~#2#1#3}{和表~#2#1#3}{、表~#2#1#3}{和表~#2#1#3}
\crefrangeformat{table}{表~#3#1#4~至表~#5#2#6}
\crefformat{algorithm}{算法~#2#1#3}
\crefmultiformat{algorithm}{算法~#2#1#3}{和算法~#2#1#3}{、算法~#2#1#3}{和算法~#2#1#3}
\crefrangeformat{algorithm}{算法~#3#1#4~至算法~#5#2#6}
\crefformat{FancyVerbLine}{第~#2#1#3~行}
\crefmultiformat{FancyVerbLine}{第~#2#1#3~行}{和第~#2#1#3~行}{、第~#2#1#3~行}{和第~#2#1#3~行}
\crefrangeformat{FancyVerbLine}{第~#3#1#4~行至第~#5#2#6~行}
% --- Theorem types (single + multi for consistency) ---
\crefformat{thm}{定理~#2#1#3}
\crefmultiformat{thm}{定理~#2#1#3}{和定理~#2#1#3}{、定理~#2#1#3}{和定理~#2#1#3}
\crefformat{cor}{推论~#2#1#3}
\crefmultiformat{cor}{推论~#2#1#3}{和推论~#2#1#3}{、推论~#2#1#3}{和推论~#2#1#3}
\crefformat{lem}{引理~#2#1#3}
\crefmultiformat{lem}{引理~#2#1#3}{和引理~#2#1#3}{、引理~#2#1#3}{和引理~#2#1#3}
\crefformat{prop}{命题~#2#1#3}
\crefmultiformat{prop}{命题~#2#1#3}{和命题~#2#1#3}{、命题~#2#1#3}{和命题~#2#1#3}
\crefformat{conj}{猜想~#2#1#3}
\crefformat{assume}{假设~#2#1#3}
\crefformat{dfn}{定义~#2#1#3}
\crefformat{exmp}{例~#2#1#3}
\crefformat{rem}{注~#2#1#3}
\crefformat{pf}{证明~#2#1#3}
\crefformat{proof}{证明~#2#1#3}

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
  \zihao{-3}\oldtabular[#1]
}{\renewcommand{\arraystretch}{1.2}\endoldtabular
}

\newlength{\covertextwidth}
\newlength{\covermaxwidth}

\newcommand{\ulinecentered}[1]{
  \setlength{\covertextwidth}{\widthof{#1}}
  \setlength{\covermaxwidth}{20em} % Set the maximum width you allow
  \ifthenelse{\lengthtest{\covertextwidth > \covermaxwidth}}{
    % Calculate scale factor and scale down text if too wide
    \pgfmathsetmacro{\scalefactor}{\covermaxwidth/\covertextwidth}
    \uline{\makebox[\covermaxwidth][c]{\scalebox{\scalefactor}[1]{#1}}}
  }{
    \uline{\makebox[\covermaxwidth][c]{#1}} % Use normal text if within the limit
  }
}

% 论文基本信息配置
\newcommand{\school}[1]{\def\tongjischool{#1}}
\newcommand{\major}[1]{\def\tongjimajor{#1}}
\newcommand{\student}[2]{\def\tongjiauthornumber{#1}\def\tongjiauthor{#2}}
\newcommand{\thesistitle}[2]{\def\tongjithesistitle{#1}\def\tongjithesissubtitle{#2}}
\newcommand{\thesistitleeng}[2]{\def\tongjithesistitleeng{#1}\def\tongjithesissubtitleeng{#2}}
\newcommand{\thesisadvisor}[1]{\def\tongjithesisadvisor{#1}}
\newcommand{\thesisdate}[3]{\def\tongjithesisyear{#1}\def\tongjithesismonth{#2}\def\tongjithesisday{#3}}

% 设置封面
\makeatletter
\newcommand{\MakeCover}[0]{
  \begin{titlepage}
    \begin{center}
      \global\tjbindinglinefalse
      \vspace*{\fill}

      \includegraphics[height=2.25cm]{figures/tongji.pdf}

      \tjfonttitle\MakeUppercase{\textbf{\tongjiuniversityeng}}
      \vskip 30pt

      \zihao{-0}\heiti{\tj@covertype}
      \vskip 60pt

      \begin{information}{M{5em}M{22em}}
        \tjfonttitle\heiti{课题名称} & \ulinecentered{\tongjithesistitle} \\
        \tjfonttitle\heiti{副\enskip{}标\enskip{}题} & \ulinecentered{\tongjithesissubtitle} \\
        \tjfonttitle\heiti{学\quad{}\quad{}院} & \ulinecentered{\tongjischool} \\
        \tjfonttitle\heiti{专\quad{}\quad{}业} & \ulinecentered{\tongjimajor} \\
        \tjfonttitle\heiti{学生姓名} & \ulinecentered{\tongjiauthor} \\
        \tjfonttitle\heiti{学\quad{}\quad{}号} & \ulinecentered{\tongjiauthornumber} \\
        \tjfonttitle\heiti{指导教师} & \ulinecentered{\tongjithesisadvisor} \\
        \tjfonttitle\heiti{日\quad{}\quad{}期} & \ulinecentered{\tongjithesisyear{}年\tongjithesismonth{}月\tongjithesisday{}日} \\
      \end{information}

      \vspace*{\fill}
    \end{center}
  \end{titlepage}
  \global\tjbindinglinetrue
}
\makeatother

% 设置中文摘要页
\newcommand{\MakeAbstract}[2]{
  \begin{center}\bfseries\heiti\tjfonttitle
    \ \\
    \tongjithesistitle
  \end{center}
  \vspace{1pt}
  \begin{center}\heiti\tjfontheading
    摘\hspace{0.5em}要
  \end{center}
  \vspace{-0.5em}

  \begin{spacing}{1.5}
    \songti\tjfontbody #1
    \par
  \end{spacing}

  \vskip 5mm
  \noindent{\songti\tjfontbody{%
      \textbf{关键词：}#2
    }}~\\
}

% 设置英文摘要页
\newcommand{\MakeAbstractEng}[2]{
  \clearpage
  \begin{center}\heiti\tjfonttitle
    \ \\
    \textbf{\tongjithesistitleeng}
  \end{center}
  \vspace{1pt}
  \begin{center}\heiti\tjfontheading
    \textbf{ABSTRACT}
  \end{center}
  \vspace{-0.5em}

  \begin{spacing}{1.5}
    \tjfontbody #1
    \par
  \end{spacing}

  \vskip 13.65pt % 小五字体单倍行距 13.65pt
  \noindent{\heiti\tjfontbody
    \textbf{Key words: }#2
  }
  \par
}

% ==========================================
% Configuration Input
% ==========================================

% 设置全角句号替换为全角点号
% Enable fullwidthstop replacement if the option is set to true
\makeatletter
\iftongjithesis@fullwidthstop
  \catcode`\。=\active
  \newcommand{。}{\ifmmode\text{．}\else ．\fi}
\fi
\makeatother

% 加载用户配置文件
% cfg is found via TEXINPUTS: locally via .latexmkrc (./style//), or alongside cls on CTAN/texmf.
\AtEndOfPackage{
  \InputIfFileExists{tongjithesis.cfg}{}{}
}
