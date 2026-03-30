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

\printbibliography
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

### Требования

- TeX Live 2020+ или MiKTeX
- `latexmk` (рекомендуется, обычно входит в TeX Live)
- `biber` (для библиографии по ГОСТ)

### Из репозитория (рекомендуется)

```bash
git clone https://github.com/<user>/cmcmsuthesis-latexstyles.git
```

**Вариант 1 — в папку проекта.** Скопируйте `.sty`, `.cls` и нужный `latexmkrc-*` файл:

```bash
cp cmcmsuthesis-latexstyles/*.sty cmcmsuthesis-latexstyles/*.cls ./
cp cmcmsuthesis-latexstyles/latexmkrc-xelatex .latexmkrc
latexmk main.tex
```

**Вариант 2 — глобальная установка.**

```bash
# Стили и классы
mkdir -p ~/texmf/tex/latex/cmcmsuthesis
cp cmcmsuthesis-latexstyles/*.sty cmcmsuthesis-latexstyles/*.cls \
   ~/texmf/tex/latex/cmcmsuthesis/
mktexlsr

# Конфиг latexmk (глобальный)
mkdir -p ~/.config/latexmk
cp cmcmsuthesis-latexstyles/latexmkrc-xelatex ~/.config/latexmk/latexmkrc
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
├── latexmkrc-xelatex                   ← конфиг latexmk для XeLaTeX
├── latexmkrc-pdflatex                  ← конфиг latexmk для pdfLaTeX
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

### latexmk (рекомендуется)

Самый удобный способ — [`latexmk`](https://ctan.org/pkg/latexmk). Он сам определяет сколько проходов нужно и в каком порядке запускать `biber`.

В репозитории два готовых конфигурационных файла:

| Файл | Движок | Когда использовать |
|---|---|---|
| [`latexmkrc-xelatex`](latexmkrc-xelatex) | XeLaTeX | Системные шрифты (Times New Roman, Arial), OTF-шрифты, `unicode-math` |
| [`latexmkrc-pdflatex`](latexmkrc-pdflatex) | pdfLaTeX | Пакетные шрифты TeX Live, максимальная совместимость |

**Быстрый старт:**

```bash
# 1. Скопируйте нужный конфиг в папку проекта
cp latexmkrc-xelatex .latexmkrc     # для XeLaTeX
# или
cp latexmkrc-pdflatex .latexmkrc    # для pdfLaTeX

# 2. Соберите PDF
latexmk main.tex

# 3. Очистите вспомогательные файлы
latexmk -c

# 4. Очистите всё, включая PDF
latexmk -C
```

**Непрерывная сборка** (пересобирает при каждом сохранении файла):

```bash
latexmk -pvc main.tex
```

**Глобальная установка** (чтобы не копировать в каждый проект):

```bash
# Linux / macOS
mkdir -p ~/.config/latexmk
cp latexmkrc-xelatex ~/.config/latexmk/latexmkrc

# Windows
copy latexmkrc-xelatex %USERPROFILE%\.latexmkrc
```

### Ручная сборка

Если `latexmk` недоступен, запустите цепочку вручную:

```bash
# XeLaTeX
xelatex -interaction=nonstopmode -halt-on-error main.tex
biber main
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex

# pdfLaTeX
pdflatex -interaction=nonstopmode -halt-on-error main.tex
biber main
pdflatex -interaction=nonstopmode -halt-on-error main.tex
pdflatex -interaction=nonstopmode -halt-on-error main.tex
```

Три прохода нужны для корректного построения оглавления, списка таблиц и перекрёстных ссылок.

### Makefile (опционально)

Если вы предпочитаете `make`:

```makefile
TEX      = main
ENGINE   = xelatex
FLAGS    = -interaction=nonstopmode -halt-on-error -synctex=1

.PHONY: all clean distclean watch

all:
    latexmk -r latexmkrc-$(subst xelatex,xelatex,$(ENGINE)) $(TEX).tex

watch:
    latexmk -r latexmkrc-$(ENGINE) -pvc $(TEX).tex

clean:
    latexmk -c

distclean:
    latexmk -C
```

### Org-mode (Emacs)

1. Добавьте [`cmcmsuthesis-org.el`](examples/org-setup/cmcmsuthesis-org.el) в ваш `~/.emacs` — он уже содержит настройку цепочки `xelatex → biber → xelatex → xelatex`.
2. Откройте `.org` файл в Emacs.
3. `C-c C-e l p` — экспорт в PDF.

### VS Code

Для пользователей VS Code с расширением [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) добавьте в `settings.json`:

```json
{
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk-xelatex",
            "command": "latexmk",
            "args": ["-r", "latexmkrc-xelatex", "%DOC%"]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "latexmk (XeLaTeX)",
            "tools": ["latexmk-xelatex"]
        }
    ]
}
```

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

## Благодарности

Проект вдохновлён шаблоном [Russian-Phd-LaTeX-Dissertation-Template](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template) Андрея Акиньшина и соавторов. Их работа стала отправной точкой и источником множества идей по оформлению диссертаций в LaTeX по российским стандартам. Мы выражаем искреннюю благодарность всем участникам этого проекта за огромный вклад в русскоязычное LaTeX-сообщество.

Благодарим Renzhi Li (Belleve Invis) и контрибьюторов проекта [Iosevka](https://typeof.net/Iosevka/) за превосходный моноширинный шрифт с открытым исходным кодом. Кастомизированный вариант Iosevka Brill используется в комплекте как моноширинный шрифт в наборах на основе шрифта Brill.

Благодарим издательство [Brill](https://brill.com/page/fonts/brill-typeface) (Лейден) за предоставление академического шрифта Brill Typeface для бесплатного некоммерческого использования. Шрифт охватывает около 7000 глифов — полную кириллицу, политонический греческий, МФА — и используется в комплекте в наборах `brillkp`, `brillstix` и `liberbrill`.

## Лицензия

[MIT](LICENSE)

## Участие в разработке

Вопросы, предложения и pull request'ы приветствуются. При создании issue укажите используемый движок (pdfLaTeX / XeLaTeX / LuaLaTeX) и минимальный воспроизводимый пример.
