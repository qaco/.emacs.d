(require 'font-lock)

(defvar heptagon-mode-hook nil)

(defvar heptagon-font-lock-keywords nil
  "Regular expression used by Font-lock mode.")

(setq heptagon-font-lock-keywords
      '(
	;; Commentaires
        ("(\\*\\(.\\|\n\\)*?\\*)" . font-lock-comment-face)
	;; Mots-clés
	("\\<\\(open\\|fun\\|node\\|let\\|tel\\|var\\|returns\\|const\\|type\\|if\\|then\\|else\\|end\\|switch\\|do\\)\\>" . font-lock-keyword-face)
	;; Fonctions
	("\\<\\(map\\|mapi\\|fold\\|foldi\\|mapfold\\)\\>" . font-lock-builtin-face)
	("\\([a-zA-Z0-9_-]*\\)\\( \\|\n\\)*<<" 1 font-lock-function-name-face)
	("\\([a-zA-Z0-9_-]*\\)\\( \\|\n\\)*(" 1 font-lock-function-name-face)
        ("fun *\\([a-zA-Z0-9_-]*\\) *" 1 font-lock-function-name-face)
	("node *\\([a-zA-Z0-9_-]*\\) *" 1 font-lock-function-name-face)
	("\\<\\(fby\\|pre\\|->\\|and\\|or\\)\\>" . font-lock-builtin-face)
	("\\<\\(when\\|whenot\\|merge\\)\\>" . font-lock-builtin-face)
	;; Variables
        ("\\<\\([a-zA-Z0-9_-]*\\) *:" 1 font-lock-variable-name-face)
	;; Types
	(": *\\([a-zA-Z0-9\\_\\-\\^]*\\) *" 1 font-lock-type-face)
	("type *\\([a-zA-Z0-9_-]*\\) *" 1 font-lock-type-face)
	("type *\\([a-zA-Z0-9_-]*\\) * = *\\([a-zA-Z0-9\\_\\-\\^| ]*\\)" 2 font-lock-type-face)
        ;; ("\\(>>\\|<<\\)" . font-lock-string-face)
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

(defun heptagon-mode ()
  "Major mode for editing Heptagon files"
  (interactive)
  (kill-all-local-variables)
  (setq-local comment-start "(* ")
  (setq-local comment-end " *)")
  (setq major-mode 'heptagon-mode)
  (setq mode-name "Heptagon")
  (run-hooks 'heptagon-mode-hook))

(setq auto-mode-alist (cons '("\\.ept" . heptagon-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.epi" . heptagon-mode) auto-mode-alist))

(provide 'heptagon-mode)
