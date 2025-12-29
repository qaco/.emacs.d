(use-package yaml-mode
  :ensure t)

(use-package markdown-mode
  :ensure t
  :config
  (add-hook 'markdown-mode-hook #'markdown-toggle-url-hiding)
  (add-hook 'markdown-mode-hook
          (lambda ()
            (define-key markdown-mode-map (kbd "M-p") nil)
            (define-key markdown-mode-map (kbd "M-n") nil))))

(use-package olivetti
  :ensure t
  :init
  (setq-default olivetti-body-width 80)
  :hook
  (text-mode . (lambda ()
                 (unless (derived-mode-p
                          'yaml-mode
                          'org-mode
                          'tex-mode
			  )
                   (olivetti-mode 1))))
  )

(provide 'init-text)
