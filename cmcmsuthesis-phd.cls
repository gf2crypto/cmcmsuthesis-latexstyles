%% cmcmsuthesis-phd.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmcmsuthesis-phd}[2026/03/23 v0.1 Phd thesis class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
    family=cmcmsuphd,
    prefix=cmcmsuphd@
}

\makeatletter

\DeclareStringOption[14pt]{fontsize}
\DeclareStringOption[modern]{font}
\DeclareBoolOption[false]{draft}
\DeclareDefaultOption{}
\ProcessKeyvalOptions{cmcmsuphd}

% Собираем строку опций для передачи в cmcmsuthesis
\edef\cmcmsuphd@options{%
    parent=extreport,%
    titlepagesty=gost,%
    fontsize=\cmcmsuphd@fontsize,%
    font=\cmcmsuphd@font%
}

\ifcmcmsuphd@draft
    \edef\cmcmsuphd@options{\cmcmsuphd@options,draft=true}
\else
    \edef\cmcmsuphd@options{\cmcmsuphd@options,draft=false}
\fi

\expandafter\LoadClass\expandafter[\cmcmsuphd@options]{%
    cmcmsuthesis}

\thesissetup{%
    university                = {Федеральное государственное
            бюджетное образовательное учреждение высшего профессионального образования
            \enquote{Московский государственный университет имени М.В.Ломоносова}},
    subtitle                     = {Диссертация на соискание ученой степени кандидата физико-математических наук},
}

\makeatother
\endinput
