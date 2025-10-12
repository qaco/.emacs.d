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
        recentf-max-saved-items 50
        recentf-auto-cleanup 'never)
  :config
  (recentf-mode 1)
  (add-hook 'kill-emacs-hook #'recentf-save-list)
  (run-with-idle-timer 300 t #'recentf-save-list)
  (run-with-idle-timer 600 t #'recentf-cleanup)
  )

(use-package consult
  :ensure t
  :commands
  (consult-recent-file consult-xref consult-buffer consult-line consult-yank-from-kill-ring)
  :bind
  (
   ("C-x C-r" . consult-recent-file)
   ("C-x C-b" . consult-buffer)
   ("C-x b" . consult-buffer)
   ("C-c s" . consult-line)
   ("M-y" . consult-yank-from-kill-ring)
   )
  :init
  (setq consult-preview-key nil)
  (with-eval-after-load 'xref
    (setq xref-show-definitions-function #'consult-xref
          xref-show-xrefs-function       #'consult-xref)))

(provide 'init-system)
