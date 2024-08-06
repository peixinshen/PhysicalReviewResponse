\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reviewresponse}[2024/06/08 v1.0 class for writing rebuttal letters for Physical Review Journals]
% Original Author: Karl-Ludwig Besser
% Email: karl.besser@princeton.edu
% Modified by: Pei-Xin Shen
% Email: peixin.shen@outlook.com
% This work is a modification of the original reviewresponse template (https://github.com/klb2/review-response-template).

\RequirePackage{kvoptions}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass{scrartcl}


\RequirePackage[breakable,skins]{tcolorbox}
\RequirePackage{xcolor}


\newcommand*{\journal}[1]{\renewcommand*{\@journal}{#1}}
\newcommand*{\@journal}{}
\newcommand*{\editorname}[1]{\renewcommand*{\@editorname}{#1}}
\newcommand*{\@editorname}{}
\newcommand*{\manuscript}[1]{\renewcommand*{\@manuscript}{#1}}
\newcommand*{\@manuscript}{}
\newcommand*{\firstauthor}[1]{\renewcommand*{\@firstauthor}{#1}}
\newcommand*{\@firstauthor}{}

\newcommand*{\thetitle}{\@title}
\newcommand*{\theauthor}{\@author}
\newcommand*{\thefirstauthor}{\@firstauthor}
\newcommand*{\thedate}{\@date}
\newcommand*{\thejournal}{\@journal}
\newcommand*{\theeditor}{\@editorname}
\newcommand*{\themanuscript}{\@manuscript}

%%% Colors
\definecolor{colorcommentfg}{RGB}{0,63,87}
\definecolor{colorcommentbg}{HTML}{e0f0f6}
\definecolor{colorcommentframe}{RGB}{0,112,155}

\colorlet{colorchangebg}{black!2}
\colorlet{colorchangeframe}{black!20}
%%%


%%% General Settings
\setlength{\parindent}{0pt}
\setlength{\parskip}{.3em plus .2em minus .3em}
\renewcommand{\baselinestretch}{1.5}

\widowpenalty10000
\clubpenalty10000
%%%

%%% Counters
\newcounter{referee}
\setcounter{referee}{0}
\renewcommand\thereferee{\Alph{referee}}
\newcounter{revcomment}[referee]
\setcounter{revcomment}{0}
\renewcommand\therevcomment{\Alph{referee}\arabic{revcomment}}
\newcounter{revresponse}[referee]
\setcounter{revresponse}{0}
\renewcommand\therevresponse{\Alph{referee}\arabic{revresponse}}
%%%

%%% Commands
\renewcommand*{\maketitle}{%
	\begin{titlepage}
		\begin{center}
			\vspace*{1cm}
			\large{Responses to Referees' Comments for Manuscript {\@manuscript} {\@firstauthor}}\\
			
			\vspace{1cm}
			\textbf{\LARGE{\@title}}\\
			\vspace{1cm}
			\large{Addressed Comments for Publication in}
			
			\Large{\@journal}
			
			\large{by}
			
			{\large{\@author}}

			{\large{\@date}}
		\end{center}
	\end{titlepage}
}

\newcommand*{\change}{
	\clearpage
	\@ifundefined{pdfbookmark}{}{%
		\pdfbookmark[1]{Summary of Changes}{hyperref@change}%
	}%
	\section*{Summary of Changes}
}

\newcommand*{\referee}{
	\clearpage
	\refstepcounter{referee}%
	\@ifundefined{pdfbookmark}{}{%
		\pdfbookmark[1]{Referee~\Alph{referee}}{hyperref@referee\Alph{referee}}%
	}%
	\section*{Authors' Response to Referee~\Alph{referee}}
	\newrefcontext[labelprefix=\Alph{referee}]
}

\newenvironment{generalcomment}{
	\begin{tcolorbox}[adjusted title={General Comments of Referee~\Alph{referee}}, fonttitle={\bfseries}, colback={colorcommentbg}, colframe={colorcommentframe},coltitle={colorcommentbg}]
	}{\end{tcolorbox}}

\newenvironment{generalresponse}[1][{Thank you for the comment.}]{
	\textbf{Response \Alph{referee}\arabic{revcomment}:} #1\par
	}{\vspace{4em plus 0.2em minus 1.5em}}

\newenvironment{revcomment}[1][]{
	\refstepcounter{revcomment}
	\begin{tcolorbox}[adjusted title={Comment \Alph{referee}\arabic{revcomment}}, fonttitle={\bfseries}, colback={colorcommentbg}, colframe={colorcommentframe},coltitle={colorcommentbg},#1]
	}{\end{tcolorbox}}

\newenvironment{revresponse}[1][{Thank you for the comment.}]{
	\refstepcounter{revresponse}
	\textbf{Response \Alph{referee}\arabic{revcomment}:} #1\par
	}{\vspace{4em plus 0.2em minus 1.5em}}

\newenvironment{changes}{
	\begin{tcolorbox}[breakable,colback={colorchangebg}, colframe={colorchangeframe},enhanced jigsaw]
	}{\end{tcolorbox}}

\newcommand{\printbibliographyreferee}{
	\printbibliography[heading=subbibliography,title={References for Referee \thereferee}]}

\providecommand*{\revcommentautorefname}{Comment}
\providecommand*{\revresponseautorefname}{Response}
\AddToHook{package/hyperref/after}{
	\hypersetup{
		bookmarksopen,
		pdfcreator={LaTeX with the PhysicalReviewResponse package},
	}
}
\AddToHook{begindocument/before}{
	\IfPackageLoadedTF{hyperref}{
		\hypersetup{
			pdfauthor={\@author},
			pdftitle={Response\_\@manuscript\_\@firstauthor},
			pdfsubject={Review Response},
			pdfkeywords={\@journal}
		}
	}{}
}
\AddToHook{begindocument/end}{\def\sectionautorefname{Referee}}