(require 'init-standalone)
(require 'use-package)
(require 'package)

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/")
 t)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(setq package-archive-enable-alist nil)

(require 'use-package)

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
