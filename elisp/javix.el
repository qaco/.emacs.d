(require 'font-lock)

(defvar javix-mode-hook nil)

(defvar javix-font-lock-keywords nil
  "Regular expression used by Font-lock mode.")

(setq javix-font-lock-keywords
      '(
        ("^\\( \\|\t\\)*;[^\n]*\n" . font-lock-string-face)
        ("[^:\n]*: *\n" . font-lock-function-name-face)
        ("^\\.[^\n]*\n" . font-lock-variable-name-face)
        ))

(defun javix-font-mode ()
  "Initialisation of font-lock for Javix mode."
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
        '(javix-font-lock-keywords t)))

(if window-system
    (progn
	(add-hook 'javix-mode-hook
		  'turn-on-font-lock)
	(add-hook 'javix-mode-hook
		  'javix-font-mode)
        (setq font-lock-maximum-decoration t)))

(defun javix-mode ()
  "Major mode for editing Javix files"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'javix-mode)
  (setq mode-name "Javix")
  (run-hooks 'javix-mode-hook))

(provide 'javix-mode)
