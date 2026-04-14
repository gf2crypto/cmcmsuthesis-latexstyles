# cmcmsugost-extra.sty — Руководство пользователя

**Версия:** 0.2 от 21 марта 2026 г.

Пакет `cmcmsugost-extra` подключает дополнительные модули для научных и технических документов: теоремы, алгоритмы, листинги кода, расширенные математические команды, библиографию по ГОСТ и русские математические операторы. Каждый модуль можно включить или отключить независимо.

---

## 1. Подключение

```latex
\usepackage{cmcmsugost-extra}
```

Или с выборочным отключением модулей:

```latex
\usepackage[thmoff, alg=off, rumathop]{cmcmsugost-extra}
```

> **Рекомендуемый порядок загрузки:**
> 1. `cmcmsugost-fontselector` (шрифты)
> 2. `cmcmsu-gost` (основное оформление)
> 3. `cmcmsugost-extra` (дополнительные модули)

---

## 2. Опции пакета

Все опции можно задать при подключении или через команду `\cmcmsugostextrasetup` (см. раздел 3).

### 2.1. Теоремы — `thm`

Загружает `amsthm` и определяет стандартный набор теоремных окружений с нумерацией по разделам (или главам в `report`).

| Форма | Действие |
|---|---|
| `thm=true` / `thmon` | Включить |
| `thm=false` / `thmoff` | Выключить |

**По умолчанию:** `true`.

### 2.2. Алгоритмы — `alg`

Загружает пакет `algorithm2e` с преднастроенным визуальным стилем (вертикальные линии блоков, серая цветовая схема, моноширинный шрифт, русские подписи).

| Значение | Действие |
|---|---|
| `alg=2e` | Загрузить algorithm2e (по умолчанию) |
| `alg=off` | Не загружать алгоритмы |

**По умолчанию:** `2e`.

### 2.3. Листинги кода — `listings`

Загружает пакет `listings` с готовым чёрно-белым стилем `blackandwhite`, полной поддержкой кириллицы и языком псевдокода.

| Форма | Действие |
|---|---|
| `listings=true` / `listingson` | Включить |
| `listings=false` / `listingsoff` | Выключить |

**По умолчанию:** `true`.

### 2.4. Расширенная математика — `extramath`

Определяет удобные команды для набора векторов, матриц, алгоритмических обозначений и т.д.

| Форма | Действие |
|---|---|
| `extramath=true` / `extramathon` | Включить |
| `extramath=false` / `extramathoff` | Выключить |

**По умолчанию:** `true`.

### 2.5. Библиография — `biber`

Подключает `biblatex` с бэкендом Biber и стилем `gost-numeric`. Автоматически настраивает маппинг полей `.bib`-файлов для совместимости с ГОСТ.

| Форма | Действие |
|---|---|
| `biber=true` / `biberon` | Включить |
| `biber=false` / `biberoff` | Выключить |

**По умолчанию:** `true`.

### 2.6. Русские математические операторы — `rumathop`

Переопределяет стандартные обозначения в соответствии с русской математической традицией.

| Форма | Действие |
|---|---|
| `rumathop=true` / `rumathopon` | Включить |
| `rumathop=false` / `rumathopoff` | Выключить |

**По умолчанию:** `false`.

При включении также загружается пакет `rmathbr` (правильный перенос формул).

---

## 3. Команда `\cmcmsugostextrasetup`

Позволяет переопределить опции в преамбуле:

```latex
\usepackage{cmcmsugost-extra}
\cmcmsugostextrasetup{
    thm      = true,
    alg      = 2e,
    listings = true,
    rumathop = true,
    biber    = false
}
```

---

## 4. Модуль теорем (`thm`)

### 4.1. Определённые окружения

Все окружения нумеруются внутри текущего раздела (`section`) или главы (`chapter`).

**Стиль `plain`** (курсивное тело):

| Окружение | Название |
|---|---|
| `theorem` | Теорема |
| `lemma` | Лемма |
| `proposition` | Утверждение |
| `corollary` | Следствие |

**Стиль `definition`** (прямое тело):

| Окружение | Название |
|---|---|
| `definition` | Определение |
| `example` | Пример |
| `problem` | Задача |

**Стиль `remark`** (курсивный заголовок, прямое тело):

| Окружение | Название |
|---|---|
| `remark` | Замечание |

### 4.2. Пример

```latex
\begin{theorem}
Для любого $\epsilon > 0$ существует $\delta > 0$ такое, что...
\end{theorem}

\begin{proof}
Доказательство следует из леммы~\ref{lem:main}.
\end{proof}
```

---

## 5. Модуль алгоритмов (`alg=2e`)

### 5.1. Визуальный стиль

Пакет `algorithm2e` настраивается следующим образом: текст алгоритма набирается моноширинным шрифтом 12 pt; номера строк — серые, 12 pt; блоки обозначаются вертикальными линиями (`\SetAlgoVlined`); подпись отделяется тире: «Алгоритм 1.1 --- Название»; нумерация идёт внутри раздела (или главы).

### 5.2. Русские ключевые слова

Стандартные команды algorithm2e автоматически переведены:

| Команда | Вывод |
|---|---|
| `\KwInput{...}` | **Вход:** ... |
| `\KwOutput{...}` | **Выход:** ... |
| `\Comment{...}` | `// ...` |

Заголовок окружения — «Алгоритм», список алгоритмов — «Список алгоритмов».

### 5.3. Пример

```latex
\begin{algorithm}[H]
    \caption{Алгоритм Евклида}\label{alg:euclid}
    \KwInput{$a, b \in \mathbb{N}$}
    \KwOutput{$\gcd(a, b)$}
    \While{$b \neq 0$}{
        $t \leftarrow b$\;
        $b \leftarrow a \bmod b$\;
        $a \leftarrow t$\;
    }
    \Return{$a$}\;
\end{algorithm}
```

---

## 6. Модуль листингов (`listings`)

### 6.1. Стиль `blackandwhite`

Устанавливается по умолчанию для всех листингов. Основные параметры: моноширинный шрифт 12 pt; номера строк слева (серые); рамка — вертикальная линия слева; длинные строки переносятся автоматически (с маркером `↪`); полная поддержка кириллицы (русский и украинский алфавиты) через `literate`.

### 6.2. Язык `pseudocode`

Определён встроенный язык `pseudocode` с ключевыми словами: `if`, `then`, `else`, `elseif`, `endif`, `for`, `to`, `do`, `endfor`, `while`, `endwhile`, `repeat`, `until`, `return`, `break`, `continue`, `function`, `procedure`, `input`, `output`, `and`, `or`, `not`, `begin`, `end`, `nil`.

Стиль `pseudocode` наследует `blackandwhite` и добавляет полужирные ключевые слова, а также поддержку `mathescape` (формулы внутри `$...$`).

### 6.3. Окружение `lstpseudocode`

Доступно, если одновременно включены `listings` и `alg=2e`. Это листинг, который разделяет счётчик и подпись с алгоритмами (`algorithm2e`), позволяя единообразно нумеровать как окружения `algorithm`, так и листинги с псевдокодом.

```latex
\begin{lstpseudocode}[caption={Бинарный поиск}, label={alg:bsearch}]
function BinarySearch(A, key)
    lo $\leftarrow$ 1
    hi $\leftarrow$ |A|
    while lo $\leq$ hi do
        mid $\leftarrow$ $\lfloor$(lo + hi) / 2$\rfloor$
        if A[mid] = key then
            return mid
        elseif A[mid] < key then
            lo $\leftarrow$ mid + 1
        else
            hi $\leftarrow$ mid - 1
        endif
    endwhile
    return nil
\end{lstpseudocode}
```

### 6.4. Вспомогательные команды

| Команда | Описание |
|---|---|
| `\lstInput` | Печатает полужирное **Вход** (для использования в `escapeinside`) |
| `\lstOutput` | Печатает полужирное **Выход** |

### 6.5. Подключение внешних файлов

```latex
\lstinputlisting[
    language=Python,
    caption={Реализация на Python},
    label={lst:impl}
]{code/solver.py}
```

---

## 7. Модуль расширенной математики (`extramath`)

### 7.1. Определённые команды

| Команда | Назначение | Начертание |
|---|---|---|
| `\vect{x}` | Вектор | жирный курсив (`\symbfit`) |
| `\matr{A}` | Матрица | жирный курсив (`\symbfit`) |
| `\code{C}` | Код (в теории кодирования) | каллиграфический (`\mathcal`) |
| `\str{s}` | Строка / элемент | прямой (`\symup`) |
| `\elt{a}` | Элемент | прямой (`\symup`) |
| `\crypto{E}` | Криптографический примитив | sans-serif (`\mathsf`) |
| `\algo{A}` | Алгоритм в формуле | sans-serif (`\mathsf`) |
| `\compl{P}` | Класс сложности | sans-serif (`\mathsf`) |
| `\scalemath{s}{...}` | Масштабирование формулы | коэффициент `s` |

> **Примечание.** Команды `\symbfit`, `\symup` и др. предоставляются пакетом `cmcmsugost-fontselector`. Если fontselector не загружен, убедитесь, что эти команды определены (например, через `unicode-math`).

### 7.2. Пример

```latex
Пусть $\vect{x} \in \mathbb{R}^n$ и $\matr{A} \in \mathbb{R}^{n \times n}$.
Тогда задача решается алгоритмом $\algo{FastSolve}$
за время $\compl{O}(n \log n)$.
```

---

## 8. Русские математические операторы (`rumathop`)

При включении выполняются следующие замены:

| Стандартная команда | Заменяется на | Результат |
|---|---|---|
| `\tan` | `\operatorname{tg}` | tg |
| `\cot` | `\operatorname{ctg}` | ctg |
| `\csc` | `\operatorname{cosec}` | cosec |
| `\le`, `\leq` | `\leqslant` | ⩽ |
| `\ge`, `\geq` | `\geqslant` | ⩾ |
| `\phi` | `\varphi` | φ (завитая) |
| `\epsilon` | `\varepsilon` | ε (завитая) |
| `\kappa` | `\varkappa` | ϰ |
| `\emptyset` | `\varnothing` | ∅ (перечёркнутый круг) |

Дополнительно загружается пакет `rmathbr`, который обеспечивает корректный перенос длинных формул с сохранением знака операции.

---

## 9. Модуль библиографии (`biber`)

### 9.1. Настройки biblatex

Пакет передаёт `biblatex` следующие опции: `backend=biber`, `style=gost-numeric`, `sorting=none` (в порядке цитирования), `sortcites=true`, `autolang=other`, `clearlang=true`, `defernumbers=true`. Поля `doi` и `isbn` по умолчанию скрыты. Также загружается `csquotes` для корректных кавычек.

### 9.2. Автоматический маппинг полей

Пакет автоматически преобразует `.bib`-файлы при обработке Biber-ом, чтобы обеспечить совместимость со старыми базами:

| Исходное поле | Результат |
|---|---|
| `language` | переносится в `langid` |
| `numpages`, `pagestotal` | переносятся в `pagetotal` |
| `shortjournal` | заменяет `journal` |
| `shortbooktitle` | заменяет `booktitle` |
| `medium=Электронный ресурс` | устанавливает `media=eresource` |
| `howpublished` (для `@online`) | переносится в `organization` |
| `urldate` (формат `ДД.ММ.ГГГГ`) | конвертируется в `ГГГГ-ММ-ДД` |
| `issn`, `abstract`, `keywords` | удаляются |

Если поле `media` не задано, устанавливается `media=text`.

### 9.3. Использование

```latex
% В преамбуле (после загрузки cmcmsugost-extra с biber=true):
\usepackage{biblatex}
\addbibresource{references.bib}

% В конце документа:
\printbibliography
```

> **Важно.** Пакет `biblatex` нужно подключать **после** `cmcmsugost-extra`, чтобы опции, переданные через `\PassOptionsToPackage`, вступили в силу. Компиляция: `pdflatex → biber → pdflatex → pdflatex`.

---

## 10. Переводы (translator)

Пакет загружает `translator` и определяет русские переводы для ключевых терминов. Эти переводы используются внутри модулей алгоритмов и листингов, но доступны и пользователю через `\translate{...}`:

| Ключ | Перевод |
|---|---|
| `Definition` | Определение |
| `Theorem` | Теорема |
| `Lemma` | Лемма |
| `Proposition` | Утверждение |
| `Corollary` | Следствие |
| `Remark` | Замечание |
| `Problem` | Проблема |
| `Task` | Задача |
| `Algorithm` | Алгоритм |
| `Input` | Вход |
| `Output` | Выход |
| `Listing` | Алгоритм |
| `Bibliography` | Список литературы |
| `UDK` | УДК |
| `Keywords` | Ключевые слова |

---

## 11. Полный пример

```latex
\documentclass[14pt]{extarticle}
\usepackage[font=libertinus, upgreek]{cmcmsugost-fontselector}
\usepackage[spacing=15]{cmcmsu-gost}
\usepackage[rumathop]{cmcmsugost-extra}
\usepackage{biblatex}
\addbibresource{refs.bib}

\begin{document}

\tableofcontents

\section{Теоретические основы}

\begin{definition}
Пусть $\vect{x} \in \mathbb{R}^n$. Нормой вектора называется...
\end{definition}

\begin{theorem}\label{thm:main}
Для любого $\epsilon > 0$ справедлива оценка
$\|\matr{A}\vect{x}\| \leq C\|\vect{x}\|$.
\end{theorem}

\begin{proof}
Следует из определения нормы.
\end{proof}

\section{Алгоритм}

\begin{algorithm}[H]
    \caption{Градиентный спуск}\label{alg:gd}
    \KwInput{$f$, $\vect{x}_0$, $\alpha$, $N$}
    \KwOutput{$\vect{x}^*$}
    \For{$k = 1$ \KwTo $N$}{
        $\vect{x}_k \leftarrow \vect{x}_{k-1}
            - \alpha \nabla f(\vect{x}_{k-1})$\;
    }
    \Return{$\vect{x}_N$}\;
\end{algorithm}

\section{Реализация}

\lstinputlisting[
    language=Python,
    caption={Реализация градиентного спуска},
    label={lst:gd}
]{code/gradient.py}

\printbibliography

\end{document}
```

---

## 12. Краткая справка по опциям

| Опция | Тип | Умолчание | Описание |
|---|---|---|---|
| `thm` | bool | `true` | Теоремные окружения (amsthm) |
| `alg` | строка | `2e` | Алгоритмы: `2e` или `off` |
| `listings` | bool | `true` | Листинги кода (listings) |
| `extramath` | bool | `true` | Дополнительные мат. команды |
| `biber` | bool | `true` | Библиография biblatex + ГОСТ |
| `rumathop` | bool | `false` | Русские мат. операторы |
