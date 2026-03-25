%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tongjithesis -- Tongji University Undergraduate Thesis Template
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tongjithesis}[2026/03/07 v1.1.1 Tongji University Undergraduate Thesis Class]

%% tongji-undergrad-thesis
%% Copyright 2023-2026 TJ-CSCCG
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.
%
% This work has the LPPL maintenance status "maintained".
%
% This Current Maintainer of this work is R. Lin.
%
% This work consists of all the *.tex, *.cls, *.cfg, and *.sty files in
%   https://github.com/TJ-CSCCG/tongji-undergrad-thesis

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

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessKeyvalOptions*

% ==========================================
% Class Loading
% ==========================================
% 加载 ctexart 类，有关该类简单说明，see https://www.overleaf.com/learn/latex/Chinese
% 该类提供包括但不限于 \heiti \zihao 等指令
\LoadClass[UTF8,a4paper]{ctexart}

% ==========================================
% Required Packages
% ==========================================
% Page layout
\setlength{\headheight}{43pt}
\RequirePackage[a4paper,top=4.2cm,bottom=2.7cm,left=3.3cm,right=1.8cm]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{eso-pic}

% Typography and text formatting
\RequirePackage[T1]{fontenc}
\RequirePackage{setspace}
\RequirePackage[inline]{enumitem}
\RequirePackage{circledsteps}
\RequirePackage{ulem}
\RequirePackage{calc}
\RequirePackage{etoolbox}
\RequirePackage{hologo}
\RequirePackage[super,negative]{nth}
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
\RequirePackage{dcolumn}
\RequirePackage{longtable}
\RequirePackage{threeparttable}
\RequirePackage{threeparttablex}
\RequirePackage{subcaption}
\RequirePackage{cases}
\RequirePackage{extarrows}

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
  rulecolor=\color{bg},
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
  \RequirePackage[section]{minted}
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
  \newenvironment{listing}[1][]{%
    \begin{figure}[#1]%
  }{%
    \end{figure}%
  }
  
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
\iftongjithesis@minted
  \newenvironment{longlisting}{\captionsetup{type=listing}}{\medskip}
\else
  \newenvironment{longlisting}{\captionsetup{type=lstlisting}}{\medskip}
\fi
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

% \makereferences — output bibliography section
\iftongjithesis@biblatex
  \newcommand{\makereferences}{%
    \printbibliography[heading=bibintoc,title=参考文献]%
  }
\else
  \newcommand{\makereferences}{%
    \addcontentsline{toc}{section}{参考文献}%
    \bibliography{\tj@bibfiles}%
  }
\fi
\makeatother

% ==========================================
% General Configurations
% ==========================================

% Line spacing
\setstretch{1.5}  % 设置全文行距为 1.5

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
  \sbox{\tjbindpipe}{\makebox[\bindwidth][c]{$|$}}%
  \sbox{\tjbindZ}{\makebox[\bindwidth][c]{装}}%
  \sbox{\tjbindD}{\makebox[\bindwidth][c]{订}}%
  \sbox{\tjbindX}{\makebox[\bindwidth][c]{线}}%
}

% Flag to suppress binding line on cover page
\makeatletter
\newif\iftjbindingline
\tjbindinglinetrue

% Helper macro: draw binding line column at a given x position
% fancyput reference point is 1in (2.54cm) from page edges.
% x=-0.8cm → 2.54-0.8 = 1.74cm from left; y=-N → 27.16-N cm from bottom.
\newcommand{\tj@bindingcolumn}[1]{%
  \put(\LenToUnit{#1},\LenToUnit{22.86cm}){\usebox{\tjbindpipe}}%  y=-4.3
  \put(\LenToUnit{#1},\LenToUnit{22.26cm}){\usebox{\tjbindpipe}}%  y=-4.9
  \put(\LenToUnit{#1},\LenToUnit{21.66cm}){\usebox{\tjbindpipe}}%  y=-5.5
  \put(\LenToUnit{#1},\LenToUnit{21.06cm}){\usebox{\tjbindpipe}}%  y=-6.1
  \put(\LenToUnit{#1},\LenToUnit{20.46cm}){\usebox{\tjbindpipe}}%  y=-6.7
  \put(\LenToUnit{#1},\LenToUnit{19.86cm}){\usebox{\tjbindpipe}}%  y=-7.3
  \put(\LenToUnit{#1},\LenToUnit{19.26cm}){\usebox{\tjbindpipe}}%  y=-7.9
  \put(\LenToUnit{#1},\LenToUnit{18.66cm}){\usebox{\tjbindpipe}}%  y=-8.5
  \put(\LenToUnit{#1},\LenToUnit{18.06cm}){\usebox{\tjbindpipe}}%  y=-9.1
  \put(\LenToUnit{#1},\LenToUnit{17.46cm}){\usebox{\tjbindpipe}}%  y=-9.7
  \put(\LenToUnit{#1},\LenToUnit{16.86cm}){\usebox{\tjbindZ}}%     y=-10.3
  \put(\LenToUnit{#1},\LenToUnit{16.26cm}){\usebox{\tjbindpipe}}%  y=-10.9
  \put(\LenToUnit{#1},\LenToUnit{15.66cm}){\usebox{\tjbindpipe}}%  y=-11.5
  \put(\LenToUnit{#1},\LenToUnit{15.06cm}){\usebox{\tjbindpipe}}%  y=-12.1
  \put(\LenToUnit{#1},\LenToUnit{14.46cm}){\usebox{\tjbindpipe}}%  y=-12.7
  \put(\LenToUnit{#1},\LenToUnit{13.86cm}){\usebox{\tjbindpipe}}%  y=-13.3
  \put(\LenToUnit{#1},\LenToUnit{13.26cm}){\usebox{\tjbindD}}%     y=-13.9
  \put(\LenToUnit{#1},\LenToUnit{12.66cm}){\usebox{\tjbindpipe}}%  y=-14.5
  \put(\LenToUnit{#1},\LenToUnit{12.06cm}){\usebox{\tjbindpipe}}%  y=-15.1
  \put(\LenToUnit{#1},\LenToUnit{11.46cm}){\usebox{\tjbindpipe}}%  y=-15.7
  \put(\LenToUnit{#1},\LenToUnit{10.86cm}){\usebox{\tjbindpipe}}%  y=-16.3
  \put(\LenToUnit{#1},\LenToUnit{10.26cm}){\usebox{\tjbindpipe}}%  y=-16.9
  \put(\LenToUnit{#1},\LenToUnit{9.66cm}){\usebox{\tjbindX}}%      y=-17.5
  \put(\LenToUnit{#1},\LenToUnit{9.06cm}){\usebox{\tjbindpipe}}%   y=-18.1
  \put(\LenToUnit{#1},\LenToUnit{8.46cm}){\usebox{\tjbindpipe}}%   y=-18.7
  \put(\LenToUnit{#1},\LenToUnit{7.86cm}){\usebox{\tjbindpipe}}%   y=-19.3
  \put(\LenToUnit{#1},\LenToUnit{7.26cm}){\usebox{\tjbindpipe}}%   y=-19.9
  \put(\LenToUnit{#1},\LenToUnit{6.66cm}){\usebox{\tjbindpipe}}%   y=-20.5
  \put(\LenToUnit{#1},\LenToUnit{6.06cm}){\usebox{\tjbindpipe}}%   y=-21.1
  \put(\LenToUnit{#1},\LenToUnit{5.46cm}){\usebox{\tjbindpipe}}%   y=-21.7
  \put(\LenToUnit{#1},\LenToUnit{4.86cm}){\usebox{\tjbindpipe}}%   y=-22.3
  \put(\LenToUnit{#1},\LenToUnit{4.26cm}){\usebox{\tjbindpipe}}%   y=-22.9
  \put(\LenToUnit{#1},\LenToUnit{3.66cm}){\usebox{\tjbindpipe}}%   y=-23.5
}

% Twoside even page: binding on right side at 21 - 1.74 = 19.26cm
\@ifclasswith{tongjithesis}{twoside}{%
  \AddToShipoutPictureBG{%
    \iftjbindingline
      \AtPageLowerLeft{%
        \ifodd\value{page}%
          \tj@bindingcolumn{1.74cm}%
        \else
          \tj@bindingcolumn{19.26cm}%
        \fi
      }%
    \fi
  }%
}{%
  \AddToShipoutPictureBG{%
    \iftjbindingline
      \AtPageLowerLeft{%
        \tj@bindingcolumn{1.74cm}%
      }%
    \fi
  }%
}
\makeatother

% 设置摘要与目录页样式（如页眉、页脚等）
\fancypagestyle{firststyle}{
	\fancyhf{}
	\pagenumbering{Roman}                    	% 页数使用罗马数字
	\fancyhead[LO,RE]{~ \includegraphics[height=1.14cm]{figures/tongji.pdf}~}   %页眉左侧插入同济大学logo
	\fancyhead[RO,LE]{\large ~毕业设计（论文）~\\}
	\fancyfoot[C]{\large \thepage}
	\renewcommand{\headrulewidth}{1.8pt}     	% 页眉横线
	\renewcommand{\footrulewidth}{0pt}
}

% 设置正文页样式（如页眉、页脚等）
\fancypagestyle{mainstyle}{
	\fancyhf{}
	\pagenumbering{arabic}
	\fancyhead[LO,RE]{~ \includegraphics[height=1.14cm]{figures/tongji.pdf}~}   %页眉左侧插入同济大学logo
	\fancyhead[RO,LE]{\large ~毕业设计（论文）~\\}
	\fancyfoot[RO]{{\large 共\quad \pageref{LastPage}\quad 页\quad 第\quad \thepage \quad 页}}
	\fancyfoot[LE]{{\large 第\quad \thepage \quad 页\quad 共\quad \pageref{LastPage}\quad 页}}
	\renewcommand{\headrulewidth}{1.8pt}     	% 页眉横线
	\renewcommand{\footrulewidth}{1.8pt}     	% 页脚横线
}

% ==========================================
% Typography and Font Settings
% ==========================================

% 表格内所有字体均为小五：\zihao{-5}
\AtBeginEnvironment{table}{\zihao{-5}}
\AtBeginEnvironment{tabular}{\zihao{-5}}
\AtBeginEnvironment{tabularx}{\zihao{-5}}
\AtBeginEnvironment{longtable}{\zihao{-5}}
\AtBeginEnvironment{tablenotes}{\zihao{-5}}

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
\setlength{\cftsecindent}{0em} % 符合毕业设计模板（理工类）一级标题顶格要求
\setlength{\cftsubsecindent}{1em} % 符合毕业设计模板（理工类）二级标题对齐一级标题文字要求
\setlength{\cftsubsubsecindent}{4em} % 符合毕业设计模板（理工类）三级标题对齐一级标题第四字要求
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}
\setlength{\cftbeforesubsubsecskip}{0pt}
\renewcommand{\contentsname}{\zihao{4}\heiti\textmd{目~~录}}
\renewcommand{\cftsecfont}{\songti\zihao{5}}
\renewcommand{\cftsubsecfont}{\songti\zihao{5}}
\renewcommand{\cftsubsubsecfont}{\songti\zihao{5}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftsecdotsep}}
\renewcommand{\cftsecdotsep}{\cftdotsep}
\renewcommand{\cftsecpagefont}{\zihao{5}}
\renewcommand{\cftsubsecpagefont}{\zihao{5}}
\renewcommand{\cftsubsubsecpagefont}{\zihao{5}}

% ==========================================
% Section/Chapter Numbering
% ==========================================

% 设置图表编号和章节相关联
\RequirePackage{chngcntr}
\counterwithin{figure}{section}
\counterwithin{table}{section}
\AtBeginDocument{\counterwithin{lstlisting}{section}}
% \counterwithin{listing}{section}
\counterwithin{equation}{section}
\counterwithin{algorithm}{section}

% 设置正文页内章节标题格式
\ctexset{
	section={% 一级标题
	  format={\centering\heiti\zihao{4}}, % 格式：四号黑体居中
	  aftername={\quad}, % 序号与题名间空 4 格
	  beforeskip={.5\baselineskip}, % 段前 0.5 行
	  afterskip={.5\baselineskip}, % 段后 0.5 行
	 },
	subsection={% 二级标题
			format={\heiti\zihao{5}}, % 格式：五号黑体
			aftername={\space}, % 序号与题名间空 1 格
			beforeskip={.5\baselineskip}, % 段前 0.5 行
			afterskip={.5\baselineskip}, % 段后 0.5 行
		},
	subsubsection={% 三级标题
			format={\heiti\zihao{5}}, % 格式：五号黑体
			aftername={\space}, % 序号与题名间空 1 格
			beforeskip={.5\baselineskip}, % 段前 0.5 行
			afterskip={.5\baselineskip}, % 段后 0.5 行
			indent={2em}, % 缩进 2 个汉字符
		},
	paragraph={% 四级标题
			format={\heiti\zihao{5}}, % 格式：五号黑体
			numbering=true, % 启用编号
			number={\Alph{paragraph}}, % 编号格式：使用大写字母作为四级标题
			aftername={.\space}, % 序号后带点和一个空格
			beforeskip={0pt}, % 段前 0 行
			afterskip={0pt}, % 段后 0 行
			indent={2em}, % 缩进 2 个汉字符
			aftertitle={\par}, % 标题后添加一个空行
		},
	subparagraph={% 五级标题
			format={\heiti\zihao{5}}, % 格式：五号黑体
			numbering=true, % 启用编号
			number={\alph{subparagraph}}, % 编号格式：使用小写字母作为五级标题
			aftername={.\space}, % 序号后带点和一个空格
			beforeskip={0pt}, % 段前 0 行
			afterskip={0pt}, % 段后 0 行
			indent={2em}, % 缩进 2 个汉字符
			aftertitle={\par}, % 标题后添加一个空行
		}
}

\setcounter{secnumdepth}{5}

\makeatletter
\iftongjithesis@minted
  \AtBeginDocument{\let\c@listing\c@figure}
\fi
\AtBeginDocument{\let\c@lstlisting\c@figure}
\makeatother

% ==========================================
% Float Settings
% ==========================================

% 设置浮动体的 caption 位置
\floatstyle{plaintop}       % 表格的 caption 在表格上方，这里仅设置了 table 环境，longtable 环境默认 plaintop
\restylefloat{table}
\floatstyle{plain}
\makeatletter
\iftongjithesis@minted
  \restylefloat{listing}    % listing 环境默认为 ruled，修改为 plain，将 caption 放在下方
\fi
\makeatother
\sloppy

% ==========================================
% Math and Theorem Environments
% ==========================================

\theoremstyle{definition}
\newtheorem{thm}{定理\hspace{0.05pt}}[section]
\newtheorem{cor}{推论\hspace{0.05pt}}[section]
\newtheorem{lem}{引理\hspace{0.05pt}}[section]
\newtheorem{prop}{命题\hspace{0.05pt}}[section]
\newtheorem{conj}{猜想\hspace{0.05pt}}[section]
\newtheorem{assume}{假设\hspace{0.05pt}}[section]
\newtheorem{dfn}{定义\hspace{0.05pt}}[section]
\newtheorem{exmp}{例\hspace{0.05pt}}[section]
\newtheorem{rem}{注\hspace{0.05pt}}[section]
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
\newcommand*{\secref}[1]{第~\ref{#1}~节}
\newcommand*{\algoref}[1]{算法~\ref{#1}~}
\renewcommand*{\eqref}[1]{公式（\ref{#1}）}
\newcommand*{\tabref}[1]{\tablename~\ref{#1}~}
\newcommand*{\figref}[1]{\figurename~\ref{#1}~}

% Counter and cross-reference setup for code listings
\makeatletter
\iftongjithesis@minted
  % For minted package
  \crefname{listing}{代码}{代码}
  \Crefname{listing}{代码}{代码}
\fi
\makeatother

% For listings package
\crefname{lstlisting}{代码}{代码}
\Crefname{lstlisting}{代码}{代码}
\newcommand*{\listingref}[1]{\lstlistingname~\ref{#1}}

% Configure references in Chinese
\crefname{equation}{式}{式}
\crefname{figure}{图}{图}
\crefname{table}{表}{表}
\crefname{section}{章节}{章节}
\crefname{subsection}{小节}{小节}
\crefname{subsubsection}{子小节}{子小节}
\crefname{paragraph}{段落}{段落}
\crefname{subparagraph}{子段落}{子段落}
\crefname{FancyVerbLine}{行}{行}
\crefname{theorem}{定理}{定理}
\crefname{thm}{定理}{定理}
\crefname{cor}{推论}{推论}
\crefname{lem}{引理}{引理}
\crefname{prop}{命题}{命题}
\crefname{conj}{猜想}{猜想}
\crefname{assume}{假设}{假设}
\crefname{dfn}{定义}{定义}
\crefname{exmp}{例}{例}
\crefname{rem}{注}{注}
\crefname{pf}{证明}{证明}
\crefname{proof}{证明}{证明}
\crefname{algorithm}{算法}{算法}

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
\newcommand{\MakeCover}[0]{
	\begin{titlepage}
		\begin{center}
			\global\tjbindinglinefalse
			\vspace*{\fill}

			\includegraphics[height=2.25cm]{figures/tongji.pdf}

			\zihao{-2}\MakeUppercase{\textbf{\tongjiuniversityeng}}
			\vskip 30pt

			% 符合毕业设计模板（理工类），标题使用黑体小初
			\zihao{-0}\heiti{本科毕业设计（论文）}
			\vskip 60pt

			% 符合毕业设计模板（理工类），此处使用黑体小二
			\begin{information}{M{5em}M{22em}}
				\zihao{-2}\heiti{课题名称} & \ulinecentered{\tongjithesistitle} \\
				\zihao{-2}\heiti{副\enskip{}标\enskip{}题} & \ulinecentered{\tongjithesissubtitle} \\
				\zihao{-2}\heiti{学\quad{}\quad{}院} & \ulinecentered{\tongjischool} \\
				\zihao{-2}\heiti{专\quad{}\quad{}业} & \ulinecentered{\tongjimajor} \\
				\zihao{-2}\heiti{学生姓名} & \ulinecentered{\tongjiauthor} \\
				\zihao{-2}\heiti{学\quad{}\quad{}号} & \ulinecentered{\tongjiauthornumber} \\
				\zihao{-2}\heiti{指导教师} & \ulinecentered{\tongjithesisadvisor} \\
				\zihao{-2}\heiti{日\quad{}\quad{}期} & \ulinecentered{\tongjithesisyear{}年\tongjithesismonth{}月\tongjithesisday{}日} \\
			\end{information}

			\vspace*{\fill}
		\end{center}
	\end{titlepage}
	\global\tjbindinglinetrue
}

% 设置中文摘要页
\newcommand{\MakeAbstract}[2]{
	\begin{center}\bf\heiti\zihao{-2}
		\ \\
		\tongjithesistitle
	\end{center}
	\vspace{1pt}
	\begin{center}\heiti\zihao{4}
		摘要
	\end{center}
	\vspace{-0.5em}

	\begin{spacing}{1.5}
		\heiti\songti{#1}
		\par
	\end{spacing}

	\vskip 5mm
	\noindent{\songti\zihao{5}{%
			\textbf{关键词：}#2
		}}~\\
}

% 设置英文摘要页
\newcommand{\MakeAbstractEng}[2]{
	\clearpage
	\begin{center}\heiti\zihao{-2}
		\ \\
		\textbf{\tongjithesistitleeng}
	\end{center}
	\vspace{1pt}
	\begin{center}\heiti\zihao{4}
		\textbf{ABSTRACT}
	\end{center}
	\vspace{-0.5em}

	\begin{spacing}{1.5}
		#1
		\par
	\end{spacing}

	\vskip 13.65pt % 小五字体单倍行距 13.65pt
	\noindent{\heiti\zihao{5}
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
\AtEndOfPackage{
	\InputIfFileExists{tongjithesis.cfg}{}{}
}
