(add-to-list
 'package-archives
 '("melpa-stable" . "https://stable.melpa.org/packages/")
 t)
(setq package-install-upgrade-built-in t)
(package-initialize)

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

(setq package-archive-enable-alist nil)

;; Elisp primitives

(use-package seq
  :ensure t)

;; File & buffer management

(use-package recentf
  :ensure t
  :config
  (recentf-mode 1)
  (setq recentf-max-saved-items 50))

(use-package consult
  :ensure t
  :bind ("C-x C-r" . consult-recent-file))

(use-package ibuffer
  :ensure t
  :bind ("C-x B" . ibuffer)
  :config
  (setq ibuffer-expert t))

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

(use-package eglot
  :ensure t
  :hook
  (python-mode . eglot-ensure))

(use-package company
  :ensure t
  :hook (python-mode . company-mode))

(use-package lsp-pyright
  :ensure t
  :config
  (setq lsp-pyright-langserver-command "pyright"))

(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-doc-show-with-mouse nil))

(defun my/python-mode-setup ()
  "Custom configurations for python-mode."
  (require 'lsp-pyright)
  (lsp-deferred)
  (setq-local eldoc-echo-area-use-multiline-p 1)
  ;; (setq-local electric-indent-mode -1)
  (setq-local lsp-pyright-venv-path (pyright--locate-python-venv))
  (local-set-key (kbd "TAB") 'indent-for-tab-command))

(add-hook 'python-mode-hook 'my/python-mode-setup)

(use-package highlight-indentation
  :ensure t
  :config
  (setq highlight-indentation-blank-lines t)
  :hook (prog-mode . highlight-indentation-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (z3-smt2-mode . rainbow-delimiters-mode)
         (z3-mode . rainbow-delimiters-mode)))

(provide 'extra)
