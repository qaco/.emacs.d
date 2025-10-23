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
  :bind
  (:map eglot-mode-map
        ("TAB" . indent-for-tab-command)
        ("M-/" . eglot-rename))
  :config
  (add-to-list 'eglot-server-programs '(mlir-mode . ("mlir-lsp-server")))
  (add-to-list 'eglot-server-programs '((c-mode c++-mode) . ("ccls")))
  (setq eglot-workspace-configuration
        '(:ccls (:completion (:detailedLabel t)
                 :index (:threads 4)
                 :cache (:directory ".ccls-cache"))))
  )

(provide 'init-languages)
