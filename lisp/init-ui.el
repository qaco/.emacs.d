(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp)))

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :config
  (advice-add 'completion-at-point :override #'company-complete)
  )

(use-package free-keys
  :ensure t
  :commands free-keys)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/theme 'respectful
	sml/pre-modes-separator " • ")
  (sml/setup)
  )

(provide 'init-ui)
