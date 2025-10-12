(use-package snakemake-mode
  :ensure t
  :mode ("\\`Snakefile\\'" . snakemake-mode))

(use-package eglot
  :ensure t
  :hook ((python-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
         (mlir-mode . eglot-ensure)
         )
  :config
  (add-to-list 'eglot-server-programs '(mlir-mode . ("mlir-lsp-server")))
  (local-set-key (kbd "TAB") 'indent-for-tab-command)
  (local-set-key (kbd "M-/") 'eglot-rename)
  )

(provide 'init-languages)
