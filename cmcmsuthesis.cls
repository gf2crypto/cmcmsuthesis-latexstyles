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
\DeclareStringOption[student]{titlepagesty}  % student or phd

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
% microtype:
%   draft=false  →  protrusion + expansion (best quality)
%   draft=true   →  protrusion only        (faster compilation)
% ---------------------------------------------------------------
\ifcmcmsu@draft
    \RequirePackage[%
        protrusion=true,
        expansion=false]{microtype}
\else
    \RequirePackage[%
        protrusion=true,
        expansion=true]{microtype}
\fi

% ---------------------------------------------------------------
% Place further shared package loads and settings below this line.
% ---------------------------------------------------------------

% ---------------------------------------------------------------
% Title page style ONE
%   Dissertation style (ГОСТ Р 7.0.11-2001, 5.1)
% ---------------------------------------------------------------
\def\cmcmsu@titlepagesty@phd{%

    % -- Specialty ------------------------------------------------
    \newcommand{\thesisSpecialtyCode}{1.2.3}
    \newcommand{\thesisSpecialtyName}{теоретическая информатика, кибернетика}
    \newcommand{\thesisSpecialtySep}{~---~}
    \newcommand{\thesisSpecialtyPrefix}{Специальность}
    \newcommand{\thesisSpecialtyFormat}{%
        \thesisSpecialtyPrefix~\thesisSpecialtyCode\thesisSpecialtySep\thesisSpecialtyName}
    \newcommand{\thesisSpecialty}{\thesisSpecialtyFormat}

    \newcommand{\specialty}[3][\thesisSpecialtySep]{%
        \renewcommand{\thesisSpecialtySep}{##1}%
        \renewcommand{\thesisSpecialtyCode}{##2}%
        \renewcommand{\thesisSpecialtyName}{##3}}
    \newcommand{\specialtysep}[1]{\renewcommand{\thesisSpecialtySep}{##1}}
    \newcommand{\specialtyprefix}[1]{\renewcommand{\thesisSpecialtyPrefix}{##1}}
    \newcommand{\specialtyformat}[1]{\renewcommand{\thesisSpecialtyFormat}{##1}}

    % -- Advisor --------------------------------------------------
    \newcommand{\thesisAdvisorPrefix}{Научный руководитель}
    \newcommand{\thesisAdvisorPrefixSep}{: \\}
    \newcommand{\thesisAdvisorSciDegree}{д-р~физ.-мат.~наук}
    \newcommand{\thesisAdvisorName}{}
    \newcommand{\thesisAdvisor}{%
        \thesisAdvisorPrefix\thesisAdvisorPrefixSep
        \thesisAdvisorSciDegree\ \thesisAdvisorName}

    \newcommand{\advisor}[2][д-р~физ.-мат.~наук]{%
        \renewcommand{\thesisAdvisorSciDegree}{##1}%
        \renewcommand{\thesisAdvisorName}{##2}}
    \newcommand{\advisorprefix}[1]{\renewcommand{\thesisAdvisorPrefix}{##1}}
    \newcommand{\advisorprefixsep}[1]{\renewcommand{\thesisAdvisorPrefixSep}{##1}}

    % -- Place / University ---------------------------------------
    \newcommand{\thesisState}{Москва}
    \newcommand{\thesisUniversity}{%
        Федеральное государственное бюджетное образовательное учреждение
        высшего образования
        <<Московский государственный университет имени М.В.\,Ломоносова>>}

    \newcommand{\place}[2][Москва]{%
        \renewcommand{\thesisState}{##1}%
        \renewcommand{\thesisUniversity}{##2}}

    % -- Logo -----------------------------------------------------
    \newcommand{\thesisLogoPath}{./images/logo.png}
    \newcommand{\logo}[1]{\renewcommand{\thesisLogoPath}{##1}}

    % -- \maketitle -----------------------------------------------
    \renewcommand{\maketitle}{%
        \thispagestyle{empty}%
        \begin{center}
            \thesisUniversity
        \end{center}

        \vspace{0pt plus4fill}

        \IfFileExists{\thesisLogoPath}{%
            \begin{minipage}[t]{0.5\linewidth}
                \begin{flushleft}
                    \includegraphics[height=3.5cm]{\thesisLogoPath}
                \end{flushleft}
            \end{minipage}%
            \begin{minipage}[b]{0.5\linewidth}
                \begin{flushright}
                    На правах рукописи
                \end{flushright}
            \end{minipage}%
        }{%
            \begin{flushright}
                На правах рукописи
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
            \thesisSpecialty\par
        \end{center}

        \vspace{0pt plus2fill}

        \begin{center}
            \UseName{@subtitle}\par
        \end{center}

        \vspace{0pt plus4fill}

        \begin{flushright}
            \thesisAdvisor\par
        \end{flushright}

        \vspace{0pt plus4fill}

        {\centering\thesisState~---~\UseName{@date}\par}
        \newpage
    }%
}

% ---------------------------------------------------------------
% Title page style TWO
%   Course work / bachelor thesis style
% ---------------------------------------------------------------
\def\cmcmsu@titlepagesty@student{%

    % -- Advisor --------------------------------------------------
    \newcommand{\thesisAdvisorPrefix}{Научный руководитель}
    \newcommand{\thesisAdvisorPrefixSep}{:}
    \newcommand{\thesisAdvisorSciDegree}{канд.~физ.-мат.~наук}
    \newcommand{\thesisAdvisorName}{Фамилия И.О.}
    \newcommand{\thesisAdvisor}{%
        {\bfseries\thesisAdvisorPrefix}\thesisAdvisorPrefixSep\\
        \thesisAdvisorSciDegree\space\thesisAdvisorName}

    \newcommand{\advisor}[2][канд.~физ.-мат.~наук]{%
        \renewcommand{\thesisAdvisorSciDegree}{##1}%
        \renewcommand{\thesisAdvisorName}{##2}}
    \newcommand{\advisorprefix}[1]{\renewcommand{\thesisAdvisorPrefix}{##1}}
    \newcommand{\advisorsep}[1]{\renewcommand{\thesisAdvisorPrefixSep}{##1}}

    % -- Place / University / Faculty / Department ----------------
    \newcommand{\thesisState}{Москва}
    \newcommand{\thesisUniversity}{%
        Московский государственный университет имени М.В.\,Ломоносова}
    \newcommand{\thesisFaculty}{Факультет вычислительной математики и кибернетики}
    \newcommand{\thesisDepartment}{Кафедра информационной безопасности}
    \newcommand{\printUniversity}{%
        \thesisUniversity\par\thesisFaculty\par\thesisDepartment\par}

    \newcommand{\place}[4][Москва]{%
        \renewcommand{\thesisState}{##1}%
        \renewcommand{\thesisUniversity}{##2}%
        \renewcommand{\thesisFaculty}{##3}%
        \renewcommand{\thesisDepartment}{##4}}

    % -- Logo -----------------------------------------------------
    \newcommand{\thesisLogoPath}{./images/logo.jpg}
    \newcommand{\logo}[1]{\renewcommand{\thesisLogoPath}{##1}}

    % -- \maketitle -----------------------------------------------
    \renewcommand{\maketitle}{%
        \clearpage
        \thispagestyle{empty}%
        \begin{center}
            \singlespacing
            \IfFileExists{\thesisLogoPath}{%
                \includegraphics[height=3.5cm]{\thesisLogoPath}\par
            }{}%
            \printUniversity\par
        \end{center}

        \vspace{0pt plus2fill}

        \begin{flushright}
            На правах рукописи
        \end{flushright}

        \vspace{0pt plus2fill}

        \begin{center}
            \singlespacing
            {\large \UseName{@author}}
        \end{center}

        \vspace{0pt plus1fill}

        \begin{center}
            \singlespacing
            {\bfseries\large \UseName{@title}}\par
        \end{center}

        \vspace{0pt plus-1fill}

        \begin{center}
            \singlespacing
            \MakeUppercase{\UseName{@subtitle}}\par
        \end{center}

        \vspace{0pt plus4fill}

        \begin{flushright}
            \singlespacing%
            \thesisAdvisor\par
        \end{flushright}

        \vspace{0pt plus4fill}

        {\centering\thesisState,\space\UseName{@date}\par}
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
