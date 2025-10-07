(use-package snakemake-mode
  :ensure t
  :mode ("\\`Snakefile\\'" . snakemake-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (z3-smt2-mode . rainbow-delimiters-mode)
         (z3-mode . rainbow-delimiters-mode)))

(use-package eglot
  :ensure t
  :hook ((python-mode . eglot-ensure)
         (js-mode . eglot-ensure)
         (go-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
         (rust-mode . eglot-ensure)
         (mlir-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs '(mlir-mode . ("mlir-lsp-server")))
  (local-set-key (kbd "TAB") 'indent-for-tab-command)
  (local-set-key (kbd "M-/") 'eglot-rename)
  )

(provide 'init-languages)
