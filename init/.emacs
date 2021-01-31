
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq load-path (append load-path '("~/.emacs.d/elisp")))
(setq load-path (append load-path '("~/.emacs.d/init/parts")))

(require 'my-packages)
(require 'appearence)
(require 'default-behaviours)
(require 'filesystem)
(require 'my-caml)
(require 'shortcuts)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (modern-cpp-font-lock smex scala-mode sbt-mode rust-mode projectile markdown-mode+ magit ido-vertical-mode go-mode flycheck-rust feature-mode dockerfile-mode dired-subtree buffer-move base16-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
