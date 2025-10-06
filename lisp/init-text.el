(use-package yaml-mode
  :ensure t)

(use-package markdown-mode
  :ensure t
  :config
  (add-hook 'markdown-mode-hook #'markdown-toggle-url-hiding)
  )

(use-package olivetti
  :ensure t
  :hook (text-mode . (lambda ()
                       (unless (derived-mode-p 'yaml-mode 'org-mode)
                         (olivetti-mode 1))))
  :config
  (setq olivetti-body-width 80))

(provide 'init-text)
