;; Init file to use with the orgmode plugin.

;; Load org-mode
;; Requires org-mode v8.x

(require 'package)
(setq package-load-list '((htmlize t)))
(package-initialize)

(require 'org)
(require 'ox-html)

;;; Custom configuration for the export.

;;; Add any custom configuration that you would like to 'conf.el'.
(setq nikola-use-pygments t
      org-export-with-toc nil
	  org-export-with-section-numbers t
	  sh-basic-offset 4
	  tab-width 4
      org-startup-folded 'showeverything)
(defvaralias 'c-basic-offset 'tab-width)

;; Load additional configuration from conf.el
(let ((conf (expand-file-name "conf.el" (file-name-directory load-file-name))))
  (if (file-exists-p conf)
      (load-file conf)))

;;; Macros

;; Load Nikola macros
(setq nikola-macro-templates
      (with-current-buffer
          (find-file
           (expand-file-name "macros.org" (file-name-directory load-file-name)))
        (org-macro--collect-macros)))

;;; Code highlighting
(defun org-html-decode-plain-text (text)
  "Convert HTML character to plain TEXT. i.e. do the inversion of
     `org-html-encode-plain-text`. Possible conversions are set in
     `org-html-protect-char-alist'."
  (mapc
   (lambda (pair)
     (setq text (replace-regexp-in-string (cdr pair) (car pair) text t t)))
   (reverse org-html-protect-char-alist))
  text)

;; Use pygments highlighting for code
(defun pygmentize (lang code)
  "Use Pygments to highlight the given code and return the output"
  (with-temp-buffer
    (insert code)
    (let ((lang (or (cdr (assoc lang org-pygments-language-alist)) "text")))
      (shell-command-on-region (point-min) (point-max)
                               (format "pygmentize -f html -l %s" lang)
                               (buffer-name) t))
    (buffer-string)))

(defconst org-pygments-language-alist
  '(("asymptote" . "asymptote")
    ("awk" . "awk")
    ("c" . "c")
    ("c++" . "cpp")
	("conf" . "ini")
    ("cpp" . "cpp")
    ("clojure" . "clojure")
    ("css" . "css")
    ("d" . "d")
    ("emacs-lisp" . "scheme")
    ("F90" . "fortran")
    ("gnuplot" . "gnuplot")
    ("groovy" . "groovy")
    ("haskell" . "haskell")
	("ini" . "ini")
    ("java" . "java")
    ("js" . "js")
    ("julia" . "julia")
    ("latex" . "latex")
    ("lisp" . "lisp")
    ("makefile" . "makefile")
    ("matlab" . "matlab")
	("mysql" . "mysql")
	("mscgen" . "mscgen")
    ("ocaml" . "ocaml")
    ("octave" . "octave")
	("pacmanconf" . "pacmanconf")
    ("perl" . "perl")
    ("picolisp" . "scheme")
    ("python" . "python")
    ("r" . "r")
    ("ruby" . "ruby")
    ("sass" . "sass")
    ("scala" . "scala")
    ("scheme" . "scheme")
	("systemd" . "sv")
    ("sh" . "sh")
	("shell" . "sh")
    ("sql" . "sql")
    ("sqlite" . "sqlite3")
    ("tcl" . "tcl"))
  "Alist between org-babel languages and Pygments lexers.
lang is downcased before assoc, so use lowercase to describe language available.
See: http://orgmode.org/worg/org-contrib/babel/languages.html and
http://pygments.org/docs/lexers/ for adding new languages to the mapping.")

;; Override the html export function to use pygments
(defun org-html-src-block (src-block contents info)
  "Transcode a SRC-BLOCK element from Org to HTML.
CONTENTS holds the contents of the item.  INFO is a plist holding
contextual information."
  (if (org-export-read-attribute :attr_html src-block :textarea)
      (org-html--textarea-block src-block)
    (let ((lang (org-element-property :language src-block))
          (code (org-element-property :value src-block))
          (code-html (org-html-format-code src-block info)))
      (if nikola-use-pygments
          (pygmentize (downcase lang) (org-html-decode-plain-text code))
        code-html))))

;; Export images with custom link type
(defun org-custom-link-img-url-export (path desc format)
  (cond
   ((eq format 'html)
    (format "<img src=\"%s\" alt=\"%s\"/>" path desc))))
(org-add-link-type "img-url" nil 'org-custom-link-img-url-export)

;; Export function used by Nikola.
(defun nikola-html-export (infile outfile)
  "Export the body only of the input file and write it to
specified location."
  (with-current-buffer (find-file infile)
    (org-macro-replace-all nikola-macro-templates)
    (org-html-export-as-html nil nil t t)
	(write-file outfile nil)))

;; https://coldnew.github.io/a1ed40e3/
(defadvice org-html-paragraph (before org-html-paragraph-advice
                                      (paragraph contents info) activate)
  "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
  (let* ((origin-contents (ad-get-arg 1))
         (fix-regexp "[[:multibyte:]]")
         (fixed-contents
          (replace-regexp-in-string
           (concat
            "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))
	(ad-set-arg 1 fixed-contents)))

(setq org-html-text-markup-alist '((bold . "<b>%s</b>")
								   (code . "<code>%s</code>")
								   (italic . "<i>%s</i>")
								   (strike-through . "<del>%s</del>")
								   (underline . "<span class=\"underline\">%s</span>")
								   (verbatim . "<kbd>%s</kbd>")))

(setcar org-emphasis-regexp-components " \t('\"{[:alpha:]")
(setcar (nthcdr 1 org-emphasis-regexp-components) "[:alpha:]- \t.,:!?;'\")}\\")
(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
