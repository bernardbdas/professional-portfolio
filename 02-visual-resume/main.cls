% One Page Two Column Resume Class
% Version 2.0
\ProvidesClass{main}[2021/11/30 CV class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% Package Imports
\usepackage[lmargin=0.9cm, vmargin=0.5cm, rmargin=0.9cm]{geometry}
\usepackage[hidelinks]{hyperref}
\usepackage{enumitem}
\usepackage{graphicx}
\usepackage{pifont}
\usepackage{ragged2e}
\usepackage{ifthen}
\usepackage{cite}
\usepackage[dvipsnames]{xcolor}
\usepackage{subfiles}
\usepackage{marvosym}

% Global zero indentation to prevent spacing breaks after lists
\setlength{\parindent}{0pt}

% Color definitions
\definecolor{date}{HTML}{666666}
\definecolor{title}{HTML}{1D76E2}
\definecolor{primary}{HTML}{2b2b2b}
\definecolor{headings}{HTML}{6A6A6A}
\definecolor{subheadings}{HTML}{333333}

% Default font configuration
\def\pathtitlefont{../assets/fonts/sourcesanspro/}
\def\firstnamefont{SourceSansPro-SemiBold}
\def\secondnamefont{SourceSansPro-Light}
\def\titlefont{\firstnamefont}
\def\namefontsize{9.5}

% Define font variants dynamically using etoolbox
\newcommand{\definefontvariant}[4]{%
  \csdef{pathtitlefont#1}{#2}%
  \csdef{firstnamefont#1}{#3}%
  \csdef{secondnamefont#1}{#4}%
}

% Register all 9 font options
\definefontvariant{sourcesanspro}{../assets/fonts/sourcesanspro/}{SourceSansPro-SemiBold}{SourceSansPro-Light}
\definefontvariant{officecodeprod}{../assets/fonts/officecodeprod/}{OfficeCodeProD-Medium}{OfficeCodeProD-Regular}
\definefontvariant{sourceserifpro}{../assets/fonts/sourceserifpro/}{SourceSerifPro-SemiBold}{SourceSerifPro-Light}
\definefontvariant{prata}{../assets/fonts/prata/}{Prata-Regular}{Prata-Regular}
\definefontvariant{marcellus}{../assets/fonts/marcellus/}{Marcellus-Regular}{Marcellus-Regular}
\definefontvariant{abrilfatface}{../assets/fonts/abril_fatface/}{AbrilFatface-Regular}{AbrilFatface-Regular}
\definefontvariant{merriweather}{../assets/fonts/merriweather/}{Merriweather-Regular}{Merriweather-Light}
\definefontvariant{oxygen}{../assets/fonts/oxygen/}{Oxygen-Regular}{Oxygen-Light}
\definefontvariant{inter}{../assets/fonts/inter/}{Inter-SemiBold}{Inter-Light}

% Font options command
\DeclareRobustCommand{\fontoption}[1]{%
  \ifcsdef{pathtitlefont#1}{%
    \edef\pathtitlefont{\csuse{pathtitlefont#1}}%
    \edef\firstnamefont{\csuse{firstnamefont#1}}%
    \edef\secondnamefont{\csuse{secondnamefont#1}}%
  }{%
    % Fallback to sourcesanspro if not found
    \def\pathtitlefont{../assets/fonts/sourcesanspro/}%
    \def\firstnamefont{SourceSansPro-SemiBold}%
    \def\secondnamefont{SourceSansPro-Light}%
  }%
}

% Main font definitions
\def\pathmainfont{../assets/fonts/inter/}
\def\mainfont{Inter-Light}
\def\mainfontbold{Inter-SemiBold}
\def\mainfontsize{9.5}
\def\mainsansfont{Inter-Light}

% Subheading and descriptor fonts
\def\pathsubheadingfont{\pathtitlefont}
\def\subheadingfont{\titlefont}
\def\subheadingsize{12}
\def\pathdescriptorfont{\pathsubheadingfont}
\def\descriptorfont{\secondnamefont}
\def\descriptorsize{10}
\def\pathlocationfont{\pathsubheadingfont}
\def\locationfont{\subheadingfont}
\def\locationsize{8pt}

% Monospace font for contact line
\def\pathmonofont{../assets/fonts/officecodeprod/}
\def\monofont{OfficeCodeProD-Light}

% Set fonts
\usepackage{fontspec}
\setmainfont[
  Color=primary,
  Path = \pathmainfont,
  BoldFont=\mainfontbold,
  ItalicFont=\mainfont,
  ItalicFeatures={FakeSlant=0.2}
]{\mainfont}

\setsansfont[
  Scale=MatchLowercase,
  Mapping=tex-text,
  Path = \pathmainfont,
  ItalicFont=\mainfont,
  ItalicFeatures={FakeSlant=0.2}
]{\mainsansfont}

% Section separators
\usepackage{titlesec}
\titlespacing{\section}{0pt}{2pt}{2pt}
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\newcommand{\sectionsep}{\vspace{2pt}}

% Headings
\titleformat{\section}{\color{title}
  \fontspec[Path =
  \pathtitlefont]{\titlefont}\fontsize{16pt}{24pt}\selectfont
\raggedright\uppercase}{}{0em}{}

% Subheadings
\titleformat{\subsection}{
  \color{subheadings}\fontspec[Path = \pathsubheadingfont
]{\subheadingfont}\fontsize{\subheadingsize}{14pt}\selectfont\raggedright\uppercase}{}{0em}{}

\newcommand{\runsubsection}[1]{%
  \color{subheadings}\fontspec[Path = \pathsubheadingfont
  ]{\subheadingfont}\fontsize{\subheadingsize}{14pt}\selectfont
  #1\normalfont}

\newcommand{\descript}[1]{%
  \unskip\hspace{0.4em}%
  {\color{headings}\raisebox{0.12ex}{\scriptsize\textbullet}}%
  \hspace{0.4em}%
  \color{subheadings}\raggedright\fontspec[Path =
  \pathdescriptorfont]{\descriptorfont}\fontsize{\descriptorsize}{13pt}\selectfont
  #1\\ \normalfont}

\newcommand{\location}[1]{
  \color{headings}\raggedright\fontspec[Path =
  \pathlocationfont]{\locationfont}\fontsize{\locationsize}{12pt}\selectfont
{#1\\} \normalfont}

% Contact Icon helper
\newcommand{\contacticon}[1]{\raisebox{-0.2\height}{\includegraphics[scale=0.5]{../assets/icons/#1.png}}}

% Contact line with icons
\newcommand{\contactline}[3]{
  \contacticon{mail} {#1}\hspace{0.02pt}
  \contacticon{linkedin} {#2}\hspace{0.02pt}
  \contacticon{github-circle} {#3}\hspace{0.02pt}
  % \contacticon{home-simple} {#1}\hspace{0.02pt}
  % \contacticon{phone-income} {#5}
}

% Name section: supports either:
%   \namesection{First}{Last}{Contact}            (3 arguments, no title)
%   \namesection{First}{Last}[Title]{Contact}     (optional title via bracket)
\NewDocumentCommand{\namesection}{ m m O{} +m }{%
  {\RaggedRight\color{title}\fontsize{50pt}{60pt}\fontspec[Path =
    \pathtitlefont]{\firstnamefont}\selectfont #1
  \fontspec[Path = \pathtitlefont]{\secondnamefont}\selectfont #2\par}%
  \ifthenelse{\equal{#3}{}}{}{%
    \vspace{2pt}%
    {\RaggedRight\fontspec[Path =
    \pathmonofont]{\monofont}\fontsize{14pt}{18pt}\selectfont #3\par}%
  }%
  \vspace{2pt}%
  {\RaggedRight\fontspec[Path =
  \pathmonofont]{\monofont}\fontsize{10pt}{14pt}\selectfont #4\par}%
  \vspace{4pt}%
}

% Tight itemize
\newenvironment{tightemize}{
  \begin{itemize}[label=\ding{212}, itemsep=1pt, parsep=0pt,
    topsep=0pt, partopsep=0pt]}
    {
\end{itemize}}
