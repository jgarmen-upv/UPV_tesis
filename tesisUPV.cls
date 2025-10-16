\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tesisUPV}[2016/09/05 Editorial de la Universitat Politecnica de Valencia]
\LoadClass[10pt]{book}

% ------------------------------------------------------

\RequirePackage{ifthen}

% ----- This solves the problem with text sizes -----
\RequirePackage{fix-cm}

% ------------------------------------------------------


\newboolean{CROP}\setboolean{CROP}{false}
\newboolean{DistanciesEquacions}\setboolean{DistanciesEquacions}{true}

\newboolean{RM}\setboolean{RM}{false}
\newboolean{SF}\setboolean{SF}{false}

\newboolean{valencia}\setboolean{valencia}{false}
\newboolean{castellano}\setboolean{castellano}{false}
\newboolean{english}\setboolean{english}{false}


% ------------------------------------------------------

\DeclareOption{no-crop}{\setboolean{CROP}{false}}
\DeclareOption{crop}{\setboolean{CROP}{true}}
% Per compatibilitat
\DeclareOption{nocrop}{\setboolean{CROP}{false}}
\DeclareOption{croscrop}{\setboolean{CROP}{true}}

\DeclareOption{rm}{\setboolean{RM}{true}}
\DeclareOption{sf}{\setboolean{SF}{true}}

\DeclareOption{nomathskip}{\setboolean{DistanciesEquacions}{false}}

% ------------------------------------------------------
% Handling language options

\DeclareOption{castellano}{
	\setboolean{castellano}{true}
	\setboolean{valencia}{false}
	\setboolean{english}{false}
}
\DeclareOption{valencia}{
	\setboolean{castellano}{false}
	\setboolean{valencia}{true}
	\setboolean{english}{false}
	}
\DeclareOption{english}{
	\setboolean{castellano}{false}
	\setboolean{valencia}{false}
	\setboolean{english}{true}
	}

% ------------------------------------------------------
% Warning in case other options are passed
\DeclareOption*{\ClassWarning{tesisUPV}{option cannot be processed: ?\CurrentOption?}}

% ------------------------------------------------------
% Default options
\ExecuteOptions{rm,nocrop,english}
\ProcessOptions\relax

% ------------------------------------------------------
% Set language according to options
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

\ifenglish
    \RequirePackage[spanish, catalan, main=english]{babel}
\fi

\ifcastellano
    \RequirePackage[main=spanish, catalan, english]{babel}
\fi

\ifvalencia
    \RequirePackage[spanish, main=catalan, english]{babel}
\fi


% ------------------------------------------------------
% Packages needed to create the title
\RequirePackage{graphicx}
\RequirePackage{calc}

% ------------------------------------------------------
% Title page
\renewcommand\maketitle{
    \begin{titlepage}
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    %\null\vfil
    \begin{center}%
    \vskip -50\p@ %-100
    {\Large\bfseries Ph.D. thesis dissertation \par}
    {\includegraphics[width=5.0cm]{./logos/UPV_Vertical_negro}} %5.0cm
    \vskip 30\p@ %50
    %\rule{\textwidth}{1pt}\par
    %\vskip 1.5em%
    {\huge\bfseries \@title \par}% \textsc{\@title}
    %\vskip 1.5em%
    %\rule{\textwidth}{1pt}\par    
    {\large
     \lineskip .75em%
      \vskip 60\p@     
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      %\vskip 60\p@
    \vspace*{\fill}%
    {\large \@date \par}%\@date       % Set date in \large size.
    %  \@thanks
    %\vfil\null
    \end{center}\par
    \end{titlepage}%
    \setcounter{footnote}{0}%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    \global\let\@thanks\@empty
    \global\let\@author\@empty
    \global\let\@date\@empty
    \global\let\@title\@empty
    \global\let\title\relax
    \global\let\author\relax
    \global\let\date\relax
    \global\let\and\relax
}


% ---------------------------------------------------------------------
% Font type and sizes

\renewcommand{\normalsize}{\fontsize{10.5pt}{12.5pt}\selectfont}

% Sans-Serif (sf) or roman (rm) style
\ifSF
	\renewcommand{\familydefault}{\sfdefault}
\else
	\renewcommand{\familydefault}{\rmdefault}
\fi
	
% ---------------------------------------------------------------------
% Page format -- variables written in valencian :(

\RequirePackage{geometry}

\newlength{\amplePublicacio}
\setlength{\amplePublicacio}{17cm}

\newlength{\alcadaPublicacio}
\setlength{\alcadaPublicacio}{24cm}

\newlength{\margeVerticalSuperior}
\setlength{\margeVerticalSuperior}{1.75cm}

\newlength{\margeVerticalInferior}
\setlength{\margeVerticalInferior}{1.75cm}

\newlength{\margeInterior}
\setlength{\margeInterior}{2.5cm}

\geometry{ 
    twoside,
    vmargin = {\margeVerticalSuperior, \margeVerticalInferior}, 
    includehead, includefoot,
    left = \margeInterior,
    headheight = 0.55cm,	
    headsep = 0.7cm,
    footskip = 1.25cm,
    textwidth = 13cm, % Caja de texto 13cm x 21 cm
    paperwidth = \amplePublicacio, paperheight = \alcadaPublicacio,
    }

% --------------------------------------------
% Cut marks

\ifCROP
    \usepackage[cam, a4, center, odd, noinfo]{crop}
\fi


% ---------------------------------------------------------------------
% Headings and footnotes

\RequirePackage{fancyhdr}
\pagestyle{fancy}

\renewcommand{\chaptermark}[1]{\markboth{\@chapapp\ \thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}{}}

\fancyhead{} % Remove headings configurations
\fancyfoot{} % Remove footnotes configurations

\newlength{\myevenheadlinehoffset}
\newlength{\myevenheadtexthoffset}
\newlength{\myoddheadlinewidth}
\newlength{\myevenheadlinewidth}

\setlength{\myevenheadlinehoffset}{0.0cm}
\setlength{\myevenheadtexthoffset}{0.0cm}
\setlength{\myoddheadlinewidth}{\textwidth}
\setlength{\myevenheadlinewidth}{\textwidth}

\fancyhead[LE]{%
    \hspace*{\myevenheadlinehoffset}\makebox[0cm][l]{\rule[-2mm]{\myevenheadlinewidth}{.25pt}}%
    \hspace*{\myevenheadtexthoffset}{\footnotesize\itshape\nouppercase\leftmark}%
    }
\fancyhead[LO]{%
    \makebox[0cm][l]{\rule[-2mm]{\myoddheadlinewidth}{.25pt}}%
    \makebox[\textwidth][r]{\footnotesize\itshape\nouppercase\rightmark}%
    }
    
\fancyfoot[LE,RO]{\thepage}%


% Footnote in first chapter page
\fancypagestyle{plain}{% 
    \fancyhf{} % clear all header and footer fields 
    \fancyfoot[RO]{\thepage}%
    }

\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}


% ---------------------------------------------------------------------
% Paragraph format and layout

\setlength{\parskip}{2ex}
\setlength{\parindent}{0pt}

\newlength{\separaParrafos}
\setlength{\separaParrafos}{\parskip}
\newlength{\indentaParrafos}
\setlength{\indentaParrafos}{\parindent}

\linespread{1.0}

\setlength{\widowpenalty}{10000pt}
\setlength{\clubpenalty}{10000pt}

\raggedbottom


% ---------------------------------------------------------------------
% Improve figures and tables titles

\RequirePackage{caption}
\renewcommand{\captionlabelfont}{\bfseries\small}
\renewcommand{\captionfont}{\small}

% ------------------------------------------------------------------------
% Sections format

\RequirePackage[
	raggedright,
	compact,
	nobottomtitles*, % Evita que queden títulos sueltos al final de la página
	clearempty, % Modifica \cleardoublepage para que las hojas pares vacías queden en blanco
	]{titlesec}

% ------------------------------------------------------------------------

\titleformat{\part}
	[display]
	{\thispagestyle{empty}\filcenter
	\tolerance=10000\hyphenpenalty=10000}
	{\fontsize{18}{20}\bfseries\partname\enspace\thepart}
	{1pc}
	{\fontsize{24}{30}\bfseries}

% ------------------------------------------------------------------------

\titleformat{\chapter}
	[display]
	{\normalfont\Large\filcenter}
	{\raggedleft\fontsize{18}{20}\bfseries\chaptertitlename\enspace\thechapter}
	{2ex}
	{\raggedleft\fontsize{24}{30}\bfseries}
	[\vspace{2cm}]

% ------------------------------------------------------------------------

\titleformat{\section}
    [hang]
    {\vspace{2ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
    {\fontsize{12}{14}\bfseries\thesection}
    {1em}
    {\fontsize{12}{14}\bfseries}

% ------------------------------------------------------------------------

\titleformat{\subsection}
    [hang]
    {\vspace{1.5ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
    {\fontsize{10.5}{12.5}\bfseries\itshape\thesubsection}
    {1em}
    {\fontsize{10.5}{12.5}\bfseries\itshape}
    [\vspace{-1ex}]
	
% ------------------------------------------------------------------------

\titleformat{\subsubsection}
	[hang]
	{\vspace{2ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
	{\normalsize\itshape\thesubsubsection}
	{1em}
	{\normalsize\itshape}
	[\vspace{-0.75ex}]

% -------------------------------------------------------
% Para controlar la numeración y formato de la tabla de contenidos, lista de figuras y tablas

% Modificar este numero cambia si se muestran sub-secciones (2), sub-sub-secciones (3), solo capitulos (0), etc
\setcounter{tocdepth}{1}

\RequirePackage[titles]{tocloft}

\renewcommand{\cftchapaftersnum}{}

\renewcommand{\cftsecfont}{\small}
\renewcommand{\cftsecpagefont}{\small}
\renewcommand{\cftsecaftersnum}{}

\renewcommand{\cftfigfont}{\small}
\renewcommand{\cftfigpagefont}{\small}

\renewcommand{\cfttabfont}{\small}
\renewcommand{\cfttabpagefont}{\small}

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

\RequirePackage{enumitem}
\setlist[1]{partopsep=-1ex,parsep=\parskip,itemsep=0\parskip}
\setlist[2]{partopsep=-1ex,parsep=\parskip,itemsep=0\parskip}


\makeatletter
\let\ifes@LaTeXe\iftrue % For babel compatibility from htlatex
\makeatother

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

\RequirePackage{mathtools}

\ifDistanciesEquacions
\AtBeginDocument
	{
	% ---------------------------------------------------
	% Distancia de las ecuaciones al texto
	
	% Para ecuaciones normales
	\abovedisplayshortskip = -1.0ex plus 0ex minus 0.25ex
	\belowdisplayshortskip = 2.0ex plus 1ex minus 0.0ex
	
	% Para las ecuaciones en varias lineas
	\abovedisplayskip = -1.0ex plus 0ex minus 0.25ex
	\belowdisplayskip = 2.0ex plus 1ex minus 0.0ex
	}
\fi

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
