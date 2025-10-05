;; Elisp primitives

(use-package seq
  :ensure t)

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

;; Programmation specific

(use-package snakemake-mode
  :ensure t
  :mode ("\\`Snakefile\\'" . snakemake-mode))

(provide 'init-extra)
