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
\DeclareStringOption[one]{titlepagetype}  % one or two

%%% Fonts set (see cmcmsugost-fontselector.sty)
\DeclareStringOption[modern]{font}
% \DeclareStringOption[1]{fontscale}
% \DeclareStringOption[]{mathfont}
% \DeclareStringOption[1]{mathfontscale}
% \DeclareStringOption[]{sans}
% \DeclareStringOption[1]{sansscale}
% \DeclareStringOption[]{mono}
% \DeclareStringOption[1]{monoscale}

\DeclareStringOption[15]{spacing} % 10 (one), 15 (one and half), 20 (double)
\DeclareBoolOption[false]{draft} % draft / draft=true / draft=false
\DeclareDefaultOption{}          % silently ignore everything else

\ProcessKeyvalOptions{cmcmsu}

% Forward draft to the parent class only when enabled
\ifcmcmsu@draft%
    \PassOptionsToClass{draft}{\cmcmsu@parent}
\fi

\LoadClass[\cmcmsu@fontsize]{\cmcmsu@parent}


\usepackage[%
    upgreek=false,
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
    spacing=\cmcmsu@spacing,
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
    \RequirePackage[protrusion=true, expansion=false]{microtype}
\else
    \RequirePackage[protrusion=true, expansion=true]{microtype}
\fi

% ---------------------------------------------------------------
% Place further shared package loads and settings below this line.
% ---------------------------------------------------------------

\makeatother
\endinput
