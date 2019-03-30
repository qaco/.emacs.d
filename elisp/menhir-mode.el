(require 'font-lock)

(defvar menhir-mode-hook nil)

(defvar menhir-font-lock-keywords nil
  "Regular expression used by Font-lock mode.")

(setq menhir-font-lock-keywords
      '(
        ("\\(%\\|\\$\\)" 1 font-lock-warning-face)
        ("\\$\\(startpos\\|endpos\\)\\>" 1 font-lock-builtin-face)
        ("\\([a-z][a-z0-9]*\\):" 1 font-lock-function-name-face)
        ("%\\(token\\|nonassoc\\|right\\|left\\|start\\|inline\\)\\>"
         1 font-lock-keyword-face)
        ("\\<\\([A-Z]+\\)\\>" 1 font-lock-constant-face)
        ("<\\(.*\\)>" 1 font-lock-type-face)
        ))

(defun menhir-font-mode ()
  "Initialisation of font-lock for Menhir mode."
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
        '(menhir-font-lock-keywords t)))

(add-hook 'menhir-mode-hook 'turn-on-font-lock)
(add-hook 'menhir-mode-hook 'menhir-font-mode)
(setq font-lock-maximum-decoration t)

(defun menhir-mode ()
  "Major mode for editing Menhir files"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'menhir-mode)
  (setq mode-name "Menhir")
  (run-hooks 'menhir-mode-hook))
          
(setq auto-mode-alist (cons '("\\.mly" . menhir-mode) auto-mode-alist))

(provide 'menhir-mode)
