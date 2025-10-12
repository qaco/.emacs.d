;; External tools

(defvar browse-url-browser-function 'browse-url-firefox)
(defvar compile-command "make")

;; Edition defaults

(setq initial-major-mode 'text-mode)
(global-auto-revert-mode t)
(save-place-mode 1)
(setq save-place-forget-unreadable-files nil)

;; Mouse in the therminal
(xterm-mouse-mode 1)

;; Scroll one line at a time
(setq scroll-step 1
      auto-window-vscroll nil
      scroll-conservatively 10000)

(setq compilation-scroll-output t)

(setq-default indent-tabs-mode nil) ; uses spaces for indentation
(delete-selection-mode t) ; typing replaces the selection
(setq case-fold-search t) ; case-insensitive search

;; User inteface defaults

(setq column-number-mode t)

(blink-cursor-mode 0) ; stop the cursor from blinking
(setq initial-scratch-message nil) ; disable initial scratch message

(show-paren-mode t) ; highlight matching parentheses
(global-hl-line-mode t) ; highlight the current line

(setq-default display-fill-column-indicator-column 80)

(unless (display-graphic-p)
  (setq frame-background-mode 'dark)
  (add-to-list 'default-frame-alist '(background-mode . dark)))

;; Less confirms
(fset 'yes-or-no-p 'y-or-n-p) ; use y/n instead of yes/no
(setq confirm-nonexistent-file-or-buffer nil ; create file without confirm
      vc-follow-symlinks nil ; follows symlinks
      revert-without-query '(".*")) ; reverts buffer

(icomplete-mode 1)
(setq read-file-name-completion-ignore-case t)
(setq read-file-name-function 'read-file-name-default)

(if (version<= "28.0" emacs-version)
    (fido-vertical-mode 1)
  (fido-mode 1))

(setq ido-everywhere t
      ido-create-new-buffer 'always
      ido-auto-merge-work-directories-length -1)

;; Language-dependant

(require 'tablegen-mode)
(require 'mlir-mode)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)
(add-hook 'tex-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'visual-line-mode)

;; Functions

(require 'standalone-functions)

;; Keys

;; display informations
(global-set-key (kbd "C-x \"") 'display-fill-column-indicator-mode)
(global-set-key (kbd "C-x l") 'count-lines-page)

;; windows
(global-set-key (kbd "C-x 2") 'split-window-below-and-center-cursor)
(global-set-key (kbd "<C-right>")   'windmove-right)
(global-set-key (kbd "<C-left>")   'windmove-left)
(global-set-key (kbd "<C-up>")   'windmove-up)
(global-set-key (kbd "<C-down>")   'windmove-down)

;; edit
(advice-add 'comment-region :before #'copy-region-as-kill)
(global-set-key (kbd "C-k") #'my/kill-line-smart)
(global-set-key (kbd "C-q")   'delete-region)
(global-set-key (kbd "C-j") #'(lambda() (interactive) (delete-region (point) (line-end-position))))
(global-set-key (kbd "C-x q") 'join-line)
(global-set-key (kbd "C-w") #'(lambda() (interactive) (if mark-active
                                                          (kill-region (mark) (point))
                                                        (wise-kill-line))))
(global-set-key (kbd "M-w") #'(lambda() (interactive) (if mark-active
                                                          (copy-region-as-kill (mark) (point))
                                                        (wise-copy-line))))
(global-set-key (kbd "S-<up>") 'move-line-up)
(global-set-key (kbd "S-<down>") 'move-line-down)
(add-hook 'after-change-major-mode-hook
          (lambda ()
            (local-set-key (kbd "M-TAB") #'completion-at-point)))

;; navigation
(global-set-key (kbd "C-a") 'smarter-beginning-of-line)
(global-set-key (kbd "<mouse-4>") 'previous-line)
(global-set-key (kbd "<mouse-5>") 'next-line)
(global-set-key (kbd "M-p") #'(lambda() (interactive) (forward-line -5)))
(global-set-key (kbd "M-n") #'(lambda() (interactive) (forward-line 5)))

;; buffers
(global-set-key (kbd "C-x C-<up>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'above)))
(global-set-key (kbd "C-x C-<down>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'below)))
(global-set-key (kbd "C-x C-<left>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'left)))
(global-set-key (kbd "C-x C-<right>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'right)))
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

;; System
(global-set-key (kbd "C-c c") 'my/project-compile-command)
(global-set-key (kbd "C-c r") 'my/project-recompile-command)
(global-set-key (kbd "C-c n") 'next-error)
(global-set-key (kbd "C-x C-w") 'write-file)
(global-set-key (kbd "C-x w") 'save-buffer-copy)
(global-set-key (kbd "M-o i") #'(lambda() (interactive) (message (buffer-file-name))))
(global-set-key (kbd "M-o M-i") #'(lambda() (interactive) (kill-new (message (buffer-file-name)))))

(provide 'init-standalone)
