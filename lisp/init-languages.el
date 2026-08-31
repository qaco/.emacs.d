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
  (add-to-list 'eglot-server-programs '((c-mode c++-mode) . ("clangd")))
  )

(with-eval-after-load 'eglot
  (cl-defmethod eglot-register-capability
    (server (method (eql workspace/didChangeWatchedFiles)) id
            &key watchers &allow-other-keys)
    (ignore server method id watchers)
    nil))

(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-offset 'arglist-close 0)
            (c-set-offset 'arglist-cont-nonempty 'c-lineup-arglist)
            (c-set-offset 'arglist-intro '+)))

(add-hook 'eglot-managed-mode-hook
          (lambda () (eglot-inlay-hints-mode -1)))
          
(use-package tablegen-mode
  :load-path "lisp"
  :mode "\\.td\\'"
  :hook ((tablegen-mode . eglot-ensure)
         (tablegen-mode . display-line-numbers-mode)))

(require 'llvm-mode)
(require 'llvm-mir-mode)

(provide 'init-languages)
