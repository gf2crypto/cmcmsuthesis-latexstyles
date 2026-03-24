%% cmcmsuthesis.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmcmsuthesis}[2026/03/23 v0.1 CMC MSU Thesis Class]

\makeatletter

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
    family=cmcmsu,
    prefix=cmcmsu@
}

\DeclareStringOption[extarticle]{parent}
\DeclareStringOption[14pt]{fontsize}
\DeclareStringOption[cmc]{titlepagesty}  % cmc or gost

%%% Fonts set (see cmcmsugost-fontselector.sty)
\DeclareStringOption[modern]{font}
\DeclareBoolOption[false]{draft} % draft / draft=true / draft=false
\DeclareDefaultOption{}          % silently ignore everything else

\ProcessKeyvalOptions{cmcmsu}

% Forward draft to the parent class only when enabled
\ifcmcmsu@draft%
    \PassOptionsToClass{draft}{\cmcmsu@parent}
\fi

\LoadClass[\cmcmsu@fontsize]{\cmcmsu@parent}


\ifcmcmsu@draft%
    \newcommand{\cmcmsu@microtype}{false}
\else
    \newcommand{\cmcmsu@microtype}{true}
\fi

\usepackage[%
    % upgreek=false,
    % mathcalold=false,
    % lang=russian,
    font=\cmcmsu@font,
    % fontscale=\cmcmsu@fontscale,
    % mathfont=\cmcmsu@mathfont,
    % mathfontscale=\cmcmsu@mathfontscale,
    % sans=\cmcmsu@sans,
    % sansscale=\cmcmsu@sansscale,
    % mono=\cmcmsu@mono,
    % monoscale=\cmcmsu@monoscale%
    microtype=\cmcmsu@microtype%
]{cmcmsugost-fontselector}
\usepackage[%
    tocpageword=true,
    % spacing=15,
    sectionclearpage=true
]{cmcmsu-gost}
\usepackage[%
    rumathop=true,
    thm=true,
    extramath=true,
    listings=true,
    biber=true,
    alg=2e
]{cmcmsugost-extra}


% ---------------------------------------------------------------
% Thesis metadata via pgfkeys
% ---------------------------------------------------------------
\RequirePackage{pgfkeys}
\RequirePackage{graphicx}

\newif\ifcmcmsu@graphicexists

\newcommand{\cmcmsu@checkgraphicpath}[1]{%
    \begingroup
    \let\input@path\Ginput@path
    \edef\Gin@extensions{\detokenize\expandafter{\Gin@extensions}}%
    \filename@parse{#1}%
    \let\Gin@ext\relax
    \ifx\filename@ext\relax
        \@for\Gin@temp:=\Gin@extensions\do{%
            \ifx\Gin@ext\relax
                \Gin@getbase\Gin@temp
            \fi}%
    \else
        \Gin@getbase{\Gin@sepdefault\filename@ext}%
    \fi
    \ifx\Gin@ext\relax
        \global\cmcmsu@graphicexistsfalse
    \else
        \global\cmcmsu@graphicexiststrue
    \fi
    \endgroup
}

% Публичная команда (для пользователей)
\newcommand{\IfGraphicExists}[3]{%
    % #1 = имя файла, #2 = true, #3 = false
    \cmcmsu@checkgraphic{#1}%
    \ifcmcmsu@graphicexists #2\else #3\fi
}

% All keys live under /cmcmsu/thesis/.
% Stored variables follow the same naming convention: \cmcmsu@thesis@<name>.
% Slashes in key names map to nested paths in pgfkeys.

\pgfkeys{
    /cmcmsu/thesis/.is family,
    /cmcmsu/thesis,
    %
    university/.store in      = \cmcmsu@thesis@university,
    university                = {Московский государственный университет имени М.В.\,Ломоносова},
    %
    faculty/.store in         = \cmcmsu@thesis@faculty,
    faculty                   = {Факультет вычислительной математики и кибернетики},
    %
    department/.store in      = \cmcmsu@thesis@department,
    department                = {Кафедра информационной безопасности},
    %
    state/.store in           = \cmcmsu@thesis@state,
    state                     = Москва,
    %
    subtitle/.store in           = \cmcmsu@thesis@subtitle,
    subtitle                     = {Выпускная квалификационная работа},
    %
    logo/.store in            = \cmcmsu@thesis@logo,
    logo                      = {cmcmsuthesis-\cmcmsu@titlepagesty},
    %
    copyright/.store in       = \cmcmsu@thesis@copyright,
    copyright                 = {На правах рукописи},
    %% --- supervisor ---
    supervisor/.is family,
    /cmcmsu/thesis/supervisor,
    %
    name/.store in            = \cmcmsu@thesis@supervisor@name,
    name                      = {уч.~степень, уч.~звание Фамилия~Имя~Отчество},
    % %
    % degree/.store in          = \cmcmsu@thesis@advisor@degree,
    % degree                    = {канд.~физ.-мат.~наук},
    %
    prefix/.store in          = \cmcmsu@thesis@supervisor@prefix,
    prefix                    = {Научный руководитель},
    %
    prefix sep/.store in      = \cmcmsu@thesis@supervisor@prefixsep,
    prefix sep                = {: \\},
    %
    % --- specialty (style one) ---
    /cmcmsu/thesis/.is family,
    /cmcmsu/thesis,
    specialty/.is family,
    /cmcmsu/thesis/specialty,
    %
    code/.store in            = \cmcmsu@thesis@specialty@code,
    code                      = {X.Y.Z},
    %
    name/.store in            = \cmcmsu@thesis@specialty@name,
    name                      = {название специальности согласно действующей номенклатуре},
    %
    sep/.store in             = \cmcmsu@thesis@specialty@sep,
    sep                       = {~---~},
    %
    prefix/.store in          = \cmcmsu@thesis@specialty@prefix,
    prefix                    = {Специальность}
}

% User-facing command: \thesisset{key=value, ...}
% Keys can be short (relative to /cmcmsu/thesis) or full-path.
\newcommand{\thesissetup}[1]{\pgfkeys{/cmcmsu/thesis, #1}}

% \supervisor{name={канд.физ.-мат.наук, доцент Фамилия~Имя~Отчество}, prefix={Научный руководитель}}
\newcommand{\supervisor}[1]{\pgfkeys{/cmcmsu/thesis/supervisor, #1}}

% \speciality{code={1.2.3}, name={теоретическая информатика, кибернетика}}
\newcommand{\specialty}[1]{\pgfkeys{/cmcmsu/thesis/specialty, #1}}

%
\newcommand{\subtitle}[1]{\pgfkeys{/cmcmsu/thesis/subtitle=#1}}
% ---------------------------------------------------------------
% Title page style ONE
%   Dissertation style (ГОСТ Р 7.0.11-2001, 5.1)
%   ---------------------------------------------------------------

\def\cmcmsu@titlepagesty@gost{%

    \renewcommand{\maketitle}{%
        \clearpage
        \thispagestyle{empty}%
        {\renewcommand{\baselinestretch}{1}\selectfont
            \begin{center}
                \cmcmsu@thesis@university%
            \end{center}

            \vspace{0pt plus4fill}

            \cmcmsu@checkgraphicpath{\cmcmsu@thesis@logo}%
            \ifcmcmsu@graphicexists%
                \begin{minipage}[t]{0.45\linewidth}
                    \begin{flushleft}
                        \includegraphics[height=3.5cm]{%
                            \cmcmsu@thesis@logo}
                    \end{flushleft}
                \end{minipage}%
                \begin{minipage}[b]{0.47\linewidth}
                    \begin{flushright}
                        \cmcmsu@thesis@copyright%
                    \end{flushright}
                \end{minipage}%
            \else
                \hfill%
                \begin{minipage}[b]{0.47\linewidth}
                    \begin{flushright}
                        \cmcmsu@thesis@copyright%
                    \end{flushright}
                \end{minipage}%
            \fi

            \vspace{0pt plus6fill}

            \begin{center}
                {\large \@author}
            \end{center}

            \vspace{0pt plus1fill}

            \begin{center}
                {\bfseries\large \@title}\par
            \end{center}

            \vspace{0pt plus2fill}

            \begin{center}
                \cmcmsu@thesis@specialty@prefix~%
                \cmcmsu@thesis@specialty@code%
                \cmcmsu@thesis@specialty@sep%
                \cmcmsu@thesis@specialty@name\par
            \end{center}

            \vspace{0pt plus2fill}

            \begin{center}
                \cmcmsu@thesis@subtitle\par
            \end{center}

            \vspace{0pt plus4fill}

            \hfill%
            \begin{minipage}{0.5\linewidth}
                \begin{flushright}
                    \cmcmsu@thesis@supervisor@prefix%
                    \cmcmsu@thesis@supervisor@prefixsep%
                    \cmcmsu@thesis@supervisor@name\par
                \end{flushright}
            \end{minipage}

            \vspace{0pt plus4fill}

            {\centering\cmcmsu@thesis@state~---~\the\year\par}
        }
        \newpage
    }%
}

% ---------------------------------------------------------------
% Title page style TWO
%   Course work / bachelor thesis style
% ---------------------------------------------------------------
\def\cmcmsu@titlepagesty@cmc{%

    \renewcommand{\maketitle}{%
        \clearpage
        \thispagestyle{empty}%
        {\renewcommand{\baselinestretch}{1}\selectfont
            \cmcmsu@checkgraphicpath{\cmcmsu@thesis@logo}%
            \ifcmcmsu@graphicexists%
                \begin{center}
                    \includegraphics[height=3.5cm]{%
                        \cmcmsu@thesis@logo}\par
                    \cmcmsu@thesis@university\par
                    \cmcmsu@thesis@faculty\par
                    \cmcmsu@thesis@department\par
                \end{center}

            \else
                \typeout{File "\cmcmsu@thesis@logo" is not found}
                \typeout{DEBUG graphicspath: "\Ginput@path"}
                \typeout{Extensions: \Gin@extensions}
                \begin{center}
                    \cmcmsu@thesis@university\par
                    \cmcmsu@thesis@faculty\par
                    \cmcmsu@thesis@department\par
                \end{center}

            \fi

            \vspace{1em plus2fill}

            \begin{flushright}
                \cmcmsu@thesis@copyright%
            \end{flushright}

            \vspace{0pt plus2fill}

            \begin{center}
                {\large \@author}
            \end{center}

            \vspace{0pt plus1fill}

            \begin{center}
                {\bfseries\large \@title}\par
            \end{center}

            \vspace{0pt plus-1fill}

            \begin{center}
                \MakeUppercase{\cmcmsu@thesis@subtitle}\par
            \end{center}

            \vspace{0pt plus4fill}

            \hfill%
            \begin{minipage}{0.5\linewidth}
                \begin{flushright}
                    {\bfseries\cmcmsu@thesis@supervisor@prefix}%
                    \cmcmsu@thesis@supervisor@prefixsep%
                    \cmcmsu@thesis@supervisor@name%
                \end{flushright}
            \end{minipage}

            \vspace{0pt plus4fill}

            {\centering\cmcmsu@thesis@state,\space\the\year\par}
        }% end \baselinestretch group
        \newpage
    }
}

\def\cmcmsu@imagesdir{{}{./}{images/}{cmcmsuthesis-latexstyles/images/}{./images/}{./cmcmsuthesis-latexstyles/images/}}

\AtBeginDocument{%
    \ifdefined\Ginput@path%
        \edef\Ginput@path{\cmcmsu@imagesdir\Ginput@path}
    \else
        \graphicspath{\cmcmsu@imagesdir}
    \fi
}

% ---------------------------------------------------------------
% Dispatch: call the selected title page style handler.
% If an unknown style is given, raise an error.
% ---------------------------------------------------------------
\@ifundefined{cmcmsu@titlepagesty@\cmcmsu@titlepagesty}{%
    \ClassError{cmcmsuthesis}{%
        Unknown titlepagesty '\cmcmsu@titlepagesty'.\MessageBreak%
        Valid values are: one, two%
    }{%
        Check the titlepagesty option passed to \string\documentclass.%
    }%
}{%
    \csname cmcmsu@titlepagesty@\cmcmsu@titlepagesty\endcsname
}

\RequirePackage{xcolor}
\definecolor{linkcolor}{RGB}{0, 40, 100}
\definecolor{urlcolor}{RGB}{0, 0, 140}
\definecolor{citecolor}{RGB}{0, 80, 40}

\hypersetup{
    colorlinks = true,
    linkcolor  = linkcolor,
    urlcolor   = urlcolor,
    citecolor  = citecolor,
}

\makeatother
\endinput
