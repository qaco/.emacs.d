(unless (bound-and-true-p my/early-init-loaded)
  (require 'early-init))
(require 'init-standalone)
(require 'use-package)

(use-package package
  :config
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives
               '("melpa-stable" . "https://stable.melpa.org/packages/") t)
  (add-to-list 'package-pinned-packages '(consult . "melpa-stable"))
  (setq package-install-upgrade-built-in t
        package-archive-enable-alist nil)
  (package-initialize))
  
(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

(use-package init-git
  :load-path "lisp")

(use-package init-text
  :load-path "lisp")

(use-package init-ui
  :load-path "lisp")

(use-package init-system
  :load-path "lisp")

(use-package init-windows
  :load-path "lisp")

(use-package init-edit
  :load-path "lisp")

(use-package init-languages
  :load-path "lisp")

(use-package init-org
  :load-path "lisp")

(use-package init-console
  :load-path "lisp")

(use-package init-ai
  :load-path "lisp")
