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

Комплект состоит из четырёх слоёв пакетов и надстройки классов:

```
┌─────────────────────────────────────────────────┐
│           Классы документов (cls)                │
│  cw · bachelor · master · phd · doctoral        │
│                    │                             │
│              cmcmsuthesis                        │
│         (базовый класс + титульная)              │
└──────┬─────────┬──────────┬──────────┬──────────┘
       │         │          │          │
  ┌────▼───┐ ┌───▼─────┐ ┌──▼──────┐ ┌─▼────────┐
  │  gost  │ │  font-  │ │ fontsets│ │  extra   │
  │        │ │ selector│ │         │ │          │
  │геомет- │ │         │ │готовые  │ │теоремы   │
  │рия,    │ │выбор    │ │наборы   │ │алгоритмы │
  │заголов-│ │шрифтов, │ │шрифтов  │ │листинги  │
  │ки, ToC,│ │матема-  │ │(serif + │ │библиогр. │
  │списки, │ │тика,    │ │sans +   │ │операторы │
  │подписи │ │язык     │ │mono +   │ │команды   │
  │        │ │         │ │math)    │ │          │
  └────────┘ └─────────┘ └─────────┘ └──────────┘
```

### Пакеты

| Пакет | Назначение | Документация |
|---|---|---|
| **`cmcmsu-gost`** | Оформление по ГОСТ: геометрия страницы, колонтитулы, заголовки, оглавление, списки, подписи рисунков и таблиц, приложения | [Руководство](docs/cmcmsu-gost-manual.md) |
| **`cmcmsugost-fontselector`** | Низкоуровневый выбор шрифтов: математика, прямые греческие буквы, масштабирование, `microtype` | [Руководство](docs/cmcmsugost-fontselector-manual.md) |
| **`cmcmsufontsets`** | Готовые наборы шрифтов (serif + sans + mono + math) для pdfLaTeX и XeLaTeX/LuaLaTeX | [Руководство](docs/cmcmsufontsets-manual.md) |
| **`cmcmsugost-extra`** | Дополнительные модули: теоремы, algorithm2e, listings с кириллицей, biblatex по ГОСТ, русские мат. операторы, удобные команды (`\vect`, `\matr`, `\algo`, …) | [Руководство](docs/cmcmsugost-extra-manual.md) |

Пакеты можно использовать **независимо от классов**, подключая их вручную к любому документу.

## Совместимость

| Движок | Поддержка |
|---|---|
| pdfLaTeX | ✔ полная |
| XeLaTeX | ✔ полная (рекомендуется) |
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
| — | `brillkp`, `brillstix`, `liberbrill` | Наборы на основе Brill Typeface |

Полный список наборов и отдельных шрифтов — в [документации fontsets](docs/cmcmsufontsets-manual.md).

> **О шрифтах Brill и Iosevka.** Шрифт Brill распространяется издательством Brill бесплатно для некоммерческого использования и **не входит** в репозиторий — его нужно скачать отдельно (см. раздел «Локальная установка»). Кастомизированный моноширинный шрифт **Iosevka Brill** уже включён в репозиторий в папке [`fonts/iosevka-brill/`](fonts/iosevka-brill/).

## Готовые примеры

В папке [`examples/`](examples/) — готовые шаблоны для каждого типа работы в двух форматах: LaTeX и Org-mode. Каждый пример демонстрирует **все возможности** комплекта: теоремы, формулы, алгоритмы, листинги, таблицы, библиографию, приложения и т.д. Рядом с каждым `.tex` лежит уже собранный `.pdf`, чтобы можно было сразу посмотреть результат.

| Пример | Тема | LaTeX | PDF | Org-mode |
|---|---|---|---|---|
| Курсовая | Численные методы ОДУ | [`coursework.tex`](examples/coursework.tex) | [`coursework.pdf`](examples/coursework.pdf) | [`coursework.org`](examples/coursework.org) |
| Бакалаврская ВКР | Машинное обучение, NLP | [`bachelor.tex`](examples/bachelor.tex) | [`bachelor.pdf`](examples/bachelor.pdf) | [`bachelor.org`](examples/bachelor.org) |
| Магистерская | Алгоритмы на графах | [`master.tex`](examples/master.tex) | [`master.pdf`](examples/master.pdf) | [`master.org`](examples/master.org) |
| Кандидатская | Теория кодов, криптография | [`phd.tex`](examples/phd.tex) | [`phd.pdf`](examples/phd.pdf) | [`phd.org`](examples/phd.org) |
| Докторская | Стохастическое управление | [`doctoral.tex`](examples/doctoral.tex) | [`doctoral.pdf`](examples/doctoral.pdf) | [`doctoral.org`](examples/doctoral.org) |
| Статья | Универсальный шаблон статьи | [`article.tex`](examples/article.tex) | [`article.pdf`](examples/article.pdf) | [`article.org`](examples/article.org) |
| Отчёт | Универсальный шаблон отчёта | [`report.tex`](examples/report.tex) | [`report.pdf`](examples/report.pdf) | [`report.org`](examples/report.org) |

Общая библиография: [`examples/refs.bib`](examples/refs.bib). Изображения: [`examples/images/`](examples/images/).

Для работы с Org-mode добавьте конфигурацию из [`examples/org-setup/`](examples/org-setup/) в ваш `~/.emacs`.

## Локальная установка (рекомендуемый способ)

Проще всего развернуть проект «на месте» — в отдельной рабочей папке, без глобальной установки в `texmf`. Все стили, классы и пример лежат рядом с вашим документом. Ниже — пошаговый сценарий на примере папки `mythesis` для бакалаврской работы.

### Шаг 1. Клонируем репозиторий

```bash
git clone https://github.com/<user>/cmcmsuthesis-latexstyles.git mythesis
cd mythesis
```

После клонирования в `mythesis/` уже лежат все нужные `.cls` и `.sty` файлы — LaTeX найдёт их автоматически, поскольку они находятся в текущем каталоге.

### Шаг 2. Копируем нужный пример из `examples/`

Берём из `examples/` шаблон, библиографию и папку с картинками. Например, для бакалаврской работы:

```bash
cp examples/bachelor.tex   ./main.tex
cp examples/refs.bib       ./refs.bib
cp -r examples/images      ./images
```

Для другого типа работы замените `bachelor.tex` на `coursework.tex`, `master.tex`, `phd.tex`, `doctoral.tex`, `article.tex` или `report.tex`.

### Шаг 3. Скачиваем шрифты Brill (опционально)

Если вы планируете использовать наборы шрифтов на основе Brill (`brillkp`, `brillstix`, `liberbrill`), скачайте семейство **Brill Typeface** с официальной страницы издательства:

➡ **<https://brill.com/page/fonts/brill-typeface>**

Распакуйте архив и скопируйте `.otf`-файлы в подкаталог `brill/` рабочей папки:

```bash
mkdir -p brill
cp /путь/к/распакованному/архиву/*.otf brill/
```

В итоге должна получиться структура:

```
mythesis/
├── brill/
│   ├── BrillRoman.otf
│   ├── BrillItalic.otf
│   ├── BrillBold.otf
│   └── BrillBoldItalic.otf
└── ...
```

XeLaTeX/LuaLaTeX подхватит шрифты из локальной папки автоматически (через `\setmainfont[Path=brill/]{...}` внутри fontset). Если вы используете другой набор шрифтов (например, `libertinus`, `pt`, `modern`), этот шаг можно пропустить.

> **Шаг 3a (опционально).** Шрифт Iosevka Brill уже лежит в [`fonts/iosevka-brill/`](fonts/iosevka-brill/) — копировать его никуда не нужно, репозиторий содержит его «из коробки».

### Шаг 4. Копируем `latexmkrc` в корень проекта

В папке `examples/` лежат два готовых конфига `latexmk`:

| Файл | Движок | Когда выбирать |
|---|---|---|
| [`examples/latexmkrc-xelatex`](examples/latexmkrc-xelatex) | **XeLaTeX** | системные и OTF-шрифты, `unicode-math`, **рекомендуется** |
| [`examples/latexmkrc`](examples/latexmkrc) | pdfLaTeX | пакетные шрифты TeX Live, максимальная совместимость |

Скопируйте нужный файл в корень проекта под именем `.latexmkrc`:

```bash
# Рекомендуемый вариант — XeLaTeX (более современные шрифты)
cp examples/latexmkrc-xelatex latexmkrc

# Альтернативный вариант — pdfLaTeX
# cp examples/latexmkrc latexmkrc
```

### Шаг 5. Собираем PDF с помощью `latexmk`

```bash
latexmk main.tex
```

`latexmk` сам определит, сколько раз нужно прогнать LaTeX и `biber`, чтобы корректно построились оглавление, перекрёстные ссылки и список литературы.

Готовый файл появится как `main.pdf` в корне проекта.

**Полезные команды:**

```bash
latexmk -pvc main.tex   # непрерывная сборка: пересобирает при каждом сохранении
latexmk -c              # удалить вспомогательные файлы (.aux, .log, .toc, ...)
latexmk -C              # удалить всё, включая main.pdf
```

### Итоговая структура `mythesis/`

После выполнения всех шагов рабочая папка выглядит так:

```
mythesis/
├── latexmkrc                  ← конфиг сборки (из examples/)
├── main.tex                    ← ваш документ (из examples/bachelor.tex)
├── main.pdf                    ← результат сборки
├── refs.bib                    ← библиография (из examples/)
├── images/                     ← картинки (из examples/)
│
├── brill/                      ← шрифты Brill (скачаны вручную)
│   └── *.otf
│
├── cmcmsuthesis-latexstyles/            ← классы и стили (из репозитория)

```

## Альтернативные способы установки

### Глобальная установка в `texmf`

Если вы хотите использовать комплект сразу из многих проектов без копирования файлов:

```bash
# Стили и классы
mkdir -p ~/texmf/tex/latex/cmcmsuthesis
cp *.sty *.cls ~/texmf/tex/latex/cmcmsuthesis/
mktexlsr

# Глобальный конфиг latexmk
mkdir -p ~/.config/latexmk
cp examples/latexmkrc-xelatex ~/.config/latexmk/latexmkrc
```

Проверка:

```bash
kpsewhich cmcmsuthesis.cls
```

## Структура репозитория

```
cmcmsuthesis-latexstyles/
│
├── README.md                           ← этот файл
├── LICENSE
│
├── cmcmsu-gost.sty                     ← пакет: оформление по ГОСТ
├── cmcmsugost-fontselector.sty         ← пакет: низкоуровневый выбор шрифтов
├── cmcmsufontsets.sty                  ← пакет: готовые наборы шрифтов
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
│
├── fonts/                              ← встроенные шрифты
│   └── iosevka-brill/                  ← Iosevka Brill (моноширинный)
│
├── docs/                               ← документация по пакетам и классам
│
└── examples/                           ← готовые шаблоны и сборочные конфиги
    ├── latexmkrc-xelatex               ← конфиг latexmk (XeLaTeX, рекомендуется)
    ├── latexmkrc                       ← конфиг latexmk (pdfLaTeX)
    ├── refs.bib                        ← общая библиография
    ├── images/                         ← картинки для примеров
    ├── org-setup/                      ← настройки Emacs/Org-mode
    │
    ├── coursework.tex / .pdf / .org    ← курсовая
    ├── bachelor.tex   / .pdf / .org    ← бакалавр
    ├── master.tex     / .pdf / .org    ← магистр
    ├── phd.tex        / .pdf / .org    ← кандидатская
    ├── doctoral.tex   / .pdf / .org    ← докторская
    ├── article.tex    / .pdf / .org    ← статья
    └── report.tex     / .pdf / .org    ← отчёт
```

## Документация

### Пакеты

| Пакет | Что делает | Руководство |
|---|---|---|
| `cmcmsu-gost` | Геометрия страницы A4, колонтитулы, заголовки 14pt, оглавление с точечными лидерами, списки с тире, подписи рисунков/таблиц с тире, приложения с русскими буквами, настройки `hyperref` | [cmcmsu-gost-manual.md](docs/cmcmsu-gost-manual.md) |
| `cmcmsugost-fontselector` | Низкоуровневый механизм выбора шрифтов, масштабирование, прямые греческие (`\symup`), жирные греческие (`\symbf`, `\symbfup`), `\mathcal` old-style, `microtype` | [cmcmsugost-fontselector-manual.md](docs/cmcmsugost-fontselector-manual.md) |
| `cmcmsufontsets` | Готовые наборы шрифтов: `modern`, `libertinus`, `pt`, `ebgaramond`, `msoffice`, `brillkp`, `brillstix`, `liberbrill` и другие — для pdfLaTeX и XeLaTeX/LuaLaTeX | [cmcmsufontsets-manual.md](docs/cmcmsufontsets-manual.md) |
| `cmcmsugost-extra` | Теоремы (`amsthm`, 9 окружений), `algorithm2e` с русскими подписями, `listings` с кириллицей + стиль `pseudocode` + `lstpseudocode`, `biblatex` по ГОСТ с маппингом полей, русские операторы (tg, ctg, ⩽, ⩾), команды `\vect`, `\matr`, `\algo`, `\compl`, `\crypto` | [cmcmsugost-extra-manual.md](docs/cmcmsugost-extra-manual.md) |

### Классы

| Класс | Что фиксирует | Руководство |
|---|---|---|
| `cmcmsuthesis` | Базовый: загружает все пакеты, метаданные через `pgfkeys`, два стиля титульной (`cmc`/`gost`), цвета ссылок | [cmcmsuthesis-manual.md](docs/cmcmsuthesis-manual.md) |
| `cmcmsuthesis-cw` | `extarticle` + `cmc` + subtitle = «Курсовая работа» | [cmcmsuthesis-cw-manual.md](docs/cmcmsuthesis-cw-manual.md) |
| `cmcmsuthesis-bachelor` | `extarticle` + `cmc` + subtitle задаётся пользователем | [cmcmsuthesis-bachelor-manual.md](docs/cmcmsuthesis-bachelor-manual.md) |
| `cmcmsuthesis-master` | `extarticle` + `cmc` + subtitle = «Магистерская диссертация» | [cmcmsuthesis-master-manual.md](docs/cmcmsuthesis-master-manual.md) |
| `cmcmsuthesis-phd` | `extreport` + `gost` + полное название МГУ + «…кандидата ф.-м. наук» | [cmcmsuthesis-phd-manual.md](docs/cmcmsuthesis-phd-manual.md) |
| `cmcmsuthesis-doctoral` | `extreport` + `gost` + полное название МГУ + «…доктора ф.-м. наук» + «Научный консультант» | [cmcmsuthesis-doctoral-manual.md](docs/cmcmsuthesis-doctoral-manual.md) |

## Ручная сборка (без `latexmk`)

Если `latexmk` недоступен, запустите цепочку вручную:

```bash
# XeLaTeX (рекомендуется)
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

## Возможности, демонстрируемые в примерах

Каждый [пример](examples/) включает **полный набор** возможностей комплекта:

**Текст и оформление** — жирный, курсив, жирный курсив, подчёркивание, зачёркивание, sans-serif; ненумерованные введение и заключение; оглавление и список таблиц; два приложения с подразделами.

**Формулы** — inline и display; нумерованные (`equation`); многострочные (`aligned`, `alignedat`, `cases`, `multlined`); субформулы (`subequations` + `gather`/`align` + `\eqref`); система уравнений; матрица с многоточиями; непрерывная дробь; длинная inline формула с переносом (`rmathbr`).

**Греческие буквы** — обычные, прямые (`\symup`), жирные (`\symbf`), жирные прямые (`\symbfup`); математические алфавиты (`\mathcal`, `\mathfrak`, `\mathbb`); русские операторы (tg, ctg, ⩽, ⩾, φ, ε, ϰ, ∅); отступы (`\!`, `\,`, `\;`, `\quad`).

**Окружения** — `theorem`, `definition`, `proposition`, `corollary`, `lemma`, `remark`, `example`, `problem`, `proof`.

**Команды** — `\vect`, `\matr`, `\code`, `\str`, `\elt`, `\algo`, `\compl`, `\crypto`.

**Таблицы** — простая с линейками, `booktabs` с выравниванием, `longtable`.

**Изображения** — обычная вставка, вставка с масштабом.

**Списки** — нумерованный (4 уровня), ненумерованный (4 уровня), `beginpenalty`.

**Алгоритмы** — `algorithm2e` (`\KwInput`, `\KwOutput`, `\While`, `\For`, `\uIf`/`\uElseIf`/`\Else`, `\Comment`, `\tcp*`, `\Return`); листинг Python с русскими комментариями; листинг C с русскими комментариями; псевдокод `style=pseudocode` (`\lstInput`, `\lstOutput`); `lstpseudocode` (общий счётчик с `algorithm2e`).

**Библиография** — одиночная и множественная ссылки; `\printbibliography`.

## Благодарности

Проект вдохновлён шаблоном [Russian-Phd-LaTeX-Dissertation-Template](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template) Андрея Акиньшина и соавторов. Их работа стала отправной точкой и источником множества идей по оформлению диссертаций в LaTeX по российским стандартам. Мы выражаем искреннюю благодарность всем участникам этого проекта за огромный вклад в русскоязычное LaTeX-сообщество.

Благодарим Renzhi Li (Belleve Invis) и контрибьюторов проекта [Iosevka](https://typeof.net/Iosevka/) за превосходный моноширинный шрифт с открытым исходным кодом. Кастомизированный вариант **Iosevka Brill** включён в комплект (см. [`fonts/iosevka-brill/`](fonts/iosevka-brill/)) и используется как моноширинный шрифт в наборах на основе шрифта Brill.

Благодарим издательство [Brill](https://brill.com/page/fonts/brill-typeface) (Лейден) за предоставление академического шрифта **Brill Typeface** для бесплатного некоммерческого использования. Шрифт охватывает около 7000 глифов — полную кириллицу, политонический греческий, МФА — и используется в комплекте в наборах `brillkp`, `brillstix` и `liberbrill`.

## Лицензия

[MIT](LICENSE)

## Участие в разработке

Вопросы, предложения и pull request'ы приветствуются. При создании issue укажите используемый движок (pdfLaTeX / XeLaTeX / LuaLaTeX) и минимальный воспроизводимый пример.
