%% cmcmsuthesis-bachelor.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmcmsuthesis-bachelor}[2026/03/23 v0.1 Bachelor thesis class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=cmcmsubach,
    prefix=cmcmsubach@
}

\makeatletter

\DeclareStringOption[14pt]{fontsize}
\DeclareStringOption[modern]{font}
\DeclareBoolOption[false]{draft}
\DeclareDefaultOption{}
\ProcessKeyvalOptions{cmcmsubach}

% Собираем строку опций для передачи в cmcmsuthesis
\edef\cmcmsubach@options{%
    parent=extarticle,%
    titlepagesty=cmc,%
    fontsize=\cmcmsubach@fontsize,%
    font=\cmcmsubach@font%
}

\ifcmcmsubach@draft
    \edef\cmcmsubach@options{\cmcmsubach@options,draft=true}
\else
    \edef\cmcmsubach@options{\cmcmsubach@options,draft=false}
\fi

\expandafter\LoadClass\expandafter[\cmcmsubach@options]{%
    cmcmsuthesis}

\thesissetup{%
    copyright = {}
}

\makeatother
\endinput
