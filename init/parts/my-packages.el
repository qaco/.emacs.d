(require 'package)

(package-initialize)

(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)

(package-initialize)

(setq package-list '(base16-theme
		     buffer-move
		     ido-vertical-mode
                     smex
                     magit
                     recentf))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(provide 'my-packages)
