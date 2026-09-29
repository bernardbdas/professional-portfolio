%-------------------------------------------------------
% RESUME CLASS FILE - main.cls
% Custom LaTeX class for Bernard's ATS-friendly resume
%-------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{main}[2025/05/20 Custom class for ATS-friendly resume]

%=========================================================
% 1.  BASE CLASS & ESSENTIAL PACKAGES
%=========================================================

\LoadClass[letterpaper,10pt]{article}

% Font path definitions
\def\pathtitlefont{../assets/fonts/sourcesanspro/}
\def\firstnamefont{SourceSansPro-Light}
\def\secondnamefont{SourceSansPro-SemiBold}
\def\regularfont{SourceSansPro-Regular}

% Page geometry
\RequirePackage[left=0.2in, right=0.2in, top=0.1in, bottom=0.1in]{geometry}

% Core typesetting utilities
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{amsmath}
% \setlist{itemsep=0pt, parsep=0pt, topsep=0pt}

% Section & heading formatting
\RequirePackage{titlesec}

% Colors
\RequirePackage[usenames,dvipsnames]{xcolor}

% Fonts
\RequirePackage{fontspec}
\setmainfont[
  Path = \pathtitlefont,
  BoldFont = \firstnamefont,
  ItalicFont = \secondnamefont,
  BoldItalicFont = SourceSansPro-SemiBoldItalic
]{\regularfont}
\RequirePackage{marvosym}

% Hyperlinks (must come after color)
\RequirePackage[hidelinks,unicode]{hyperref}

% Header / footer layout
\RequirePackage{fancyhdr}

% Language support
\RequirePackage[english]{babel}

% Text highlighting
\RequirePackage{soul}

% Modular document structure
\RequirePackage{subfiles}
\RequirePackage{etoolbox}
\RequirePackage[letterspace=50]{microtype}

%=========================================================
% 2.  PAGE STYLE & LAYOUT
%=========================================================

\pagestyle{fancy}
\fancyhf{}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\setlength{\footskip}{3.60004pt}

\urlstyle{same}
\raggedbottom
\raggedright
\setlength{\tabcolsep}{0in}

%=========================================================
% 3.  COLORS
%=========================================================

\definecolor{title}{HTML}{1D76E2}

%=========================================================
% 4.  SECTION FORMATTING
%=========================================================

\titleformat{\section}
{\vspace{-8pt}\scshape\raggedright\Large\color{title}}
{}{0em}{}[\color{title}\titlerule \vspace{-6pt}]

%=========================================================
% 5.  COLORS (additional)
%=========================================================

\definecolor{lightyellow}{cmyk}{0.00, 0.05, 0.20, 0.00}
\sethlcolor{lightyellow}

%=========================================================
% 6.  CUSTOM COMMANDS
%=========================================================
% Semantic text macros
\newcommand{\pipe}{\hspace{0.3em}|\hspace{0.3em}}
\newcommand{\titleItem}[1]{\textbf{#1}}
\newcommand{\highlight}[1]{\textsl{\textbf{#1}}}

% Vertical rhythm helpers
\newcommand{\sectionspace}{\vspace{-12pt}}
\newcommand{\subheadingtitlevspace}{\vspace{-2pt}}
\newcommand{\contactVspace}{\vspace{-10pt}}
\newcommand{\afterlistvspace}{\vspace{-10pt}}

%---------------------------------
% List item helpers
%---------------------------------

\newcommand{\resumeItem}[1]{
\item{#1 \vspace{-4pt}}}

\newcommand{\resumeSubheading}[4]{%
\item
  \begin{tabular*}{0.97\textwidth}[t]{l@{\extracolsep{\fill}}l@{}l}
    {#1} & \titleItem{#3} | {#2} & \textit{#4}\\
  \end{tabular*}\vspace{-10pt}
}

\newcommand{\resumeSubSubheading}[2]{%
\item
  \begin{tabular*}{0.97\textwidth}{l@{\extracolsep{\fill}}r}
    \textit{#1} & \textit{#2} \\
  \end{tabular*}\vspace{-2pt}
}

\newcommand{\resumeEduHeading}[4]{%
\item
  \begin{tabularx}{0.97\textwidth}{@{}X r@{}}
    \textbf{#1} & \textit{#4} \\
    \textit{#3} $|$ {#2} & \\
  \end{tabularx}\vspace{-10pt}
}

\newcommand{\resumeProjectHeading}[2]{%
\item
  \begin{tabular*}{0.97\textwidth}{l@{\extracolsep{\fill}}r}
    #1 & \textit{ #2} \\
  \end{tabular*}\vspace{-9pt}
}

%---------------------------------
% Environment wrappers
%---------------------------------

\newcommand{\resumeSubHeadingListStart}{
\begin{itemize}[leftmargin=0.15in, label={}]}
    \newcommand{\resumeSubHeadingListEnd}{
\end{itemize}}

\newcommand{\resumeItemListStart}{
\begin{itemize}}
    \newcommand{\resumeItemListEnd}{
\end{itemize}\vspace{-8pt}}
