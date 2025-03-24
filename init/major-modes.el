(require 'eglot)

(require 'tablegen-mode)

(require 'mlir-mode)
(add-to-list 'eglot-server-programs '(mlir-mode . ("mlir-lsp-server")))
(add-hook 'mlir-mode-hook 'eglot-ensure)

(provide 'major-modes)
