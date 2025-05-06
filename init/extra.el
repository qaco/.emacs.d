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
  :config
  (recentf-mode 1)
  (setq recentf-max-saved-items 50))

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

(use-package avy
  :ensure t
  :bind
  ("M-g c" . avy-goto-char)
  ("M-g l" . avy-goto-line)
  ("M-g w" . avy-goto-word-1))

;; System

(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  (setq doom-modeline-icon nil))

;; Require the installation of xclip system-wide
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

;; Text edition

(use-package move-text
  :ensure t
  :bind (("C-M-<up>" . move-text-up)
         ("C-M-<down>" . move-text-down)))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp)))

;; Programmation specific

(use-package snakemake-mode
  :ensure t
  :mode ("\\Snakefile\\'" . snakemake-mode))

(use-package company
  :ensure t
  :init
  (global-company-mode)
  :config
  (advice-add 'completion-at-point :override #'company-complete)
  )

;; (use-package highlight-indentation
;;   :ensure t
;;   :config
;;   (setq highlight-indentation-blank-lines t)
;;   :hook (prog-mode . highlight-indentation-mode))

(use-package indent-guide
  :ensure t
  :hook (prog-mode . indent-guide-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (z3-smt2-mode . rainbow-delimiters-mode)
         (z3-mode . rainbow-delimiters-mode)))

;; Text specific

(use-package visual-fill-column
  :hook
  (text-mode . visual-line-mode)
  (text-mode . (lambda ()
                 (unless (derived-mode-p 'org-mode)
                   (visual-fill-column-mode))))
  :config
  (setq visual-fill-column-width 80)
  :ensure t
  )

(use-package yaml-mode
  :ensure t
  )

(provide 'extra)
