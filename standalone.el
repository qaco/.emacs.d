(setq load-path (append load-path '("~/conf/.emacs.d/init")))
(setq load-path (append load-path '("~/conf/.emacs.d/major-modes")))

(require 'standalone)
(require 'my-mode-line)
(require 'mlir-mode)
(require 'tablegen-mode)
