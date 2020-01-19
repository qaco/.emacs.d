
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
