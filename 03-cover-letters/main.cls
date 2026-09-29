% Deedy Cover Letter - Unified Class
% Supports font option: [openfont] or [macfont]
% Version 2.0 (2026)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{main}[2026/05/26 CV class]

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption{openfont}{\def\@cv@openfont{}}
\DeclareOption{macfont}{\def\@cv@macfont{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% Package Imports
\usepackage[hmargin=2.54cm, vmargin=2.54cm]{geometry}
\usepackage[hidelinks]{hyperref}
\usepackage[dvipsnames]{xcolor}
\usepackage{titlesec}
\usepackage{textpos}
\usepackage[UKenglish]{isodate}
\usepackage{fontspec}
\usepackage{marvosym}

% Publications
\usepackage{cite}
\renewcommand\refname{\vskip -1.5cm}

% Color definitions
\definecolor{date}{HTML}{666666}
\definecolor{primary}{HTML}{2b2b2b}
\definecolor{headings}{HTML}{6A6A6A}
\definecolor{subheadings}{HTML}{333333}

% Set main fonts based on option
\ifdefined\@cv@openfont
\setmainfont[Color=primary, Path = ../../assets/fonts/lato/, BoldItalicFont=Lato-RegIta, BoldFont=Lato-Reg, ItalicFont=Lato-LigIta]{Lato-Lig}
\setsansfont[Scale=MatchLowercase, Mapping=tex-text, Path = ../../assets/fonts/raleway/]{Raleway-ExtraLight}
\else
\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Color=primary]{Helvetica Light}
\setsansfont[Scale=MatchLowercase, Mapping=tex-text]{Helvetica Neue UltraLight}
\fi

% Date command
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\newcommand{\lastupdated}{%
  \begin{textblock}{60}(155,5)
    \color{date}\fontsize{8pt}{10pt}\selectfont
    Last Updated on \today
  \end{textblock}%
}

% Name command
\newcommand{\namesection}[3]{%
  \centering{%
    \fontsize{40pt}{60pt}%
    \ifdefined\@cv@openfont
    \fontspec[Path = ../../assets/fonts/lato/]{Lato-Bol}\selectfont #1
    \fontspec[Path = ../../assets/fonts/lato/]{Lato-Lig}\selectfont #2
    \else
    \fontspec{Helvetica Neue Bold}\selectfont #1
    \fontspec{Helvetica Neue Light}\selectfont #2
    \fi
  } \\[5pt]
  \centering{%
    \color{headings}%
    \ifdefined\@cv@openfont
    \fontspec[Path = ../../assets/fonts/raleway/]{Raleway-Medium}\fontsize{11pt}{14pt}\selectfont #3%
    \else
    \fontspec{Heiti TC Medium}\fontsize{11pt}{14pt}\selectfont #3%
    \fi
  }%
  \noindent\makebox[\linewidth]{\color{headings}\rule{\paperwidth}{0.4pt}}%
  \vspace{0pt}
}

% Section separators
\titlespacing{\section}{0pt}{0pt}{0pt}
\titlespacing{\subsection}{0pt}{\parskip}{-\parskip}
\newcommand{\sectionsep}{\vspace{8pt}}

% Headings command
\titleformat{\section}{\color{headings}
\scshape\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/lato/]{Lato-Lig}\else\fontspec{Helvetica Light}\fi\fontsize{16pt}{24pt}\selectfont \raggedright\uppercase}{}{0em}{}

% Subeadings command
\titleformat{\subsection}{%
\color{subheadings}\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/lato/]{Lato-Bol}\else\fontspec{Helvetica}\fi\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase}{}{0em}{}

\newcommand{\runsubsection}[1]{%
\color{subheadings}\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/lato/]{Lato-Bol}\else\fontspec{Helvetica}\fi\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase {#1}\normalfont}

% Descriptors command
\newcommand{\descript}[1]{%
\color{subheadings}\raggedright\scshape\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/raleway/]{Raleway-Medium}\else\fontspec{Heiti SC Medium}\fi\fontsize{11pt}{13pt}\selectfont {#1 \\} \normalfont}

% Location command
\newcommand{\location}[1]{%
\color{headings}\raggedright\scshape\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/raleway/]{Raleway-Medium}\else\fontspec{Heiti TC Medium}\fi\fontsize{10pt}{12pt}\selectfont {#1\\} \normalfont}

% Bullet Lists with fewer gaps command
\newenvironment{tightemize}{%
  \vspace{-\topsep}
\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt
    }{
\end{itemize}\vspace{-\topsep}}

% Cover Letter commands
\newcommand{\companyname}[1]{%
\raggedright\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/lato/]{Lato-Bol}\else\fontspec{Calibri Bold}\fi\fontsize{12pt}{14pt}\selectfont {#1 \\} \normalfont}

\newcommand{\companyaddress}[1]{%
\raggedright\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/raleway/]{Raleway-Medium}\else\fontspec{Calibri}\fi\fontsize{11pt}{13pt}\selectfont {#1 \\}\mbox{}\\\mbox{}\\ \normalfont}

\newcommand{\currentdate}[1]{%
\raggedleft\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/raleway/]{Raleway-Medium}\else\fontspec{Calibri}\fi\fontsize{11pt}{13pt}\selectfont {#1 \\} \normalfont}

% Letter content command
\newcommand{\lettercontent}[1]{%
\raggedright\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/raleway/, LetterSpace=1.5]{Raleway-Medium}\else\fontspec{Calibri}\fi\fontsize{11pt}{14pt}\selectfont {#1 \\}\mbox{}\\ \normalfont}

\newcommand{\closing}[1]{%
\raggedright\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/raleway/, LetterSpace=1.5]{Raleway-Medium}\else\fontspec{Calibri}\fi\fontsize{11pt}{14pt}\selectfont {#1 \\}\mbox{}\\\mbox{}\\ \normalfont}

\newcommand{\signature}[1]{%
\raggedright\ifdefined\@cv@openfont\fontspec[Path = ../../assets/fonts/raleway/, LetterSpace=1.5]{Raleway-Medium}\else\fontspec{Calibri}\fi\fontsize{11pt}{14pt}\selectfont {#1 \\} \normalfont}
