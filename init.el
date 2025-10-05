(require 'init-standalone)
(require 'use-package)
(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/")
 t)

(setq package-install-upgrade-built-in t)
(package-initialize)

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

(setq package-archive-enable-alist nil)

(require 'init-text)
(require 'init-ui)
(require 'init-system)
(require 'init-windows)
(require 'init-edit)
(require 'init-git)
(require 'init-languages)
(require 'init-org)
(require 'init-console)
(require 'init-ai)
