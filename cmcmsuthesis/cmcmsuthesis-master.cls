%% cmcmsuthesis-master.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmcmsuthesis-master}[2026/03/23 v0.1 Master thesis class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=cmcmsumas,
    prefix=cmcmsumas@
}

\makeatletter

\DeclareStringOption[14pt]{fontsize}
\DeclareStringOption[modern]{font}
\DeclareBoolOption[false]{draft}
\DeclareDefaultOption{}
\ProcessKeyvalOptions{cmcmsumas}

% Собираем строку опций для передачи в cmcmsuthesis
\edef\cmcmsumas@options{%
    parent=extarticle,%
    titlepagesty=cmc,%
    fontsize=\cmcmsumas@fontsize,%
    font=\cmcmsumas@font%
}

\ifcmcmsumas@draft
    \edef\cmcmsumas@options{\cmcmsumas@options,draft=true}
\else
    \edef\cmcmsumas@options{\cmcmsumas@options,draft=false}
\fi

\expandafter\LoadClass\expandafter[\cmcmsumas@options]{%
    cmcmsuthesis}

\thesissetup{%
    copyright = {},
    subtitle = {Магистерская диссертация}
}

\makeatother
\endinput
