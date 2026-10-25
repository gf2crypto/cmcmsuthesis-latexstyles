%% cmcmsuarticle.cls
%% Класс для математической статьи (препринта) на базе
%% cmcmsugost-fontselector и cmcmsugost-extra.
%%
%% Метаданные (в преамбуле, до \maketitle):
%%   \title{...}
%%   \addaffiliation[en={...}]{метка}{Организация}
%%   \addauthor[affil={метка1,метка2}, email={...}, en={...}]{И.\,О.~Фамилия}
%%   \articlesetup{udk=..., msc=..., keywords=..., enkeywords=...,
%%                 entitle=..., shorttitle=..., shortauthors=...,
%%                 funding=..., enfunding=...}
%%   \begin{abstract}...\end{abstract}      (русская аннотация)
%%   \begin{enabstract}...\end{enabstract}  (английская аннотация)
%% Обычный \author{...} тоже работает (без организаций и e-mail).
%% Аннотации, заданные после \maketitle, печатаются на месте.
\NeedsTeXFormat{LaTeX2e}[2020-10-01]
\ProvidesClass{cmcmsuarticle}[2026/10/24 v0.1 CMC MSU Math Article Class]

\makeatletter

\RequirePackage{iftex}
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}

\SetupKeyvalOptions{
    family = cmcmsuart,
    prefix = cmcmsuart@
}

% ================================================================
% Опции класса
% ================================================================
%% fontsize      - 10pt | 11pt | 12pt | 14pt (extarticle)
%% font, mathfont, sans, mono и *scale - передаются в fontselector;
%%                 под pdfLaTeX font=newcm заменяется на CM (пусто)
%% upgreek       - прямые греческие буквы
%% thmcounter    - shared (общая нумерация теорем, лемм и т.д.)
%%               | separate (свои счетчики, как в cmcmsugost-extra)
%% numberwithin  - section | none: нумерация формул и теорем
%% enblock       - after | end | none: где печатать английскую
%%                 аннотацию (после русской / в конце / нигде)
%% baselinestretch - межстрочный множитель (1, 1.5, 2, ...)
%% lineno        - нумерация строк (для рецензирования)
%% runninghead   - none | title | full: колонтитул
%%                 none  - только номер страницы (по умолчанию);
%%                 title - краткое название на каждой странице;
%%                 full  - авторы и название (при нехватке места
%%                         чередуются по четности страницы)
%%                 Можно задать и через \articlesetup{runninghead=...}
%% rumathop, biber, listings, alg - передаются в cmcmsugost-extra
%% draft         - черновик (без microtype, draft у extarticle)
%% Прочие опции (twoside, a4paper, leqno, ...) уходят в extarticle.
\DeclareStringOption[12pt]{fontsize}

\DeclareStringOption[newcm]{font}
\DeclareStringOption[1]{fontscale}
\DeclareStringOption[]{mathfont}
\DeclareStringOption[1]{mathfontscale}
\DeclareStringOption[]{sans}
\DeclareStringOption[1]{sansscale}
\DeclareStringOption[]{mono}
\DeclareStringOption[1]{monoscale}
\DeclareBoolOption[false]{upgreek}

\DeclareStringOption[shared]{thmcounter}
\DeclareStringOption[section]{numberwithin}
\DeclareStringOption[after]{enblock}
\DeclareStringOption[1]{baselinestretch}
\DeclareBoolOption[false]{lineno}
\DeclareStringOption[none]{runninghead}

\DeclareBoolOption[true]{rumathop}
\DeclareBoolOption[true]{biber}
\DeclareBoolOption[true]{listings}
\DeclareStringOption[2e]{alg}

\DeclareBoolOption[false]{draft}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{extarticle}}

\ProcessKeyvalOptions{cmcmsuart}

% ================================================================
% Базовый класс
% ================================================================
\ifcmcmsuart@draft
    \PassOptionsToClass{draft}{extarticle}
\fi
\LoadClass[\cmcmsuart@fontsize]{extarticle}

% ================================================================
% Шрифты, язык, математика
% ================================================================
%% Под pdfLaTeX набора newcm нет — используем Computer Modern
\ifPDFTeX
    \def\cmcmsuart@tmp{newcm}%
    \ifx\cmcmsuart@font\cmcmsuart@tmp
        \def\cmcmsuart@font{}%
    \fi
\fi

\ifcmcmsuart@draft
    \def\cmcmsuart@microtype{false}
\else
    \def\cmcmsuart@microtype{true}
\fi
\ifcmcmsuart@upgreek
    \def\cmcmsuart@upgreekval{true}
\else
    \def\cmcmsuart@upgreekval{false}
\fi

\RequirePackage[%
    font=\cmcmsuart@font,
    fontscale=\cmcmsuart@fontscale,
    mathfont=\cmcmsuart@mathfont,
    mathfontscale=\cmcmsuart@mathfontscale,
    sans=\cmcmsuart@sans,
    sansscale=\cmcmsuart@sansscale,
    mono=\cmcmsuart@mono,
    monoscale=\cmcmsuart@monoscale,
    upgreek=\cmcmsuart@upgreekval,
    microtype=\cmcmsuart@microtype
]{cmcmsugost-fontselector}

%% Теоремы: при общей нумерации определяем их сами,
%% иначе отдаем cmcmsugost-extra
\def\cmcmsuart@tmp{shared}
\ifx\cmcmsuart@thmcounter\cmcmsuart@tmp
    \def\cmcmsuart@extrathm{false}
\else
    \def\cmcmsuart@extrathm{true}
\fi
\ifcmcmsuart@rumathop \def\cmcmsuart@tmpa{true}\else \def\cmcmsuart@tmpa{false}\fi
\ifcmcmsuart@biber    \def\cmcmsuart@tmpb{true}\else \def\cmcmsuart@tmpb{false}\fi
\ifcmcmsuart@listings \def\cmcmsuart@tmpc{true}\else \def\cmcmsuart@tmpc{false}\fi

\RequirePackage[%
    rumathop=\cmcmsuart@tmpa,
    thm=\cmcmsuart@extrathm,
    extramath=true,
    listings=\cmcmsuart@tmpc,
    biber=\cmcmsuart@tmpb,
    alg=\cmcmsuart@alg
]{cmcmsugost-extra}
%% Код набирается относительным размером, а не фиксированным 12pt.
%% listings с mathescape применяет стиль и внутри $...$, где \small
%% запрещен, поэтому в математике размер не трогаем.
\newcommand{\cmcmsuart@codefont}{\ifmmode\else\small\fi}
\cmcmsugostextrasetup{codefont=\cmcmsuart@codefont}

% ================================================================
% Пакеты
% ================================================================
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{indentfirst}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage[
    a4paper,
    top=2.5cm,
    bottom=2.5cm,
    left=2.5cm,
    right=2.5cm,
    headsep=0.8cm,
    footskip=1.2cm
]{geometry}

% ================================================================
% Верстка абзацев
% ================================================================
\tolerance=1414\relax
\emergencystretch=1.5em\relax
\hfuzz=0.3pt\relax
\clubpenalty=10000
\widowpenalty=10000
\brokenpenalty=4991
\AtEndPreamble{\setstretch{\cmcmsuart@baselinestretch}}

% ================================================================
% Русские буквы для нумерации (без е, з, й, о, ч, ъ, ы, ь)
% ================================================================
\ifPDFTeX
    \def\cmcmsuart@RuAlph#1{\ifcase#1\or
            \CYRA\or\CYRB\or\CYRV\or\CYRG\or\CYRD\or\CYRE\or\CYRZH\or
            \CYRI\or\CYRK\or\CYRL\or\CYRM\or\CYRN\or
            \CYRP\or\CYRR\or\CYRS\or\CYRT\or\CYRU\or\CYRF\or\CYRH\or
            \CYRC\or\CYRSH\or\CYRSHCH\or\CYREREV\or\CYRYU\or\CYRYA%
        \else\@ctrerr\fi}
    \def\cmcmsuart@rualph#1{\ifcase#1\or
            \cyra\or\cyrb\or\cyrv\or\cyrg\or\cyrd\or\cyre\or\cyrzh\or
            \cyri\or\cyrk\or\cyrl\or\cyrm\or\cyrn\or
            \cyrp\or\cyrr\or\cyrs\or\cyrt\or\cyru\or\cyrf\or\cyrh\or
            \cyrc\or\cyrsh\or\cyrshch\or\cyrerev\or\cyryu\or\cyrya%
        \else\@ctrerr\fi}
\else
    \def\cmcmsuart@RuAlph#1{\ifcase#1\or
            А\or Б\or В\or Г\or Д\or Е\or Ж\or
            И\or К\or Л\or М\or Н\or
            П\or Р\or С\or Т\or У\or Ф\or Х\or
            Ц\or Ш\or Щ\or Э\or Ю\or Я%
        \else\@ctrerr\fi}
    \def\cmcmsuart@rualph#1{\ifcase#1\or
            а\or б\or в\or г\or д\or е\or ж\or
            и\or к\or л\or м\or н\or
            п\or р\or с\or т\or у\or ф\or х\or
            ц\or ш\or щ\or э\or ю\or я%
        \else\@ctrerr\fi}
\fi
\newcommand*{\RuAlph}[1]{\expandafter\cmcmsuart@RuAlph\csname c@#1\endcsname}
\newcommand*{\rualph}[1]{\expandafter\cmcmsuart@rualph\csname c@#1\endcsname}

% ================================================================
% Заголовки разделов: «1. Введение», «1.1. Обозначения»
% ================================================================
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus .2ex}%
  {\normalfont\large\bfseries\raggedright}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
    {-3.25ex \@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\normalfont\normalsize\bfseries\raggedright}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
    {-3.25ex \@plus -1ex \@minus -.2ex}%
    {1ex \@plus .2ex}%
    {\normalfont\normalsize\bfseries\itshape\raggedright}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\parindent}%
    {1.5ex \@plus 1ex \@minus .2ex}%
    {-1em}%
    {\normalfont\normalsize\bfseries}}

\renewcommand\@seccntformat[1]{\csname the#1\endcsname.\quad}

% Приложения: «Приложение А. Название»
\providecommand{\appendixname}{Приложение}
\renewcommand\appendix{\par
    \setcounter{section}{0}%
    \setcounter{subsection}{0}%
    \gdef\thesection{\RuAlph{section}}%
    \gdef\theHsection{appendix.\arabic{section}}%
    \gdef\@seccntformat##1{%
        \ifstrequal{##1}{section}{\appendixname~}{}%
        \csname the##1\endcsname.\quad}%
}

% ================================================================
% Нумерация формул и теорем
% ================================================================
\def\cmcmsuart@tmp{section}
\ifx\cmcmsuart@numberwithin\cmcmsuart@tmp
    \counterwithin{equation}{section}
    \def\cmcmsuart@thmparent{section}
\else
    \def\cmcmsuart@thmparent{}
\fi

\newcommand{\cmcmsuart@SetSharedTheorems}{%
    \RequirePackage{amsthm}%
    \theoremstyle{plain}%
    \ifx\cmcmsuart@thmparent\@empty
        \newtheorem{theorem}{Теорема}%
    \else
        \newtheorem{theorem}{Теорема}[section]%
    \fi
    \newtheorem{lemma}[theorem]{Лемма}%
    \newtheorem{proposition}[theorem]{Утверждение}%
    \newtheorem{corollary}[theorem]{Следствие}%
    \newtheorem{conjecture}[theorem]{Гипотеза}%
    \newtheorem*{theorem*}{Теорема}%
    \newtheorem*{lemma*}{Лемма}%
    \newtheorem*{proposition*}{Утверждение}%
    \newtheorem*{conjecture*}{Гипотеза}%
    \theoremstyle{definition}%
    \newtheorem{definition}[theorem]{Определение}%
    \newtheorem{example}[theorem]{Пример}%
    \newtheorem{exmpl}[theorem]{Пример}%
    \newtheorem{problem}[theorem]{Задача}%
    \newtheorem*{definition*}{Определение}%
    \newtheorem*{example*}{Пример}%
    \theoremstyle{remark}%
    \newtheorem{remark}[theorem]{Замечание}%
    \newtheorem*{remark*}{Замечание}%
}
\def\cmcmsuart@tmp{shared}
\ifx\cmcmsuart@thmcounter\cmcmsuart@tmp
    \AtEndPreamble{\cmcmsuart@SetSharedTheorems}
\fi

% ================================================================
% Списки, подписи
% ================================================================
\AddEnumerateCounter{\rualph}{\cmcmsuart@rualph}{щ}
\setlist{
    topsep=0.5ex plus 0.2ex,
    itemsep=0.2ex plus 0.1ex,
    parsep=0pt,
    labelindent=\parindent,
    leftmargin=*
}
\setlist[itemize]{label=\normalfont\bfseries --}
\setlist[enumerate,1]{label=\arabic*)}
\setlist[enumerate,2]{label=\rualph*)}

\captionsetup{
    font=small,
    labelsep=period,
    justification=centerlast,
    skip=0.6\baselineskip
}
\captionsetup[table]{position=above}

% ================================================================
% Метаданные статьи
% ================================================================
\ExplSyntaxOn

\tl_new:N \g__cmcmsuart_udk_tl
\tl_new:N \g__cmcmsuart_msc_tl
\tl_new:N \g__cmcmsuart_keywords_tl
\tl_new:N \g__cmcmsuart_enkeywords_tl
\tl_new:N \g__cmcmsuart_entitle_tl
\tl_new:N \g__cmcmsuart_shorttitle_tl
\tl_new:N \g__cmcmsuart_shortauthors_tl
\tl_new:N \g__cmcmsuart_enshortauthors_tl
\tl_new:N \g__cmcmsuart_funding_tl
\tl_new:N \g__cmcmsuart_enfunding_tl
\tl_new:N \g__cmcmsuart_abstract_tl
\tl_new:N \g__cmcmsuart_enabstract_tl
\bool_new:N \g__cmcmsuart_titlemade_bool

\keys_define:nn { cmcmsuart / setup }
{
    udk            .tl_gset:N = \g__cmcmsuart_udk_tl ,
    msc            .tl_gset:N = \g__cmcmsuart_msc_tl ,
    keywords       .tl_gset:N = \g__cmcmsuart_keywords_tl ,
    enkeywords     .tl_gset:N = \g__cmcmsuart_enkeywords_tl ,
    entitle        .tl_gset:N = \g__cmcmsuart_entitle_tl ,
    shorttitle     .tl_gset:N = \g__cmcmsuart_shorttitle_tl ,
    shortauthors   .tl_gset:N = \g__cmcmsuart_shortauthors_tl ,
    enshortauthors .tl_gset:N = \g__cmcmsuart_enshortauthors_tl ,
    funding        .tl_gset:N = \g__cmcmsuart_funding_tl ,
    enfunding      .tl_gset:N = \g__cmcmsuart_enfunding_tl ,
    runninghead    .tl_gset:N = \cmcmsuart@runninghead ,
}
\NewDocumentCommand \articlesetup { m }
{ \keys_set:nn { cmcmsuart / setup } {#1} }

% ---------- Организации ----------
%% \addaffiliation[en={English name}]{метка}{Название}
\int_new:N \g__cmcmsuart_affil_int
\prop_new:N \g__cmcmsuart_affil_num_prop   % метка -> номер
\prop_new:N \g__cmcmsuart_affil_ru_prop    % номер -> текст
\prop_new:N \g__cmcmsuart_affil_en_prop    % номер -> текст (англ.)
\tl_new:N \l__cmcmsuart_en_tl
\keys_define:nn { cmcmsuart / affil }
{ en .tl_set:N = \l__cmcmsuart_en_tl }

\NewDocumentCommand \addaffiliation { O{} m m }
{
    \group_begin:
    \keys_set:nn { cmcmsuart / affil } {#1}
    \int_gincr:N \g__cmcmsuart_affil_int
    \prop_gput:NnV \g__cmcmsuart_affil_num_prop {#2} \g__cmcmsuart_affil_int
    \prop_gput:Nen \g__cmcmsuart_affil_ru_prop
    { \int_use:N \g__cmcmsuart_affil_int } {#3}
    \prop_gput:NeV \g__cmcmsuart_affil_en_prop
    { \int_use:N \g__cmcmsuart_affil_int } \l__cmcmsuart_en_tl
    \group_end:
}

% ---------- Авторы ----------
%% \addauthor[affil={msu,kr}, email={...}, en={I.\,V.~Chizhov}]{И.\,В.~Чижов}
\int_new:N \g__cmcmsuart_author_int
\prop_new:N \g__cmcmsuart_author_prop      % <n>/name, <n>/en, <n>/affil, <n>/email
\tl_new:N \l__cmcmsuart_affil_tl
\tl_new:N \l__cmcmsuart_email_tl
\keys_define:nn { cmcmsuart / author }
{
    affil .tl_set:N = \l__cmcmsuart_affil_tl ,
    email .tl_set:N = \l__cmcmsuart_email_tl ,
    en    .tl_set:N = \l__cmcmsuart_en_tl ,
}

\NewDocumentCommand \addauthor { O{} m }
{
    \group_begin:
    \keys_set:nn { cmcmsuart / author } {#1}
    \int_gincr:N \g__cmcmsuart_author_int
    \tl_set:Ne \l_tmpa_tl { \int_use:N \g__cmcmsuart_author_int }
    \prop_gput:Nen \g__cmcmsuart_author_prop { \l_tmpa_tl / name  } {#2}
    \prop_gput:NeV \g__cmcmsuart_author_prop { \l_tmpa_tl / en    } \l__cmcmsuart_en_tl
    \prop_gput:NeV \g__cmcmsuart_author_prop { \l_tmpa_tl / affil } \l__cmcmsuart_affil_tl
    \prop_gput:NeV \g__cmcmsuart_author_prop { \l_tmpa_tl / email } \l__cmcmsuart_email_tl
    \group_end:
}

\cs_generate_variant:Nn \prop_gput:Nnn { Nen , NeV , NnV }

% Значение поля автора
\cs_new:Npn \__cmcmsuart_author_field:nn #1#2
{ \prop_item:Ne \g__cmcmsuart_author_prop { #1 / #2 } }
\cs_generate_variant:Nn \prop_item:Nn { Ne }

% Верхние индексы организаций автора n
\seq_new:N \l__cmcmsuart_marks_seq
\cs_new_protected:Npn \__cmcmsuart_affil_marks:n #1
{
    \int_compare:nNnT { \g__cmcmsuart_affil_int } > { 1 }
        {
            \seq_clear:N \l__cmcmsuart_marks_seq
            \tl_set:Ne \l_tmpb_tl { \__cmcmsuart_author_field:nn {#1} { affil } }
            \clist_map_inline:Nn \l_tmpb_tl
            {
                \prop_get:NnNTF \g__cmcmsuart_affil_num_prop {##1} \l_tmpa_tl
                { \seq_put_right:NV \l__cmcmsuart_marks_seq \l_tmpa_tl }
                {
                    \msg_error:nnn { cmcmsuarticle } { unknown-affil } {##1}
                }
            }
            \seq_if_empty:NF \l__cmcmsuart_marks_seq
            { \textsuperscript { \seq_use:Nn \l__cmcmsuart_marks_seq { , } } }
        }
}
\msg_new:nnn { cmcmsuarticle } { unknown-affil }
{ Unknown~affiliation~label~'#1'.~Use~\addaffiliation~first. }

% Список авторов; #1 = name | en
\cs_new_protected:Npn \__cmcmsuart_author_list:n #1
{
    \int_step_inline:nn { \g__cmcmsuart_author_int }
    {
        \int_compare:nNnT {##1} > {1} { ,~ }
        \mbox
        {
            \tl_set:Ne \l_tmpa_tl { \__cmcmsuart_author_field:nn {##1} {#1} }
            \tl_if_empty:NT \l_tmpa_tl
            { \tl_set:Ne \l_tmpa_tl { \__cmcmsuart_author_field:nn {##1} { name } } }
            \tl_use:N \l_tmpa_tl
            \__cmcmsuart_affil_marks:n {##1}
        }
    }
}

% Краткий список авторов для колонтитула и pdfauthor
\cs_new:Npn \__cmcmsuart_plain_authors:n #1
{
    \int_step_function:nN { \g__cmcmsuart_author_int }
    \__cmcmsuart_plain_author_aux:n
}
\cs_new:Npn \__cmcmsuart_plain_author_aux:n #1
{
    \int_compare:nNnT {#1} > {1} { ,~ }
    \__cmcmsuart_author_field:nn {#1} { name }
}

% Список организаций; #1 = ru | en
\cs_new_protected:Npn \__cmcmsuart_affil_list:n #1
{
    \int_step_inline:nn { \g__cmcmsuart_affil_int }
    {
        \tl_set:Ne \l_tmpa_tl
        { \prop_item:ce { g__cmcmsuart_affil_ #1 _prop } {##1} }
        \str_if_eq:nnT {#1} { en }
        {
            \tl_if_empty:NT \l_tmpa_tl
            { \tl_set:Ne \l_tmpa_tl { \prop_item:Ne \g__cmcmsuart_affil_ru_prop {##1} } }
        }
        \int_compare:nNnT { \g__cmcmsuart_affil_int } > { 1 }
            { \textsuperscript{##1}\, }
        \tl_use:N \l_tmpa_tl \par
    }
}
\cs_generate_variant:Nn \prop_item:Nn { ce }

% Список e-mail
\seq_new:N \l__cmcmsuart_emails_seq
\cs_new_protected:Npn \__cmcmsuart_email_list:
{
    \seq_clear:N \l__cmcmsuart_emails_seq
    \int_step_inline:nn { \g__cmcmsuart_author_int }
    {
        \tl_set:Ne \l_tmpa_tl { \__cmcmsuart_author_field:nn {##1} { email } }
        \tl_if_empty:NF \l_tmpa_tl
        {
            \seq_put_right:Ne \l__cmcmsuart_emails_seq
            {
                \exp_not:N \href { mailto: \exp_not:V \l_tmpa_tl }
                { \exp_not:N \nolinkurl { \exp_not:V \l_tmpa_tl } }
            }
        }
    }
    \seq_if_empty:NF \l__cmcmsuart_emails_seq
    { \emailname :~\seq_use:Nn \l__cmcmsuart_emails_seq { ,~ } \par }
}

% ---------- Аннотации ----------
%% До \maketitle окружение запоминает текст, после — печатает сразу.
\RenewDocumentEnvironment { abstract } { +b }
{
    \bool_if:NTF \g__cmcmsuart_titlemade_bool
    { \__cmcmsuart_abstract_box:nnnn { \ruabstractname } {#1} { \keywordsname } {} }
    { \tl_gset:Nn \g__cmcmsuart_abstract_tl {#1} }
} { }
\NewDocumentEnvironment { enabstract } { +b }
{
    \bool_if:NTF \g__cmcmsuart_titlemade_bool
    {
        \begin{otherlanguage}{english}
            \__cmcmsuart_abstract_box:nnnn { \enabstractname } {#1} { \enkeywordsname } {}
        \end{otherlanguage}
    }
    { \tl_gset:Nn \g__cmcmsuart_enabstract_tl {#1} }
} { }

%% #1 заголовок, #2 текст, #3 «Ключевые слова», #4 ключевые слова
\cs_new_protected:Npn \__cmcmsuart_abstract_box:nnnn #1#2#3#4
{
    \begin{list}{}
        {
            \setlength{\leftmargin}{2em}
            \setlength{\rightmargin}{2em}
            \setlength{\topsep}{0pt}
            \setlength{\parsep}{0.4ex}
            \setlength{\listparindent}{1.5em}
        }
        \small \item \relax
              \tl_if_blank:nF {#2} { \textbf{#1.}~ #2 \par }
              \tl_if_blank:nF {#4}
              { \smallskip \noindent \textbf{#3:}~ #4 \par }
    \end{list}
}

\cs_generate_variant:Nn \__cmcmsuart_abstract_box:nnnn { nVnV , nnnV }

% ---------- Титульный блок ----------
\cs_new_protected:Npn \__cmcmsuart_ru_block:
{
    \tl_if_empty:NF \g__cmcmsuart_udk_tl
    { \noindent { \small \udkname \nobreakspace \g__cmcmsuart_udk_tl } \par \medskip }
    \begin{center}
        { \Large \bfseries \@title \par }
        \vskip 1.2em
            { \large
                \int_compare:nNnTF { \g__cmcmsuart_author_int } > { 0 }
                    { \__cmcmsuart_author_list:n { name } }
                    { \@author }
                \par }
        \vskip 0.8em
            { \small \itshape \__cmcmsuart_affil_list:n { ru } }
            { \small \__cmcmsuart_email_list: }
    \end{center}
    \vskip 0.5em
    \__cmcmsuart_abstract_box:nVnV
    { \ruabstractname } \g__cmcmsuart_abstract_tl
    { \keywordsname } \g__cmcmsuart_keywords_tl
    \tl_if_empty:NF \g__cmcmsuart_msc_tl
    {
        \__cmcmsuart_abstract_box:nnnV {} {} { \mscname }
        \g__cmcmsuart_msc_tl
    }
}

\cs_new_protected:Npn \__cmcmsuart_en_block:
{
    \bool_lazy_and:nnF
    { \tl_if_empty_p:N \g__cmcmsuart_entitle_tl }
    { \tl_if_empty_p:N \g__cmcmsuart_enabstract_tl }
    {
        \begin{otherlanguage}{english}
            \tl_if_empty:NF \g__cmcmsuart_entitle_tl
            {
                \begin{center}
                    { \large \bfseries \g__cmcmsuart_entitle_tl \par }
                    \vskip 0.8em
                    \int_compare:nNnT { \g__cmcmsuart_author_int } > { 0 }
                        {
                            { \__cmcmsuart_author_list:n { en } \par }
                            \vskip 0.5em
                                { \small \itshape \__cmcmsuart_affil_list:n { en } }
                        }
                \end{center}
            }
            \__cmcmsuart_abstract_box:nVnV
            { \enabstractname } \g__cmcmsuart_enabstract_tl
            { \enkeywordsname } \g__cmcmsuart_enkeywords_tl
        \end{otherlanguage}
    }
}

\cs_new_protected:Npn \__cmcmsuart_funding:
{
    \tl_if_empty:NF \g__cmcmsuart_funding_tl
    {
        \group_begin:
        \cs_set_eq:NN \thefootnote \relax
        \footnotetext { \g__cmcmsuart_funding_tl }
        \group_end:
    }
}

\RenewDocumentCommand \maketitle { }
{
    \par
    \thispagestyle{plain}
    \int_compare:nNnT { \g__cmcmsuart_author_int } > { 0 }
        { \hypersetup { pdfauthor = { \__cmcmsuart_plain_authors:n { } } } }
\hypersetup { pdftitle = { \@title } }
\group_begin:
\__cmcmsuart_ru_block:
\group_end:
\__cmcmsuart_funding:
\bool_gset_true:N \g__cmcmsuart_titlemade_bool
\str_if_eq:VnT \cmcmsuart@enblock { after }
{
    \bigskip
    \group_begin:
    \__cmcmsuart_en_block:
    \tl_if_empty:NF \g__cmcmsuart_enfunding_tl
    { \begin{otherlanguage}{english} \noindent \small \g__cmcmsuart_enfunding_tl \par \end{otherlanguage} }
    \group_end:
}
\bigskip
}

\str_if_eq:VnT \cmcmsuart@enblock { end }
{
    \AtEndDocument
    {
        \par \bigskip
        \__cmcmsuart_en_block:
        \tl_if_empty:NF \g__cmcmsuart_enfunding_tl
        { \begin{otherlanguage}{english} \noindent \small \g__cmcmsuart_enfunding_tl \par \end{otherlanguage} }
    }
}

% ---------- Колонтитулы ----------
\cs_new:Npn \cmcmsuart@headauthors
{
    \tl_if_empty:NTF \g__cmcmsuart_shortauthors_tl
    {
        \int_compare:nNnTF { \g__cmcmsuart_author_int } > { 0 }
            { \__cmcmsuart_plain_authors:n { } }
            { \@author }
    }
    { \g__cmcmsuart_shortauthors_tl }
}
\cs_new:Npn \cmcmsuart@headtitle
{
    \tl_if_empty:NTF \g__cmcmsuart_shorttitle_tl
    { \@title }
    { \g__cmcmsuart_shorttitle_tl }
}

\ExplSyntaxOff

% Названия (можно переопределить через \renewcommand)
\newcommand{\udkname}{УДК}
\newcommand{\keywordsname}{Ключевые слова}
\newcommand{\mscname}{MSC2020}
\newcommand{\emailname}{E-mail}
\newcommand{\enabstractname}{Abstract}
\newcommand{\enkeywordsname}{Keywords}
\newcommand{\ruabstractname}{Аннотация}

% Колонтитул собирается в одну строку шириной \headwidth.
%  - twoside: авторы на четных страницах, название на нечетных;
%  - oneside: авторы слева, название справа, а если вместе они
%    не помещаются, то чередуются по четности страницы;
%  - слишком длинная часть обрезается с многоточием
%    (задайте shorttitle / shortauthors в \articlesetup).
\RequirePackage[fit]{truncate}
\renewcommand{\TruncateMarker}{\,\ldots}
\newcommand{\cmcmsuart@headfont}{\small\itshape}
\newlength{\cmcmsuart@headgap}
\setlength{\cmcmsuart@headgap}{2em}
\newif\ifcmcmsuart@headwarned

\newcommand{\cmcmsuart@headpart}[1]{%
    \sbox\z@{\cmcmsuart@headfont#1}%
    \ifdim\wd\z@>\headwidth
        \ifcmcmsuart@headwarned\else
            \global\cmcmsuart@headwarnedtrue
            \ClassWarningNoLine{cmcmsuarticle}{%
                Running head is too long and was truncated.\MessageBreak
                Set shorttitle/shortauthors in \string\articlesetup}%
        \fi
        \truncate{\headwidth}{\cmcmsuart@headfont#1}%
    \else
        \usebox\z@
    \fi
}
% runninghead=title: краткое название справа (в twoside - снаружи)
\newcommand{\cmcmsuart@headline@title}{%
    \if@twoside
        \ifodd\value{page}%
            \hfill\cmcmsuart@headpart{\cmcmsuart@headtitle}%
        \else
            \cmcmsuart@headpart{\cmcmsuart@headtitle}\hfill
        \fi
    \else
        \hfill\cmcmsuart@headpart{\cmcmsuart@headtitle}%
    \fi
}
% runninghead=full: авторы и название
\newcommand{\cmcmsuart@headline@full}{%
    \if@twoside
        \ifodd\value{page}%
            \hfill\cmcmsuart@headpart{\cmcmsuart@headtitle}%
        \else
            \cmcmsuart@headpart{\cmcmsuart@headauthors}\hfill
        \fi
    \else
        \sbox\z@{\cmcmsuart@headfont\cmcmsuart@headauthors}%
        \sbox\tw@{\cmcmsuart@headfont\cmcmsuart@headtitle}%
        \ifdim\dimexpr\wd\z@+\wd\tw@+\cmcmsuart@headgap\relax>\headwidth
            \ifodd\value{page}%
                \hfill\cmcmsuart@headpart{\cmcmsuart@headtitle}%
            \else
                \cmcmsuart@headpart{\cmcmsuart@headauthors}\hfill
            \fi
        \else
            \usebox\z@\hfill\usebox\tw@
        \fi
    \fi
}

\fancypagestyle{plain}{%
    \fancyhf{}%
    \fancyfoot[C]{\thepage}%
    \renewcommand{\headrulewidth}{0pt}%
}
\fancypagestyle{cmcmsuart@running}{%
    \fancyhf{}%
    \fancyhead[C]{\makebox[\headwidth][s]{\cmcmsuart@headline}}%
    \fancyfoot[C]{\thepage}%
    \renewcommand{\headrulewidth}{0.4pt}%
}
% Стиль выбирается в начале документа, чтобы учесть \articlesetup
\AtBeginDocument{%
    \ifcsname cmcmsuart@headline@\cmcmsuart@runninghead\endcsname
        \expandafter\let\expandafter\cmcmsuart@headline
        \csname cmcmsuart@headline@\cmcmsuart@runninghead\endcsname
        \pagestyle{cmcmsuart@running}%
    \else
        \def\cmcmsuart@tmp{none}%
        \ifx\cmcmsuart@runninghead\cmcmsuart@tmp\else
            \ClassError{cmcmsuarticle}{%
                Unknown runninghead '\cmcmsuart@runninghead'}{%
                Valid values are: none, title, full}%
        \fi
        \pagestyle{plain}%
    \fi
}
\AtEndPreamble{\setlength{\headheight}{1.2\baselineskip}}

% ================================================================
% Нумерация строк (опция lineno)
% ================================================================
\ifcmcmsuart@lineno
    \RequirePackage{lineno}
    \renewcommand{\linenumberfont}{\normalfont\tiny\color{gray}}
    \newcommand{\cmcmsuart@patchlineno}[1]{%
        \ifcsname #1\endcsname
            \expandafter\let\csname cmcmsuart@old#1\expandafter\endcsname
            \csname #1\endcsname
            \expandafter\let\csname cmcmsuart@oldend#1\expandafter\endcsname
            \csname end#1\endcsname
            \expandafter\def\csname #1\endcsname{%
                \linenomath\csname cmcmsuart@old#1\endcsname}%
            \expandafter\def\csname end#1\endcsname{%
                \csname cmcmsuart@oldend#1\endcsname\endlinenomath}%
        \fi}
    \AtBeginDocument{%
        \ifdefined\linenomathpatchAMS
            \linenomathpatchAMS
        \else
            \cmcmsuart@patchlineno{equation}%
            \cmcmsuart@patchlineno{equation*}%
            \cmcmsuart@patchlineno{align}%
            \cmcmsuart@patchlineno{align*}%
            \cmcmsuart@patchlineno{gather}%
            \cmcmsuart@patchlineno{gather*}%
            \cmcmsuart@patchlineno{multline}%
            \cmcmsuart@patchlineno{multline*}%
            \cmcmsuart@patchlineno{flalign}%
            \cmcmsuart@patchlineno{flalign*}%
        \fi
        \linenumbers
    }
\fi

% ================================================================
% Гиперссылки
% ================================================================
\RequirePackage{hyperref}
\definecolor{linkcolor}{RGB}{0, 40, 100}
\definecolor{urlcolor}{RGB}{0, 0, 140}
\definecolor{citecolor}{RGB}{0, 80, 40}
\hypersetup{
    colorlinks = true,
    linkcolor  = linkcolor,
    urlcolor   = urlcolor,
    citecolor  = citecolor,
    bookmarksnumbered = true,
    pdfdisplaydoctitle = true,
}
\pdfstringdefDisableCommands{\def\ell{ℓ}\def\\{ }}

\makeatother
\endinput
