%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tongjithesis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tongjithesis}[2022/05/16 Tongji Thesis Class]


% 加载 ctexart 类，有关该类简单说明，see https://www.overleaf.com/learn/latex/Chinese
% 该类提供包括但不限于 \heiti \zihao 等指令
\LoadClass[UTF8,a4paper,fontset=fandol]{ctexart}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \LoadClass[UTF8,a4paper,fontset=adobe]{ctexart}
% 若需要使用包含所有 GBK 字符的 Adobe 字体，可使用如上命令
% 需要完成 README.md 中提到的字体安装步骤
% Overleaf 上使用该命令时编译速度会变慢很多，建议本地编译
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 若你想要用句点（．）替换句号（。）
% 可以打开下面的注释
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \catcode`\。=\active
% \newcommand{。}{\ifmmode\text{．}\else ．\fi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 在 Windows 上使用时：
% 若你想避免将 Python 加入环境变量，可以在此手动指定 Python 环境
% 打开下面的注释，并替换尖括号 <> 中的路径
% e.g. {<X:/your/path/to/python>/python.exe} -> {C:/software/Anaconda3/envs/latex/python.exe}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \newcommand{\myPython}{<X:/your/path/to/python>/python.exe}
% \renewcommand{\MintedPygmentize}{\myPython\space -m pygments}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 设置页边距
\setlength{\headheight}{43pt}
\RequirePackage[a4paper,top=2.3cm,bottom=1cm,left=3.17cm,right=3.17cm]{geometry}


% 重新定义 \cleardoublepage 命令
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{
	\clearpage
	{\pagestyle{empty}\origdoublepage}
}
\let\cleardoublepage\clearemptydoublepage


% 画边界线
\RequirePackage{fancybox}

% 设置有序列表与无序列表格式
\RequirePackage{enumerate} % 下面用到了 enumerate
\RequirePackage{enumitem}
\setlist[itemize]{labelindent=2em,leftmargin=*,itemsep=0pt,parsep=0pt}
\setlist[enumerate]{labelindent=2em,leftmargin=*,itemsep=0pt,parsep=0pt}


% 设置目录格式
\RequirePackage[titles,subfigure]{tocloft}
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
\setlength{\cftbeforesecskip}{0pt}  % 5?
\setlength{\cftbeforesubsecskip}{0pt}  % 3?
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


% 设置图表编号和章节相关联
% see https://tex.stackexchange.com/questions/28333/continuous-v-per-chapter-section-numbering-of-figures-tables-and-other-docume
\RequirePackage{chngcntr}
\counterwithin{figure}{section}
\counterwithin{table}{section}


% 设置浮动体的 caption 位置
\RequirePackage{float}
\floatstyle{plaintop}       % 表格的 caption 在表格上方，这里仅设置了 table 环境，longtable 环境默认 plaintop
\restylefloat{table}
\RequirePackage{algorithm}	% 引入 listing
\floatstyle{plain}
\restylefloat{listing}      % listing 环境默认为 ruled，修改为 plain，将 caption 放在下方
\sloppy


% 有关字体的设置
% 五号 = 10.5 pt
% 小四 = 12.0 pt
% 四号 = 14.0 pt
% 字号对应单倍行距大小 = 字号磅数 * 1.3（如小四对应单倍行距为 15.6 pt）
% 提供 spacing 环境以灵活改变环境内行间距，同时提供一系列有关 space 的指令
% see https://github.com/rf-latex/setspace/blob/main/setspace.sty
\RequirePackage{setspace}
\setstretch{1.5}                                % 设置全文行距为 1.5
\RequirePackage[T1]{fontenc}					% 使得 ctexart 可对英文加粗
\newcommand{\xiaoer}{\fontsize{18pt}{18pt}\selectfont}
% 表格内所有字体均为小五：\zihao{-5}
% AtBeginEnvironment 在 etoolbox 里
\RequirePackage{etoolbox}
\AtBeginEnvironment{table}{\zihao{-5}}
\AtBeginEnvironment{tabular}{\zihao{-5}}
\AtBeginEnvironment{tabularx}{\zihao{-5}}


% 设置正文页内章节标题格式
\ctexset{
	section={% 一级标题
	  format={\heiti\zihao{4}}, % 格式：四号黑体居中
	  aftername={{、}\space}, % 序号与题名间空 4 格
	  number= {\chinese{section}},
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

% 设置参考文献格式
\RequirePackage[
	backend=biber,
	style=gb7714-2015,
	natbib=true,
]{biblatex}
\addbibresource{bib/note.bib}

\makeatletter
\AtBeginDocument{\let\c@listing\c@figure}
\makeatother


% 设置封面信息盒子（information 环境）
\RequirePackage{array}
\newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}}
\let\oldtabular\tabular
\let\endoldtabular\endtabular
\newenvironment{information}[1][h!]{
	\renewcommand{\arraystretch}{1.5}
	\setlength{\tabcolsep}{8pt}
	\zihao{-3}\oldtabular[#1]
}{\renewcommand{\arraystretch}{1.2}\endoldtabular
}
\RequirePackage{ulem}
\newcommand{\ulinecentered}[1]{\uline{\makebox[20em][c]{#1}}}
\newcommand{\ulinecenteredwidth}[2]{\uline{\makebox[#2][c]{#1}}}


% 加载包部分结束，此后开始定义内容 Layout
\AtEndOfPackage{
	\InputIfFileExists{style/tongjithesis.cfg}{}{}
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

			\vspace*{60pt}

			\includegraphics[height=1.7cm]{figures/tongji.pdf}

			\vspace{-20pt}
			\zihao{-0}\heiti{毕业设计(论文)开题报告}

			\vspace{10pt}
			\zihao{3}\heiti{（适用于工科类、理科类专业）}

			\vspace{80pt}
			% 符合毕业设计模板（理工类），此处使用黑体小二
			\begin{information}{M{5em}M{8em}M{5em}M{5em}}
				\zihao{-2}\heiti{课题名称} & \multicolumn{3}{l}{\ulinecentered{\tongjithesistitle}} \\
				\zihao{-2}\heiti{副\enskip{}标\enskip{}题} & \multicolumn{3}{l}{\ulinecentered{\tongjithesissubtitle}} \\
				\zihao{-2}\heiti{学\quad{}\quad{}院} & \multicolumn{3}{l}{\ulinecentered{\tongjischool}} \\
				\zihao{-2}\heiti{专\quad{}\quad{}业} & \multicolumn{3}{l}{\ulinecentered{\tongjimajor}} \\
				\zihao{-2}\heiti{学生姓名} & \ulinecenteredwidth{\tongjiauthor}{8em} & \zihao{-2}\heiti{学\quad{}\quad{}号} & \ulinecenteredwidth{\tongjiauthornumber}{5em} \\
			\end{information}

			\vfill
			\begin{information}{cccccc}
				 \ulinecenteredwidth{\tongjithesisyear{}}{3em} & 年 & \ulinecenteredwidth{\tongjithesismonth{}}{2em} & 月 & \ulinecenteredwidth{\tongjithesisday{}}{2em} &日 
			\end{information}

			\vspace{60pt}

		\end{center}
	\end{titlepage}
}