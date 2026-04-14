# cmcmsuthesis-master.cls — Руководство пользователя

**Версия:** 0.1 от 23 марта 2026 г.

Класс `cmcmsuthesis-master` — производный от `cmcmsuthesis`, предназначенный для оформления **магистерских диссертаций** факультета ВМК МГУ.

---

## 1. Подключение

```latex
\documentclass{cmcmsuthesis-master}
```

Или с опциями:

```latex
\documentclass[font=libertinus, draft]{cmcmsuthesis-master}
```

---

## 2. Что фиксировано

| Параметр | Значение | Пояснение |
|---|---|---|
| `parent` | `extarticle` | Документ без глав (разделы через `\section`) |
| `titlepagesty` | `cmc` | Титульная страница в стиле ВМК |
| `copyright` | *(пусто)* | Надпись «На правах рукописи» убрана |
| `subtitle` | Магистерская диссертация | Подзаголовок на титульной странице |

---

## 3. Опции класса

| Опция | Тип | Умолчание | Описание |
|---|---|---|---|
| `fontsize` | строка | `14pt` | Размер основного шрифта |
| `font` | строка | `modern` | Набор шрифтов (см. документацию `cmcmsugost-fontselector`) |
| `draft` | bool | `false` | Черновой режим |

---

## 4. Полный пример

```latex
\documentclass[font=pt]{cmcmsuthesis-master}

\author{Смирнова Елена Андреевна}
\title{Методы верификации распределённых протоколов
       на основе темпоральных логик}

\thesissetup{
    department = {Кафедра математической кибернетики}
}
\supervisor{
    name = {д-р~физ.-мат.~наук, проф. Козлов~А.Б.}
}

\usepackage{biblatex}
\addbibresource{refs.bib}

\begin{document}

\maketitle
\tableofcontents

\section{Введение}
Верификация распределённых систем является...

\section{Обзор литературы}
Задача верификации рассматривалась в~\cite{clarke1999}.

\section{Основные результаты}

\begin{theorem}\label{thm:decidability}
Задача проверки модели для логики $\mathrm{CTL}^*$
разрешима за время $\compl{O}(|M| \cdot 2^{|\varphi|})$.
\end{theorem}

\section{Заключение}
В работе предложен метод...

\printbibliography[heading=bibintoc]

\end{document}
```

---

## 5. Связь с другими классами комплекта

| Класс | Тип работы | Базовый класс | Титульная | Подзаголовок |
|---|---|---|---|---|
| `cmcmsuthesis-bachelor` | Бакалаврская ВКР | extarticle | cmc | *(задаётся пользователем)* |
| **`cmcmsuthesis-master`** | **Магистерская диссертация** | **extarticle** | **cmc** | **Магистерская диссертация** |
| `cmcmsuthesis` | Универсальный | настраивается | настраивается | настраивается |
