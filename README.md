# cmcmsuthesis — LaTeX-комплект для оформления работ ВМК МГУ

Набор пакетов и классов документов для оформления курсовых, дипломных и диссертационных работ факультета вычислительной математики и кибернетики МГУ в соответствии с требованиями ГОСТ.

## Быстрый старт

```latex
\documentclass{cmcmsuthesis-cw}

\author{Иванов Иван Иванович}
\title{Название работы}
\supervisor{name = {канд.~физ.-мат.~наук, доцент Петров~П.П.}}

\usepackage{biblatex}
\addbibresource{refs.bib}

\begin{document}
\maketitle
\tableofcontents

\section{Введение}
Текст работы.

\printbibliography[heading=bibintoc]
\end{document}
```

Замените `cmcmsuthesis-cw` на нужный класс — и всё оформление настроится автоматически.

## Классы документов

| Класс | Назначение | Разделы | Титульная |
|---|---|---|---|
| [`cmcmsuthesis-cw`](docs/cmcmsuthesis-cw-manual.md) | Курсовая работа | `\section` | ВМК |
| [`cmcmsuthesis-bachelor`](docs/cmcmsuthesis-bachelor-manual.md) | Бакалаврская ВКР | `\section` | ВМК |
| [`cmcmsuthesis-master`](docs/cmcmsuthesis-master-manual.md) | Магистерская диссертация | `\section` | ВМК |
| [`cmcmsuthesis-phd`](docs/cmcmsuthesis-phd-manual.md) | Кандидатская диссертация | `\chapter` | ГОСТ |
| [`cmcmsuthesis-doctoral`](docs/cmcmsuthesis-doctoral-manual.md) | Докторская диссертация | `\chapter` | ГОСТ |
| [`cmcmsuthesis`](docs/cmcmsuthesis-manual.md) | Универсальный (ручная настройка) | настраивается | настраивается |

Каждый специализированный класс наследует от [`cmcmsuthesis`](docs/cmcmsuthesis-manual.md) и фиксирует базовый класс, стиль титульной страницы и подзаголовок. Пользователю остаётся указать автора, название и руководителя.

### Общие опции классов

```latex
\documentclass[
    font     = libertinus,   % набор шрифтов (см. ниже)
    fontsize = 14pt,         % размер шрифта (по умолчанию 14pt)
    draft                    % черновой режим
]{cmcmsuthesis-bachelor}
```

### Метаданные

```latex
\author{ФИО студента}
\title{Название работы}
\subtitle{Выпускная квалификационная работа бакалавра}

\thesissetup{
    university = {МГУ имени М.В.\,Ломоносова},
    faculty    = {Факультет ВМК},
    department = {Кафедра ...},
    state      = Москва
}

\supervisor{name = {уч.~степень, уч.~звание ФИО}}

% Только для стиля gost (phd, doctoral):
\specialty{code = {1.2.3}, name = {название специальности}}
```

## Архитектура

Комплект состоит из трёх слоёв пакетов и надстройки классов:

```
┌─────────────────────────────────────────────────┐
│           Классы документов (cls)                │
│  cw · bachelor · master · phd · doctoral        │
│                    │                             │
│              cmcmsuthesis                        │
│         (базовый класс + титульная)              │
└───────────┬─────────┬──────────┬────────────────┘
            │         │          │
     ┌──────▼──┐ ┌────▼────┐ ┌──▼──────────────┐
     │  gost   │ │  font-  │ │     extra        │
     │         │ │ selector│ │                  │
     │ геомет- │ │         │ │ теоремы          │
     │ рия,    │ │ шрифты, │ │ алгоритмы        │
     │ заголов-│ │ матема- │ │ листинги         │
     │ ки, ToC,│ │ тика,   │ │ библиография     │
     │ списки, │ │ язык    │ │ мат. операторы   │
     │ подписи │ │         │ │ доп. команды     │
     └─────────┘ └─────────┘ └─────────────────┘
```

### Пакеты

| Пакет | Назначение | Документация |
|---|---|---|
| **`cmcmsu-gost`** | Оформление по ГОСТ: геометрия страницы, колонтитулы, заголовки, оглавление, списки, подписи рисунков и таблиц, приложения | [Руководство](docs/cmcmsu-gost-manual.md) |
| **`cmcmsugost-fontselector`** | Выбор шрифтов: 15+ наборов для pdfLaTeX, 20+ наборов для XeLaTeX/LuaLaTeX, математические шрифты, прямые греческие буквы, масштабирование | [Руководство](docs/cmcmsugost-fontselector-manual.md) |
| **`cmcmsugost-extra`** | Дополнительные модули: теоремы, algorithm2e, listings с кириллицей, biblatex по ГОСТ, русские мат. операторы, удобные команды (`\vect`, `\matr`, `\algo`, …) | [Руководство](docs/cmcmsugost-extra-manual.md) |

Пакеты можно использовать **независимо от классов**, подключая их вручную к любому документу.

## Совместимость

| Движок | Поддержка |
|---|---|
| pdfLaTeX | ✔ полная |
| XeLaTeX | ✔ полная |
| LuaLaTeX | ✔ полная |

Минимальная версия LaTeX: 2020-10-01.

## Шрифты

Опция `font` принимает имя готового набора. Несколько примеров:

| pdfLaTeX | XeLaTeX / LuaLaTeX | Описание |
|---|---|---|
| `modern` | `modern` → STIX | Классический Times-подобный |
| `libertinus` | `libertinus` | Libertinus Serif + Math |
| `default` | `default` → NewCM | Computer Modern |
| — | `pt` | PT Serif + PT Sans + PT Mono |
| — | `ebgaramond` | EB Garamond + Garamond Math |
| — | `msoffice` | Times New Roman + Arial + Courier New |

Полный список наборов и отдельных шрифтов — в [документации fontselector](docs/cmcmsugost-fontselector-manual.md).

## Готовые примеры

В папке [`examples/`](examples/) — полноценные шаблоны для каждого типа работы в двух форматах: LaTeX и Org-mode. Каждый пример демонстрирует **все возможности** комплекта: теоремы, формулы, алгоритмы, листинги, таблицы, библиографию, приложения и т.д.

| Пример | Тема | LaTeX | Org-mode |
|---|---|---|---|
| Курсовая | Численные методы ОДУ | [`coursework/main.tex`](examples/coursework/main.tex) | [`coursework/main.org`](examples/coursework/main.org) |
| Бакалаврская ВКР | Машинное обучение, NLP | [`bachelor/main.tex`](examples/bachelor/main.tex) | [`bachelor/main.org`](examples/bachelor/main.org) |
| Магистерская | Алгоритмы на графах | [`master/main.tex`](examples/master/main.tex) | [`master/main.org`](examples/master/main.org) |
| Кандидатская | Теория кодов, криптография | [`phd/main.tex`](examples/phd/main.tex) | [`phd/main.org`](examples/phd/main.org) |
| Докторская | Стохастическое управление | [`doctoral/main.tex`](examples/doctoral/main.tex) | [`doctoral/main.org`](examples/doctoral/main.org) |

Для работы с Org-mode добавьте [`cmcmsuthesis-org.el`](examples/org-setup/cmcmsuthesis-org.el) в ваш `~/.emacs`.

Подробнее — в [README примеров](examples/README.md).

## Установка

### Из репозитория (рекомендуется)

```bash
git clone https://github.com/<user>/cmcmsuthesis-latexstyles.git
```

**Вариант 1 — в папку проекта.** Скопируйте `.sty` и `.cls` файлы рядом с вашим `.tex` документом.

**Вариант 2 — глобальная установка.** Скопируйте в `~/texmf/tex/latex/cmcmsuthesis/` и выполните:

```bash
mktexlsr
```

### Проверка

```bash
kpsewhich cmcmsuthesis.cls
```

## Структура репозитория

```
cmcmsuthesis-latexstyles/
│
├── README.md                           ← этот файл
│
├── cmcmsu-gost.sty                     ← пакет: оформление по ГОСТ
├── cmcmsugost-fontselector.sty         ← пакет: шрифты и математика
├── cmcmsugost-extra.sty                ← пакет: доп. модули
│
├── cmcmsuthesis.cls                    ← базовый класс
├── cmcmsuthesis-cw.cls                 ← класс: курсовая
├── cmcmsuthesis-bachelor.cls           ← класс: бакалавр
├── cmcmsuthesis-master.cls             ← класс: магистр
├── cmcmsuthesis-phd.cls                ← класс: кандидатская
├── cmcmsuthesis-doctoral.cls           ← класс: докторская
│
├── images/                             ← логотипы титульных страниц
│   ├── cmcmsuthesis-cmc.*
│   └── cmcmsuthesis-gost.*
│
├── docs/                               ← документация
│   ├── cmcmsu-gost-manual.md           ← пакет gost
│   ├── cmcmsugost-fontselector-manual.md ← пакет fontselector
│   ├── cmcmsugost-extra-manual.md      ← пакет extra
│   ├── cmcmsuthesis-manual.md          ← базовый класс
│   ├── cmcmsuthesis-cw-manual.md       ← класс курсовой
│   ├── cmcmsuthesis-bachelor-manual.md ← класс бакалавра
│   ├── cmcmsuthesis-master-manual.md   ← класс магистра
│   ├── cmcmsuthesis-phd-manual.md      ← класс кандидатской
│   └── cmcmsuthesis-doctoral-manual.md ← класс докторской
│
└── examples/                           ← готовые шаблоны
    ├── README.md                       ← описание примеров
    ├── refs.bib                        ← общая библиография
    ├── org-setup/
    │   └── cmcmsuthesis-org.el         ← настройка Emacs
    ├── coursework/
    │   ├── main.tex
    │   └── main.org
    ├── bachelor/
    │   ├── main.tex
    │   └── main.org
    ├── master/
    │   ├── main.tex
    │   └── main.org
    ├── phd/
    │   ├── main.tex
    │   └── main.org
    └── doctoral/
        ├── main.tex
        └── main.org
```

## Документация

### Пакеты

| Пакет | Что делает | Руководство |
|---|---|---|
| `cmcmsu-gost` | Геометрия страницы A4, колонтитулы, заголовки 14pt, оглавление с точечными лидерами, списки с тире, подписи рисунков/таблиц с тире, приложения с русскими буквами, настройки `hyperref` | [cmcmsu-gost-manual.md](docs/cmcmsu-gost-manual.md) |
| `cmcmsugost-fontselector` | Готовые наборы шрифтов (serif + sans + mono + math), масштабирование, прямые греческие (`\symup`), жирные греческие (`\symbf`, `\symbfup`), `\mathcal` old-style, `microtype` | [cmcmsugost-fontselector-manual.md](docs/cmcmsugost-fontselector-manual.md) |
| `cmcmsugost-extra` | Теоремы (`amsthm`, 9 окружений), `algorithm2e` с русскими подписями, `listings` с кириллицей + стиль `pseudocode` + `lstpseudocode`, `biblatex` по ГОСТ с маппингом полей, русские операторы (tg, ctg, ⩽, ⩾), команды `\vect`, `\matr`, `\algo`, `\compl`, `\crypto` | [cmcmsugost-extra-manual.md](docs/cmcmsugost-extra-manual.md) |

### Классы

| Класс | Что фиксирует | Руководство |
|---|---|---|
| `cmcmsuthesis` | Базовый: загружает все три пакета, метаданные через `pgfkeys`, два стиля титульной (`cmc`/`gost`), цвета ссылок | [cmcmsuthesis-manual.md](docs/cmcmsuthesis-manual.md) |
| `cmcmsuthesis-cw` | `extarticle` + `cmc` + subtitle = «Курсовая работа» | [cmcmsuthesis-cw-manual.md](docs/cmcmsuthesis-cw-manual.md) |
| `cmcmsuthesis-bachelor` | `extarticle` + `cmc` + subtitle задаётся пользователем | [cmcmsuthesis-bachelor-manual.md](docs/cmcmsuthesis-bachelor-manual.md) |
| `cmcmsuthesis-master` | `extarticle` + `cmc` + subtitle = «Магистерская диссертация» | [cmcmsuthesis-master-manual.md](docs/cmcmsuthesis-master-manual.md) |
| `cmcmsuthesis-phd` | `extreport` + `gost` + полное название МГУ + «…кандидата ф.-м. наук» | [cmcmsuthesis-phd-manual.md](docs/cmcmsuthesis-phd-manual.md) |
| `cmcmsuthesis-doctoral` | `extreport` + `gost` + полное название МГУ + «…доктора ф.-м. наук» + «Научный консультант» | [cmcmsuthesis-doctoral-manual.md](docs/cmcmsuthesis-doctoral-manual.md) |

## Компиляция

```bash
# XeLaTeX (рекомендуется)
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex

# pdfLaTeX
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

### Org-mode

1. Добавьте [`cmcmsuthesis-org.el`](examples/org-setup/cmcmsuthesis-org.el) в ваш `~/.emacs`.
2. Откройте `.org` файл.
3. `C-c C-e l p` — экспорт в PDF.

## Минимальные примеры

<details>
<summary><b>Курсовая работа</b></summary>

```latex
\documentclass{cmcmsuthesis-cw}

\author{Иванов Иван Иванович}
\title{Численные методы решения систем линейных уравнений}
\thesissetup{department = {Кафедра вычислительной математики}}
\supervisor{name = {канд.~физ.-мат.~наук, доцент Волков~Н.А.}}

\usepackage{biblatex}
\addbibresource{refs.bib}

\begin{document}
\maketitle
\tableofcontents
\section{Введение}
...
\section{Заключение}
...
\printbibliography
\end{document}
```

</details>

<details>
<summary><b>Бакалаврская ВКР</b></summary>

```latex
\documentclass[font=pt]{cmcmsuthesis-bachelor}

\author{Петрова Мария Сергеевна}
\title{Методы машинного обучения для анализа временных рядов}
\subtitle{Выпускная квалификационная работа бакалавра}
\thesissetup{department = {Кафедра математических методов прогнозирования}}
\supervisor{name = {д-р~физ.-мат.~наук, проф. Сидоров~А.Б.}}

\usepackage{biblatex}
\addbibresource{refs.bib}

\begin{document}
\maketitle
\tableofcontents
\section{Введение}
...
\section{Заключение}
...
\printbibliography
\end{document}
```

</details>

<details>
<summary><b>Магистерская диссертация</b></summary>

```latex
\documentclass[font=libertinus]{cmcmsuthesis-master}

\author{Смирнова Елена Андреевна}
\title{Алгоритмы поиска кратчайших путей в больших графах}
\thesissetup{department = {Кафедра математической кибернетики}}
\supervisor{name = {д-р~физ.-мат.~наук, проф. Иванов~И.И.}}

\usepackage{biblatex}
\addbibresource{refs.bib}

\begin{document}
\maketitle
\tableofcontents
\section{Введение}
...
\section{Заключение}
...
\printbibliography
\end{document}
```

</details>

<details>
<summary><b>Кандидатская диссертация</b></summary>

```latex
\documentclass[font=stix]{cmcmsuthesis-phd}

\author{Сидоров Алексей Михайлович}
\title{Произведение Шура--Адамара линейных кодов}
\supervisor{name = {д-р~физ.-мат.~наук, проф. Чижов~И.В.}}
\specialty{code = {1.2.3}, name = {теоретическая информатика}}

\usepackage{biblatex}
\addbibresource{refs.bib}

\begin{document}
\maketitle
\tableofcontents
\chapter{Введение}
...
\chapter{Заключение}
...
\printbibliography
\end{document}
```

</details>

<details>
<summary><b>Докторская диссертация</b></summary>

```latex
\documentclass[font=ebgaramond]{cmcmsuthesis-doctoral}

\author{Петров Сергей Николаевич}
\title{Теория устойчивости стохастических систем}
\supervisor{name = {академик РАН, проф. Иванов~И.И.}}
\specialty{code = {1.1.5}, name = {математическая физика}}

\usepackage{biblatex}
\addbibresource{refs.bib}

\begin{document}
\maketitle
\tableofcontents
\chapter{Введение}
...
\chapter{Заключение}
...
\printbibliography
\end{document}
```

</details>

## Возможности, демонстрируемые в примерах

Каждый [пример](examples/) включает **полный набор** возможностей комплекта:

**Текст и оформление** — жирный, курсив, жирный курсив, подчёркивание, зачёркивание, sans-serif; ненумерованные введение и заключение; оглавление и список таблиц; два приложения с подразделами.

**Формулы** — inline и display; нумерованные (`equation`); многострочные (`aligned`, `alignedat`, `cases`, `multlined`); субформулы (`subequations` + `gather`/`align` + `\eqref`); система уравнений; матрица с многоточиями; непрерывная дробь; длинная inline формула с переносом (`rmathbr`).

**Греческие буквы** — обычные, прямые (`\symup`), жирные (`\symbf`), жирные прямые (`\symbfup`); математические алфавиты (`\mathcal`, `\mathfrak`, `\mathbb`); русские операторы (tg, ctg, ⩽, ⩾, φ, ε, ϰ, ∅); отступы (`\!`, `\,`, `\;`, `\quad`).

**Окружения** — `theorem`, `definition`, `proposition`, `corollary`, `lemma`, `remark`, `example`, `problem`, `proof`.

**Команды** — `\vect`, `\matr`, `\code`, `\str`, `\elt`, `\algo`, `\compl`, `\crypto`.

**Таблицы** — простая с линейками, `booktabs` с выравниванием, `longtable`.

**Изображения** — обычная вставка, вставка с масштабом (закомментированы, раскомментировать при наличии файлов).

**Списки** — нумерованный (4 уровня), ненумерованный (4 уровня), `beginpenalty`.

**Алгоритмы** — `algorithm2e` (`\KwInput`, `\KwOutput`, `\While`, `\For`, `\uIf`/`\uElseIf`/`\Else`, `\Comment`, `\tcp*`, `\Return`); листинг Python с русскими комментариями; листинг C с русскими комментариями; псевдокод `style=pseudocode` (`\lstInput`, `\lstOutput`); `lstpseudocode` (общий счётчик с `algorithm2e`).

**Библиография** — одиночная и множественная ссылки; `\printbibliography`.

## Лицензия

[MIT](LICENSE)

## Участие в разработке

Вопросы, предложения и pull request'ы приветствуются. При создании issue укажите используемый движок (pdfLaTeX / XeLaTeX / LuaLaTeX) и минимальный воспроизводимый пример.
