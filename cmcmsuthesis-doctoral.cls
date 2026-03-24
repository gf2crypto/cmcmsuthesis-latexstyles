%% cmcmsuthesis-doctoral.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmcmsuthesis-doctoral}[2026/03/23 v0.1 Doctoral thesis class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=cmcmsudoc,
    prefix=cmcmsudoc@
}

\makeatletter

\DeclareStringOption[14pt]{fontsize}
\DeclareStringOption[modern]{font}
\DeclareBoolOption[false]{draft}
\DeclareDefaultOption{}
\ProcessKeyvalOptions{cmcmsudoc}

% Собираем строку опций для передачи в cmcmsuthesis
\edef\cmcmsudoc@options{%
    parent=extreport,%
    titlepagesty=gost,%
    fontsize=\cmcmsudoc@fontsize,%
    font=\cmcmsudoc@font%
}

\ifcmcmsudoc@draft
    \edef\cmcmsudoc@options{\cmcmsudoc@options,draft=true}
\else
    \edef\cmcmsudoc@options{\cmcmsudoc@options,draft=false}
\fi

\expandafter\LoadClass\expandafter[\cmcmsudoc@options]{%
    cmcmsuthesis}

\thesissetup{%
    university                = {Федеральное государственное
            бюджетное образовательное учреждение высшего профессионального образования
            \enquote{Московский государственный университет имени М.В.Ломоносова}},
    subtitle                     = {Диссертация на соискание ученой степени доктора физико-математических наук},
    supervisor/name = {Научный консультант}
}

\makeatother
\endinput
