;;; Настройка Emacs для экспорта Org-mode → LaTeX (cmcmsuthesis)
;;;
;;; Добавьте этот фрагмент в ваш ~/.emacs или ~/.emacs.d/init.el
;;; Он определяет два LaTeX-класса для org-export:
;;;   ruarticle — для курсовых и бакалаврских/магистерских работ
;;;   rureport  — для диссертаций (кандидатских, докторских)

(with-eval-after-load 'ox-latex

  ;; --- ruarticle: article + пакеты cmcmsuthesis ---
  (add-to-list 'org-latex-classes
    '("ruarticle"
      "\\documentclass[14pt]{extarticle}
\\usepackage{cmcmsugost-fontselector}
\\usepackage{cmcmsu-gost}
\\usepackage{cmcmsugost-extra}
[NO-DEFAULT-PACKAGES]
[EXTRA]
[PACKAGES]"
      ("\\section{%s}"       . "\\section*{%s}")
      ("\\subsection{%s}"    . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}"     . "\\paragraph*{%s}")))

  ;; --- rureport: report + пакеты cmcmsuthesis ---
  (add-to-list 'org-latex-classes
    '("rureport"
      "\\documentclass[14pt]{extreport}
\\usepackage{cmcmsugost-fontselector}
\\usepackage{cmcmsu-gost}
\\usepackage{cmcmsugost-extra}
[NO-DEFAULT-PACKAGES]
[EXTRA]
[PACKAGES]"
      ("\\chapter{%s}"       . "\\chapter*{%s}")
      ("\\section{%s}"       . "\\section*{%s}")
      ("\\subsection{%s}"    . "\\subsection*{%s}")
      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
      ("\\paragraph{%s}"     . "\\paragraph*{%s}")))

  ;; --- Настройки компиляции ---
  ;; XeLaTeX (рекомендуется)
  (setq org-latex-compiler "xelatex")

  ;; Полная цепочка компиляции с biber
  (setq org-latex-pdf-process
        '("%latex -interaction nonstopmode -output-directory %o %f"
          "biber %b"
          "%latex -interaction nonstopmode -output-directory %o %f"
          "%latex -interaction nonstopmode -output-directory %o %f"))

  ;; --- Теоремные окружения для Org-mode ---
  ;; Позволяет использовать #+begin_theorem ... #+end_theorem и т.п.
  (add-to-list 'org-latex-custom-lang-environments
               '(theorem "theorem"))
  (add-to-list 'org-latex-custom-lang-environments
               '(lemma "lemma"))
  (add-to-list 'org-latex-custom-lang-environments
               '(proposition "proposition"))
  (add-to-list 'org-latex-custom-lang-environments
               '(corollary "corollary"))
  (add-to-list 'org-latex-custom-lang-environments
               '(definition "definition"))
  (add-to-list 'org-latex-custom-lang-environments
               '(example "example"))
  (add-to-list 'org-latex-custom-lang-environments
               '(problem "problem"))
  (add-to-list 'org-latex-custom-lang-environments
               '(remark "remark"))
  (add-to-list 'org-latex-custom-lang-environments
               '(proof "proof"))
  )
