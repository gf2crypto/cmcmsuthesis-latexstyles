# cmcmsugost-fontselector.sty — Руководство пользователя

**Версия:** 0.2 от 21 марта 2026 г.

Пакет `cmcmsugost-fontselector` управляет шрифтами, математическими шрифтами и языковыми настройками для документов, оформленных по ГОСТ. Работает совместно с `cmcmsu-gost`, но может использоваться и самостоятельно.

---

## 1. Подключение

```latex
\usepackage{cmcmsugost-fontselector}
```

Или с опциями:

```latex
\usepackage[font=libertinus, mono=jetbrainsmono, upgreek]{cmcmsugost-fontselector}
```

Пакет поддерживает **pdfLaTeX**, **XeLaTeX** и **LuaLaTeX**. Доступные шрифты зависят от движка: pdfLaTeX использует пакетные шрифты из TeX Live, а XeLaTeX/LuaLaTeX — OpenType/TrueType шрифты через `fontspec` и `unicode-math`.

> **Порядок загрузки.** Подключайте `cmcmsugost-fontselector` **перед** `cmcmsu-gost`. Тогда `cmcmsu-gost` обнаружит уже загруженные кодировки и языковой пакет и не будет их дублировать.

---

## 2. Опции пакета

Все опции можно задать при подключении или через команду `\cmcmsugostfontsetup` (см. раздел 3).

### 2.1. Основной шрифт — `font`

Опция `font` принимает либо **имя набора** (font set — готовая комбинация serif + sans + mono + math), либо **имя отдельного шрифта**. Если указано имя набора, опции `sans`, `mono` и `mathfont` игнорируются — набор определяет все четыре семейства целиком.

**По умолчанию:** пустая строка (для pdfLaTeX — Tempora; для XeLaTeX — NewComputerModern через `fontsetup`).

### 2.2. Шрифт без засечек — `sans`

Только для отдельного (не набором) выбора. Действует, если `font` — имя отдельного шрифта, а не набора.

**По умолчанию:** пустая строка (стандартный sans движка).

### 2.3. Моноширинный шрифт — `mono`

Аналогично `sans`.

**По умолчанию:** пустая строка (стандартный mono движка).

### 2.4. Математический шрифт — `mathfont`

**По умолчанию:** пустая строка (для pdfLaTeX — `newtx`; для XeLaTeX — NewCM Math).

### 2.5. Масштабирование — `fontscale`, `sansscale`, `monoscale`, `mathfontscale`

Числовой коэффициент масштабирования для каждого семейства. Применяется только в XeLaTeX/LuaLaTeX.

**По умолчанию:** `1` для всех.

```latex
\usepackage[font=ptserif, fontscale=1.05, mono=jetbrainsmono, monoscale=0.9]{cmcmsugost-fontselector}
```

### 2.6. Язык — `lang`

Язык для `babel` (загружается, только если ни `babel`, ни `polyglossia` не были подключены ранее).

**По умолчанию:** `russian`.

```latex
\usepackage[lang=english]{cmcmsugost-fontselector}
```

### 2.7. Прямые греческие буквы — `upgreek`

Включает прямое (upright) начертание греческих букв в формулах — в соответствии с русской математической традицией, где α, β, γ и т.д. набираются прямым шрифтом, а не курсивом.

| Форма | Действие |
|---|---|
| `upgreek=true` / `upgreekon` | Включить |
| `upgreek=false` / `upgreekoff` | Выключить |

**По умолчанию:** `false`.

В pdfLaTeX загружается пакет `upgreek`, и все стандартные команды (`\alpha`, `\beta`, …) переопределяются на прямые варианты. В XeLaTeX/LuaLaTeX передаётся опция `math-style=french` пакету `unicode-math`.

### 2.8. Старый стиль `\mathcal` — `mathcalold`

Заменяет стандартное начертание `\mathcal` на каллиграфический шрифт из STIX Two Math (только XeLaTeX/LuaLaTeX).

| Форма | Действие |
|---|---|
| `mathcalold=true` / `mathcaloldon` | Включить |
| `mathcalold=false` / `mathcaloldoff` | Выключить |

**По умолчанию:** `false`.

### 2.9. Микротипографика — `microtype`

Управляет загрузкой пакета `microtype` (протрузия и экспансия символов для улучшения разрядки строк).

| Форма | Действие |
|---|---|
| `microtype=true` / `microtypeon` | Protruding + expansion (pdfLaTeX) или только protrusion (XeLaTeX) |
| `microtype=false` / `microtypeoff` | Только protrusion, без expansion |

**По умолчанию:** `true`.

---

## 3. Команда `\cmcmsugostfontsetup`

Позволяет задать или переопределить любые опции **в преамбуле** (работает и после `\begin{document}`, в отличие от `\cmcmsugostsetup` основного пакета):

```latex
\usepackage{cmcmsugost-fontselector}
\cmcmsugostfontsetup{
    font       = libertinus,
    mono       = jetbrainsmono,
    monoscale  = 0.9,
    upgreek    = true,
    mathcalold = true
}
```

---

## 4. Готовые наборы шрифтов (font sets)

Набор — это готовая комбинация из четырёх шрифтов (serif, sans, mono, math), подобранных для визуальной гармонии. Задаётся через `font=имя_набора`.

### 4.1. Наборы для pdfLaTeX

| Набор | Serif | Sans | Mono | Math |
|---|---|---|---|---|
| `default` | Computer Modern | CM Sans | CM Mono | CM Math |
| `cm` | Computer Modern | CM Sans | CM Mono | CM Math |
| `tempora` | Tempora | — | — | newtxmath |
| `heros` | — | TeX Gyre Heros | — | newtxmath |
| `paratype` | PT Serif+Sans+Mono | (paratype) | (paratype) | newtxmath |
| `heuristica` | Heuristica | — | — | Fourier |
| `libertinus` | Libertinus | (libertinus) | PT Mono | libertinust1math |
| `dejavu` | DejaVu | (dejavu) | (dejavu) | newtxmath |
| `xcharter` | XCharter | — | — | mathdesign (charter) |

Псевдонимы для удобства:

| Псевдоним | Соответствует |
|---|---|
| `old` | `default` |
| `modern` | `tempora` |
| `libert` | `libertinus` |
| `fashion` | `xcharter` |

### 4.2. Наборы для XeLaTeX / LuaLaTeX

| Набор | Serif | Sans | Mono | Math |
|---|---|---|---|---|
| `default` | NewCM (fontsetup) | NewCM Sans | NewCM Mono | NewCM Math |
| `newcm` | NewCM Book | NewCM Sans | NewCM Mono | NewCM Math |
| `libertinus` | Libertinus Serif | Libertinus Sans | Source Code Pro | Libertinus Math |
| `pt` | PT Serif | PT Sans | PT Mono | STIX Two Math |
| `dejavu` | DejaVu Serif | DejaVu Sans | DejaVu Mono | STIX Two Math |
| `roboto` | Tinos | Fira Sans | DejaVu Mono | Fira Math |
| `fira` | *(sans по умолчанию)* | Fira Sans | JetBrains Mono | Fira Math |
| `ptsans` | PT Sans (как serif) | PT Sans Narrow | PT Mono | STIX Two Math |
| `alegreya` | Alegreya | Alegreya Sans | Source Code Pro | Garamond Math |
| `cormorant` | EB Garamond | Alegreya Sans | DejaVu Mono | Garamond Math |
| `merriweather` | EB Garamond | NewCM Sans | DejaVu Mono | STIX Two Math |
| `source` | Domitian | Fira Sans | DejaVu Mono | STIX Two Math |
| `crimsonpro` | Alegreya | NewCM Sans | DejaVu Mono | Garamond Math |
| `ebgaramond` | EB Garamond | NewCM Sans | DejaVu Mono | Garamond Math |
| `gentiumplus` | Gentium Plus | NewCM Sans | DejaVu Mono | NewCM Math |
| `stix` | STIX Two Text | NewCM Sans | JetBrains Mono | STIX Two Math |
| `playfair` | Domitian | Fira Sans | DejaVu Mono | NewCM Math |
| `msoffice` | Times New Roman | Arial | Courier New | STIX Two Math |

Псевдонимы XeLaTeX/LuaLaTeX:

| Псевдоним | Соответствует |
|---|---|
| `old` | `default` |
| `modern` | `stix` |
| `libert` | `libertinus` |
| `fashion` | `ebgaramond` |

#### Наборы на основе шрифта Brill

Шрифт Brill — академическая антиква с ~7000 глифами (кириллица, политонический греческий, МФА). Он **не входит** в TeX Live и требует отдельной установки с сайта [brill.com](https://brill.com/about/brill-fonts) (бесплатно для некоммерческого использования).

| Набор | Serif | Sans | Mono | Math |
|---|---|---|---|---|
| `brillkp` | Brill | Alegreya Sans | Iosevka Brill | KP Math |
| `brillstix` | Brill | Alegreya Sans | Iosevka Brill | STIX Two Math |
| `brilllibertinus` | Brill | Alegreya Sans | Iosevka Brill | Libertinus Math |

> **Примечание.** Моноширинный шрифт Iosevka Brill также требует отдельной установки.

---

## 5. Отдельные шрифты

Если вы не используете готовый набор, можно выбрать каждое семейство по отдельности через опции `font`, `sans`, `mono` и `mathfont`.

### 5.1. Шрифты с засечками (`font`)

#### pdfLaTeX

| Значение | Шрифт |
|---|---|
| `tempora` | Tempora |
| `bonum` | TeX Gyre Bonum |
| `termes` | TeX Gyre Termes |
| `pagella` | TeX Gyre Pagella |
| `schola` | TeX Gyre Schola |
| `ptserif` | PT Serif |
| `paratype` | Paratype (PT Serif+Sans+Mono) |
| `heuristica` | Heuristica |
| `old` | Old Standard |
| `libertinus` | Libertinus |
| `noto` | Noto |
| `dejavu` | DejaVu |
| `xcharter` | XCharter |
| `cochineal` | Cochineal |
| `newtx` | newtxtext |

#### XeLaTeX / LuaLaTeX

| Значение | Шрифт | Формат |
|---|---|---|
| `newcmserif` | NewComputerModern | OTF |
| `ptserif` | PT Serif | TTF |
| `dejavuserif` | DejaVu Serif | TTF |
| `stixtwo` | STIX Two Text | OTF |
| `libertinus` | Libertinus Serif | OTF |
| `alegreya` | Alegreya | OTF |
| `ebgaramond` | EB Garamond | OTF |
| `domitian` | Domitian (Palatino) | OTF |
| `gentiumplus` | Gentium Plus | TTF |
| `tinos` | Tinos (≈Times NR) | TTF |
| `timesnewroman` | Times New Roman | системный |
| `brill` | Brill | TTF, отдельная установка |

### 5.2. Шрифты без засечек (`sans`)

#### pdfLaTeX

| Значение | Шрифт |
|---|---|
| `adventor` | TeX Gyre Adventor |
| `heros` | TeX Gyre Heros |
| `paratype` | PT Sans |
| `fira` | Fira Sans |
| `source` | Source Sans Pro |

#### XeLaTeX / LuaLaTeX

| Значение | Шрифт |
|---|---|
| `newcm` | NewCM Sans |
| `ptsans` | PT Sans |
| `ptsansnarrow` | PT Sans Narrow |
| `ptsanscaption` | PT Sans Caption |
| `dejavusans` | DejaVu Sans |
| `libertinussans` | Libertinus Sans |
| `alegreyasans` | Alegreya Sans |
| `montserrat` | Montserrat |
| `firasans` | Fira Sans |
| `lato` | Lato |
| `arimo` | Arimo (≈Arial) |
| `source` | Source Sans 3 |
| `arial` | Arial (системный) |

### 5.3. Моноширинные шрифты (`mono`)

#### pdfLaTeX

| Значение | Шрифт |
|---|---|
| `cursor` | TeX Gyre Cursor |
| `paratype` | PT Mono |

#### XeLaTeX / LuaLaTeX

| Значение | Шрифт |
|---|---|
| `newcm` | NewCM Mono |
| `ptmono` | PT Mono |
| `dejavumono` | DejaVu Sans Mono |
| `jetbrainsmono` | JetBrains Mono |
| `juliamono` | Julia Mono |
| `sourcecodepro` | Source Code Pro |
| `couriernew` | Courier New (системный) |
| `iosevkabrill` | Iosevka Brill (отдельная установка) |

### 5.4. Математические шрифты (`mathfont`)

#### pdfLaTeX

| Значение | Шрифт |
|---|---|
| `newtx` | newtxmath |
| `pazo` | mathpazo |
| `newpx` | newpxmath |
| `eulervm` | Euler Virtual Math |
| `fourier` | Fourier |
| `kpfonts` | KP Fonts |
| `stix` | STIX 2 |
| `mathdesign` | mathdesign |
| `libertinus` | libertinust1math |

#### XeLaTeX / LuaLaTeX

| Значение | Шрифт |
|---|---|
| `newcm` | NewCM Math Book |
| `lmmath` | Latin Modern Math |
| `libertinusmath` | Libertinus Math |
| `stixmath` | STIX Two Math |
| `garamondmath` | Garamond Math |
| `firamath` | Fira Math (sans-serif) |
| `kpmath` | KP Math |

---

## 6. Вспомогательные команды для математики

Пакет автоматически предоставляет единый интерфейс для жирных и прямых символов в формулах, независимо от движка:

| Команда | Назначение | Пример |
|---|---|---|
| `\symbf{x}` | Жирный символ | $\symbf{A}$ |
| `\symbfit{x}` | Жирный курсивный символ | $\symbfit{\alpha}$ |
| `\symup{x}` | Прямой символ | $\symup{\alpha}$ |
| `\symbfup{x}` | Жирный прямой символ | $\symbfup{\Omega}$ |

В XeLaTeX/LuaLaTeX эти команды предоставляются `unicode-math`. В pdfLaTeX пакет определяет их через `\boldsymbol` и пакет `upgreek`.

---

## 7. Примеры использования

### Минимальный пример (pdfLaTeX)

```latex
\documentclass[14pt]{extarticle}
\usepackage[font=tempora]{cmcmsugost-fontselector}
\usepackage{cmcmsu-gost}

\begin{document}
\section{Введение}
Формула Эйлера: $e^{i\pi} + 1 = 0$.
\end{document}
```

### XeLaTeX с готовым набором

```latex
\documentclass[14pt]{extarticle}
\usepackage[font=libertinus, upgreek]{cmcmsugost-fontselector}
\usepackage{cmcmsu-gost}

\begin{document}
\section{Введение}
Здесь $\alpha$ и $\beta$ набраны прямым шрифтом.
\end{document}
```

### XeLaTeX с ручным выбором каждого семейства

```latex
\documentclass[14pt]{extreport}
\usepackage[
    font       = ebgaramond,
    fontscale  = 1.02,
    sans       = firasans,
    mono       = jetbrainsmono,
    monoscale  = 0.88,
    mathfont   = garamondmath,
    upgreek,
    mathcalold
]{cmcmsugost-fontselector}
\usepackage[spacing=15, tocpagewordon]{cmcmsu-gost}

\begin{document}
\tableofcontents
\chapter{Введение}
Текст набран EB Garamond, код — \texttt{JetBrains Mono}.
\end{document}
```

### Имитация MS Office (XeLaTeX, системные шрифты)

```latex
\documentclass[14pt]{extarticle}
\usepackage[font=msoffice]{cmcmsugost-fontselector}
\usepackage{cmcmsu-gost}

\begin{document}
\section{Результаты}
Times New Roman как в Word.
\end{document}
```

> **Внимание.** Набор `msoffice` требует, чтобы шрифты Times New Roman, Arial и Courier New были установлены в операционной системе.

---

## 8. Краткая справка по опциям

| Опция | Тип | Умолчание | Описание |
|---|---|---|---|
| `font` | строка | *(пусто)* | Имя набора или отдельного шрифта |
| `fontscale` | число | `1` | Масштаб основного шрифта (XeLaTeX) |
| `sans` | строка | *(пусто)* | Шрифт без засечек |
| `sansscale` | число | `1` | Масштаб sans |
| `mono` | строка | *(пусто)* | Моноширинный шрифт |
| `monoscale` | число | `1` | Масштаб mono |
| `mathfont` | строка | *(пусто)* | Математический шрифт |
| `mathfontscale` | число | `1` | Масштаб math |
| `lang` | строка | `russian` | Язык для babel |
| `upgreek` | bool | `false` | Прямые греческие буквы |
| `mathcalold` | bool | `false` | Старый стиль `\mathcal` (XeLaTeX) |
| `microtype` | bool | `true` | Микротипографика |
