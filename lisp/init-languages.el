(use-package snakemake-mode
  :ensure t
  :mode ("\\`Snakefile\\'" . snakemake-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (z3-smt2-mode . rainbow-delimiters-mode)
         (z3-mode . rainbow-delimiters-mode)))

(provide 'init-languages)
