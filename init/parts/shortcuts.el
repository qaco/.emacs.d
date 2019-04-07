(require 'extra-commands)
(require 'buffer-move)
(require 'auto-close-shell)
(require 'fill-column-indicator)
(require 'smarter-edition)

;; display informations

(global-set-key (kbd "C-<f5>") 'fci-mode)
(global-set-key (kbd "C-x l") 'linum-mode)
(global-set-key (kbd "M-l") 'count-lines-page)

;; edit

(global-set-key (kbd "C-y") 'yank-and-indent)
(global-set-key (kbd "C-a") 'smarter-beginning-of-line)
(global-set-key (kbd "C-<return>") 'newline-above)
(global-set-key (kbd "C-k") 'smarter-kill-line)
(global-set-key (kbd "C-x <down>") 'reverse-region)
(global-set-key (kbd "C-w") 'kill-region-or-line)
(global-set-key (kbd "M-w") 'copy-region-or-line)
(global-set-key (kbd "M-_") 'undo-only)
(global-set-key (kbd "C-:") 'dabbrev-expand)

;; manage windows

;; S-arrow pour naviger entre les fenêtres
(windmove-default-keybindings)
(global-set-key (kbd "<f5>") 'split-window-horizontally)
(global-set-key (kbd "<f6>") 'split-window-vertically)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)
(global-set-key (kbd "C-x k")  'kill-current-buffer)
(global-set-key (kbd "C-x C-k")  'kill-other-buffers)

;; manage files

(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
(global-set-key (kbd "C-x g") 'magit-status)
 (global-set-key (kbd "<f4>") 'revert-buffer)
(global-set-key (kbd "C-x p") 'ps-print-buffer)

;; compile

(global-set-key (kbd "<f1>") 'compile)
(global-set-key (kbd "C-<f1>") 'new-compile-cmd)
(global-set-key (kbd "<f2>") 'recompile)
(global-set-key (kbd "<f3>") 'next-error)

;; command

(global-set-key (kbd "M-x") 'smex)
 ;; Préfixe C-u pour en créer un nouveau
(global-set-key (kbd "C-x C-x") 'auto-close-shell)

(provide 'shortcuts)
