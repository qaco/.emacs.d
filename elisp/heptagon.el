(require 'font-lock)

(defvar heptagon-mode-hook nil)

(defvar heptagon-mode-map
  (let ((heptagon-mode-map (make-keymap)))
    (define-key heptagon-mode-map "\C-j" 'newline-and-indent)
    heptagon-mode-map)
  "Keymap for Heptagon major mode")

;; SYNTAX HIGHLIGHTING

(defvar heptagon-font-lock-keywords nil
  "Regular expression used by Font-lock mode.")

(setq heptagon-font-lock-keywords
      '(
        ;; function declarations, file directives, strings and comments

        ("node *\\([a-zA-Z0-9_-]*\\) *(" 1 font-lock-function-name-face)
        ("fun *\\([a-zA-Z0-9_-]*\\) *(" 1 font-lock-function-name-face)
        ("\\([a-zA-Z0-9_-]+\\) *: [a-zA-Z0-9_-]* *;" 1 font-lock-variable-name-face)
        ("(\\([a-zA-Z0-9_-]+\\) *: [a-zA-Z0-9_-]*)" 1 font-lock-variable-name-face)
        ;; language keywords, type names, named constant values
        
        ("\\<\\(node\\|fun\\|var\\)\\>[ \t\n]" . font-lock-keyword-face)
        ("\\<\\(let\\|tel\\)\\>[ \t\n]" . font-lock-keyword-face)
        ("\\<\\(if\\|then\\|else\\)\\>[ \t\n]" . font-lock-keyword-face)
        ("\\<\\(bool\\|int\\|float\\)\\(\\^[^ ;,)]+\\)?\\>" . font-lock-type-face)

        ("\\(\\<\\(fby\\|pre\\)\\>\\|->\\)" . font-lock-keyword-face)
        ("\\(\\<\\(or\\|xor\\|xor\\|not\\)\\>\\|&\\)" . font-lock-keyword-face)
        
        ("\\<\\(automaton\\|end\\)\\>[ \t\n]" . font-lock-keyword-face)
        ("\\<\\(do\\|until\\)\\>[ \t\n]" . font-lock-keyword-face)
        ("\\<\\(state\\)\\>[ \t\n]" . font-lock-type-face)


        ))

(defun heptagon-font-mode ()
  "Initialisation of font-lock for Heptagon mode."
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
        '(heptagon-font-lock-keywords t)))

(if window-system
    (progn
	(add-hook 'heptagon-mode-hook
		  'turn-on-font-lock)
	(add-hook 'heptagon-mode-hook
		  'heptagon-font-mode)
        (setq font-lock-maximum-decoration t)))

(defvar heptagon-mode-syntax-table
  (let ((heptagon-mode-syntax-table (make-syntax-table)))
    ; This is added so entity names with underscores can be more easily parsed
    (modify-syntax-entry ?_ "w" heptagon-mode-syntax-table)
    heptagon-mode-syntax-table)
  "Syntax table for heptagon-mode")

(defun heptagon-mode ()
  "Major mode for editing Heptagon files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table heptagon-mode-syntax-table)
  (use-local-map heptagon-mode-map)
  ;; (set (make-local-variable 'font-lock-defaults)
  ;;      '(heptagon-font-lock-keywords))
  ;; (add-hook 'heptagon-mode-hook
  ;;           'heptagon-font-mode)
  (setq major-mode 'heptagon-mode)
  (setq mode-name "Heptagon")
  (run-hooks 'heptagon-mode-hook))

(provide 'heptagon-mode)

    
