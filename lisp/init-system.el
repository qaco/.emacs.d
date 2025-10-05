(setq select-enable-clipboard t
      select-enable-primary t)

(use-package xclip
  :ensure t
  :config
  (xclip-mode 1))

(use-package recentf
  :ensure t
  :init
  (setq recentf-save-file (expand-file-name ".recentf" user-emacs-directory)
        recentf-max-saved-items 50)
  :config
  (recentf-mode 1))

(use-package consult
  :ensure t
  :bind ("C-x C-r" . consult-recent-file)
  :config
  (setq consult-preview-key nil)
  )

(setq xref-show-definitions-function #'consult-xref)
(setq xref-show-xrefs-function #'consult-xref)

(provide 'init-system)
