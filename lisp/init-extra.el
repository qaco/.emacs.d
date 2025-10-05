;; Elisp primitives

(use-package seq
  :ensure t)

;; General

(use-package consult
  :ensure t
  :bind ("C-x C-r" . consult-recent-file)
  :config
  (setq consult-preview-key nil)
  )

(setq xref-show-definitions-function #'consult-xref)
(setq xref-show-xrefs-function #'consult-xref)

;; File & buffer management

(use-package recentf
  :ensure t
  :init
  (setq recentf-save-file (expand-file-name ".recentf" user-emacs-directory)
        recentf-max-saved-items 50)
  :config
  (recentf-mode 1))
  

;; Window management

;; C-x w <n>: go to window n (kill if negative)
(use-package winum
  :ensure t
  :config
  (winum-mode))

(use-package windresize
  :ensure t
  :bind
  ("C-c w" . windresize))

;; System

;; Require the installation of xclip system-wide

(setq select-enable-clipboard t
      select-enable-primary t)

(use-package xclip
  :ensure t
  :config
  (xclip-mode 1))

(use-package free-keys
  :ensure t
  :commands free-keys)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Programmation specific

(use-package snakemake-mode
  :ensure t
  :mode ("\\`Snakefile\\'" . snakemake-mode))

(provide 'init-extra)
