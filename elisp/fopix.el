(require 'font-lock)

(defvar fopix-mode-hook nil)

(defvar fopix-font-lock-keywords nil
  "Regular expression used by Font-lock mode.")

(setq fopix-font-lock-keywords
      '(
        ("/\\*\\(.\\|\n\\)*?\\*/" . font-lock-comment-face)
        ;; ("@.*\n" . font-lock-string-face)
        ("def *\\([a-zA-Z0-9_-]*\\) *(" 1 font-lock-function-name-face)
        ("val *\\([a-zA-Z0-9_-]*\\) *=" 1 font-lock-variable-name-face)
        ("let *\\([a-zA-Z0-9_-]*\\) *=" 1 font-lock-variable-name-face)
        ("def *[a-zA-Z0-9_-]* *(\\(.*\\)) *=" 1 font-lock-variable-name-face)
        ("\\<\\(def\\|val\\|let\\|in\\|if\\|then\\|else\\|new\\)\\>" . font-lock-keyword-face)
        ("\\(&\\|?\\)" . font-lock-keyword-face)
        ))

(defun fopix-font-mode ()
  "Initialisation of font-lock for Fopix mode."
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
        '(fopix-font-lock-keywords t)))

(if window-system
    (progn
	(add-hook 'fopix-mode-hook
		  'turn-on-font-lock)
	(add-hook 'fopix-mode-hook
		  'fopix-font-mode)
        (setq font-lock-maximum-decoration t)))

(defun fopix-mode ()
  "Major mode for editing Fopix files"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'fopix-mode)
  (setq mode-name "Fopix")
  (run-hooks 'fopix-mode-hook))

(provide 'fopix-mode)
