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


% 设置页边距
\setlength{\headheight}{43pt}
\RequirePackage[a4paper,top=4.2cm,bottom=2.7cm,left=3.3cm,right=1.8cm]{geometry}


% 重新定义 \cleardoublepage 命令
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{
	\clearpage
	{\pagestyle{empty}\origdoublepage}
}
\let\cleardoublepage\clearemptydoublepage


% 画边界线
\RequirePackage{fancybox}

\makeatletter
\@ifclasswith{tongjithesis}{twoside}{%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-4.3cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-4.9cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-5.5cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-6.1cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-6.7cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-7.3cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-7.9cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-8.5cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-9.1cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-9.7cm){$|$}%
\fancyput*(\ifodd\value{page} -1.0cm\else 16.5cm\fi,-10.3cm){装}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-10.9cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-11.5cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-12.1cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-12.7cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-13.3cm){$|$}%
\fancyput*(\ifodd\value{page} -1.0cm\else 16.5cm\fi,-13.9cm){订}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-14.5cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-15.1cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-15.7cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-16.3cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-16.9cm){$|$}%
\fancyput*(\ifodd\value{page} -1.0cm\else 16.5cm\fi,-17.5cm){线}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-18.1cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-18.7cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-19.3cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-19.9cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-20.5cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-21.1cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-21.7cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-22.3cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-22.9cm){$|$}%
\fancyput*(\ifodd\value{page} -0.8cm\else 16.7cm\fi,-23.5cm){$|$}%
}{%
\fancyput*(-0.8cm,-4.3cm){$|$}%
\fancyput*(-0.8cm,-4.9cm){$|$}%
\fancyput*(-0.8cm,-5.5cm){$|$}%
\fancyput*(-0.8cm,-6.1cm){$|$}%
\fancyput*(-0.8cm,-6.7cm){$|$}%
\fancyput*(-0.8cm,-7.3cm){$|$}%
\fancyput*(-0.8cm,-7.9cm){$|$}%
\fancyput*(-0.8cm,-8.5cm){$|$}%
\fancyput*(-0.8cm,-9.1cm){$|$}%
\fancyput*(-0.8cm,-9.7cm){$|$}%
\fancyput*(-1.0cm,-10.3cm){装}%
\fancyput*(-0.8cm,-10.9cm){$|$}%
\fancyput*(-0.8cm,-11.5cm){$|$}%
\fancyput*(-0.8cm,-12.1cm){$|$}%
\fancyput*(-0.8cm,-12.7cm){$|$}%
\fancyput*(-0.8cm,-13.3cm){$|$}%
\fancyput*(-1.0cm,-13.9cm){订}%
\fancyput*(-0.8cm,-14.5cm){$|$}%
\fancyput*(-0.8cm,-15.1cm){$|$}%
\fancyput*(-0.8cm,-15.7cm){$|$}%
\fancyput*(-0.8cm,-16.3cm){$|$}%
\fancyput*(-0.8cm,-16.9cm){$|$}%
\fancyput*(-1.0cm,-17.5cm){线}%
\fancyput*(-0.8cm,-18.1cm){$|$}%
\fancyput*(-0.8cm,-18.7cm){$|$}%
\fancyput*(-0.8cm,-19.3cm){$|$}%
\fancyput*(-0.8cm,-19.9cm){$|$}%
\fancyput*(-0.8cm,-20.5cm){$|$}%
\fancyput*(-0.8cm,-21.1cm){$|$}%
\fancyput*(-0.8cm,-21.7cm){$|$}%
\fancyput*(-0.8cm,-22.3cm){$|$}%
\fancyput*(-0.8cm,-22.9cm){$|$}%
\fancyput*(-0.8cm,-23.5cm){$|$}%
}
\makeatother

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


% 设置摘要与目录页样式（如页眉、页脚等）
\RequirePackage{fancyhdr}
\fancypagestyle{firststyle}{
	\fancyhf{}
	\pagenumbering{Roman}                    	% 页数使用罗马数字
\fancyhead[LO,RE]{\qquad \includegraphics[height=1.14cm]{figures/tongji.pdf}}   %页眉左侧插入同济大学logo
\fancyhead[RO,LE]{\large 毕业设计（论文）~\\}
	\fancyfoot[C]{\large \thepage}
	\renewcommand{\headrulewidth}{1.8pt}     	% 页眉横线
	\renewcommand{\footrulewidth}{0pt}
}


% 设置正文页样式（如页眉、页脚等）
\RequirePackage{lastpage}						% 标定最后一页，提供 LastPage
\fancypagestyle{mainstyle}{
	\fancyhf{}
	\pagenumbering{arabic}
\fancyhead[LO,RE]{\qquad \includegraphics[height=1.14cm]{figures/tongji.pdf}}   %页眉左侧插入同济大学logo
\fancyhead[RO,LE]{\large 毕业设计（论文）~\\}
\fancyfoot[RO]{{\large 共\quad \pageref{LastPage}\quad 页\quad 第\quad \thepage \quad 页}}
\fancyfoot[LE]{{\large 第\quad \thepage \quad 页\quad 共\quad \pageref{LastPage}\quad 页}}
	\renewcommand{\headrulewidth}{1.8pt}     	% 页眉横线
	\renewcommand{\footrulewidth}{1.8pt}     	% 页脚横线
}


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

% 设置参考文献格式
\RequirePackage[backend=biber,style=gb7714-2015]{biblatex}
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
			\thisfancyput(-0.75cm,-13cm){}
			\vspace*{\fill}

			\includegraphics[height=2.25cm]{figures/tongji.pdf}

			\zihao{-2}\MakeUppercase{\textbf{\tongjiuniversityeng}}
			\vskip 30pt

			% 符合毕业设计模板（理工类），标题使用黑体小初
			\zihao{-0}\heiti{毕业设计（论文）}
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
}


% 设置中文摘要页
\newcommand{\MakeAbstract}[2]{
	\begin{center}\bf\heiti\xiaoer
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
	\noindent{\songti\zihao{5}{
			\textbf{关键词：}#2
		}}~\\
}


% 设置英文摘要页
\newcommand{\MakeAbstractEng}[2]{
	\newpage
	\begin{center}\heiti\xiaoer
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
		\textbf{Key words:\quad}#2
	}
	\par
}
