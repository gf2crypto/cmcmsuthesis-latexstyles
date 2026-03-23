%% cmcmsuthesis.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmcmsuthesis}[2026/03/23 v0.1 CMC MSU Thesis Class]

\makeatletter

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
    family=cmcmsu,
    prefix=cmcmsu@
}

\DeclareStringOption[article]{parent}
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
    logo                      = {cmcmsuthesis-\cmcmsu@titlepagesty.png},
    %
    copyright/.store in       = \cmcmsu@thesis@copyright,
    copyright                 = {На правах рукописи},
    %% --- advisor ---
    advisor/.is family,
    /cmcmsu/thesis/advisor,
    %
    name/.store in            = \cmcmsu@thesis@advisor@name,
    name                      = {Фамилия И.О.},
    %
    degree/.store in          = \cmcmsu@thesis@advisor@degree,
    degree                    = {канд.~физ.-мат.~наук},
    %
    prefix/.store in          = \cmcmsu@thesis@advisor@prefix,
    prefix                    = {Научный руководитель},
    %
    prefix sep/.store in      = \cmcmsu@thesis@advisor@prefixsep,
    prefix sep                = {: \\},
    %
    % --- specialty (style one) ---
    /cmcmsu/thesis/.is family,
    /cmcmsu/thesis,
    specialty/.is family,
    /cmcmsu/thesis/specialty,
    %
    code/.store in            = \cmcmsu@thesis@specialty@code,
    code                      = {1.2.3},
    %
    name/.store in            = \cmcmsu@thesis@specialty@name,
    name                      = {теоретическая информатика, кибернетика},
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

% ---------------------------------------------------------------
% Title page style ONE
%   Dissertation style (ГОСТ Р 7.0.11-2001, 5.1)
% ---------------------------------------------------------------
\def\cmcmsu@titlepagesty@gost{%

    \renewcommand{\maketitle}{%
        \clearpage
        \thispagestyle{empty}%
        {\renewcommand{\baselinestretch}{1}\selectfont
            \begin{center}
                \cmcmsu@thesis@university%
            \end{center}

            \vspace{0pt plus4fill}

            \IfFileExists{\cmcmsu@thesis@logo}{%
                \begin{minipage}[t]{0.5\linewidth}
                    \begin{flushleft}
                        \includegraphics[height=3.5cm]{\cmcmsu@thesis@logo}
                    \end{flushleft}
                \end{minipage}%
                \begin{minipage}[b]{0.5\linewidth}
                    \begin{flushright}
                        \cmcmsu@thesis@copyright%
                    \end{flushright}
                \end{minipage}%
            }{%
                \begin{flushright}
                    \cmcmsu@thesis@copyright%
                \end{flushright}
            }

            \vspace{0pt plus6fill}

            \begin{center}
                {\large \UseName{@author}}
            \end{center}

            \vspace{0pt plus1fill}

            \begin{center}
                {\bfseries\large \UseName{@title}}\par
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
                \UseName{@subtitle}\par
            \end{center}

            \vspace{0pt plus4fill}

            \begin{flushright}
                \cmcmsu@thesis@advisor@prefix
                \cmcmsu@thesis@advisor@prefixsep
                \cmcmsu@thesis@advisor@degree\
                \cmcmsu@thesis@advisor@name\par
            \end{flushright}

            \vspace{0pt plus4fill}

            {\centering\cmcmsu@thesis@state~---~\UseName{@date}\par}
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
            \begin{center}
                \IfFileExists{\cmcmsu@thesis@logo}{%
                    \includegraphics[height=3.5cm]{\cmcmsu@thesis@logo}\par
                }{}%
                \cmcmsu@thesis@university\par
                \cmcmsu@thesis@faculty\par
                \cmcmsu@thesis@department\par
            \end{center}

            \vspace{0pt plus2fill}

            \begin{flushright}
                \cmcmsu@thesis@copyright%
            \end{flushright}

            \vspace{0pt plus2fill}

            \begin{center}
                {\large \UseName{@author}}
            \end{center}

            \vspace{0pt plus1fill}

            \begin{center}
                {\bfseries\large \UseName{@title}}\par
            \end{center}

            \vspace{0pt plus-1fill}

            \begin{center}
                \MakeUppercase{\UseName{@subtitle}}\par
            \end{center}

            \vspace{0pt plus4fill}

            \begin{flushright}
                {\bfseries\cmcmsu@thesis@advisor@prefix}%
                \cmcmsu@thesis@advisor@prefixsep\\
                \cmcmsu@thesis@advisor@degree\space
                \cmcmsu@thesis@advisor@name\par
            \end{flushright}

            \vspace{0pt plus4fill}

            {\centering\cmcmsu@thesis@state,\space\UseName{@date}\par}
        }% end \baselinestretch group
        \newpage
    }%
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

\makeatother
\endinput
