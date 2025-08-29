(setq load-path (append load-path '("~/conf/.emacs.d/init")))
(setq load-path (append load-path '("~/conf/.emacs.d/major-modes")))

(require 'standalone)
(require 'use-package)
(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/")
 t)

(add-to-list
 'package-archives
 '("melpa-stable" . "https://stable.melpa.org/packages/")
 t)


(setq package-install-upgrade-built-in t)
(package-initialize)

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

(setq package-archive-enable-alist nil)

(require 'git)
(require 'extra)
(require 'org-conf)
(require 'console)
(require 'major-modes)
