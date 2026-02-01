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
  ;; meta is just alt (not esc) - must be set after company loads
  (setq meta-prefix-char nil))

(use-package free-keys
  :ensure t
  :commands free-keys)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(provide 'init-ui)
