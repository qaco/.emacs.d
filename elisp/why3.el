; why3.el - GNU Emacs mode for Why3

(defvar why3-mode-hook nil)

(defvar why3-mode-map nil
  "Keymap for Why3 major mode")

(if why3-mode-map nil
  (setq why3-mode-map (make-keymap))
  (define-key why3-mode-map [(control return)] 'font-lock-fontify-buffer))

(setq auto-mode-alist
      (append
       '(("\\.\\(why\\|mlw\\)" . why3-mode))
       auto-mode-alist))

;; font-lock

(defun why3-regexp-opt (l)
  (concat "\\<" (concat (regexp-opt l t) "\\>")))

(defconst why3-font-lock-keywords-1
  (list
   ;; Note: comment font-lock is guaranteed by suitable syntax entries
   '("(\\*\\([^*)]\\([^*]\\|\\*[^)]\\)*\\)?\\*)" . font-lock-comment-face)
;   '("{}\\|{[^|]\\([^}]*\\)}" . font-lock-type-face)
   `(,(why3-regexp-opt '("invariant" "variant" "diverges" "requires" "ensures" "returns" "raises" "reads" "writes" "assert" "assume" "check")) . font-lock-type-face)
   `(,(why3-regexp-opt '("use" "clone" "namespace" "import" "export" "coinductive" "inductive" "external" "constant" "function" "predicate" "val" "exception" "axiom" "lemma" "goal" "type" "mutable" "model" "abstract" "private" "any" "match" "let" "rec" "in" "if" "then" "else" "begin" "end" "while" "for" "to" "downto" "do" "done" "loop" "absurd" "ghost" "raise" "try" "with" "theory" "uses" "module" "converter" "fun")) . font-lock-keyword-face)
   )
  "Minimal highlighting for Why3 mode")

(defvar why3-font-lock-keywords why3-font-lock-keywords-1
  "Default highlighting for Why3 mode")

;; syntax

(defvar why3-mode-syntax-table nil
  "Syntax table for why3-mode")

(defun why3-create-syntax-table ()
  (if why3-mode-syntax-table
      ()
    (setq why3-mode-syntax-table (make-syntax-table))
    (set-syntax-table why3-mode-syntax-table)
    (modify-syntax-entry ?' "w" why3-mode-syntax-table)
    (modify-syntax-entry ?_ "w" why3-mode-syntax-table)
    ; comments
    (modify-syntax-entry ?\( ". 1" why3-mode-syntax-table)
    (modify-syntax-entry ?\) ". 4" why3-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" why3-mode-syntax-table)
    ))

;; setting the mode
(defun why3-mode ()
  "Major mode for editing Why3 programs.
\\{why3-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (why3-create-syntax-table)
  ; hilight
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults '(why3-font-lock-keywords))
  ; OCaml style comments for comment-region, comment-dwim, etc.
  (set (make-local-variable 'comment-start) "(*")
  (set (make-local-variable 'comment-end)   "*)")
  ; menu
  ; providing the mode
  (setq major-mode 'why3-mode)
  (setq mode-name "Why3")
  (use-local-map why3-mode-map)
  (font-lock-mode 1)
  ; (why3-menu)
  (run-hooks 'why3-mode-hook))

(provide 'why3)
