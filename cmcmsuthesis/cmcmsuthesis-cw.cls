%% cmcmsuthesis-cw.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmcmsuthesis-cw}[2026/03/23 v0.1 Course work thesis class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=cmcmsucw,
    prefix=cmcmsucw@
}

\makeatletter

\DeclareStringOption[14pt]{fontsize}
\DeclareStringOption[modern]{font}
\DeclareBoolOption[false]{draft}
\DeclareDefaultOption{}
\ProcessKeyvalOptions{cmcmsucw}

% Собираем строку опций для передачи в cmcmsuthesis
\edef\cmcmsucw@options{%
    parent=extarticle,%
    titlepagesty=cmc,%
    fontsize=\cmcmsucw@fontsize,%
    font=\cmcmsucw@font%
}

\ifcmcmsucw@draft
    \edef\cmcmsucw@options{\cmcmsucw@options,draft=true}
\else
    \edef\cmcmsucw@options{\cmcmsucw@options,draft=false}
\fi

\expandafter\LoadClass\expandafter[\cmcmsucw@options]{%
    cmcmsuthesis}

\thesissetup{%
    copyright = {},
    subtitle = {Курсовая работа}
}

\makeatother
\endinput
