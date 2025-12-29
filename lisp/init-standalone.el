(require 'standalone-functions)
(require 'tablegen-mode)
(require 'mlir-mode)

;;; External tools

(setq browse-url-browser-function 'browse-url-firefox
      compile-command "make")

;;; Editing defaults

(setq initial-major-mode 'text-mode
      compilation-scroll-output t
      case-fold-search t          ; case-insensitive search
      scroll-step 1
      auto-window-vscroll nil
      scroll-conservatively 10000
      fill-column 80)

(setq-default indent-tabs-mode nil)

(global-auto-revert-mode 1)
(save-place-mode 1)
(delete-selection-mode 1)

;;; Mouse & terminal behavior

(unless (display-graphic-p)
  (xterm-mouse-mode 1)
  (setq frame-background-mode 'dark)
  (add-to-list 'default-frame-alist '(background-mode . dark)))

;;; User interface defaults

(setq column-number-mode t
      blink-cursor-mode nil
      initial-scratch-message nil
      confirm-nonexistent-file-or-buffer nil
      vc-follow-symlinks nil
      revert-without-query '(".*")
      display-fill-column-indicator-column 80)

(fset 'yes-or-no-p 'y-or-n-p)

(show-paren-mode 1)
(global-hl-line-mode 1)
(icomplete-mode 1)

(add-to-list
 'display-buffer-alist
 '("\\*vc-diff\\*"
   (display-buffer-full-frame)))

;;; System

(setq confirm-nonexistent-file-or-buffer nil
      vc-follow-symlinks nil
      revert-without-query '(".*")
      read-file-name-completion-ignore-case t
      read-file-name-function 'read-file-name-default
      ido-everywhere t
      ido-create-new-buffer 'always
      ido-auto-merge-work-directories-length -1)

(if (boundp 'fido-vertical-mode)
    (fido-vertical-mode 1)
  (fido-mode 1))

(setq-default mode-line-format
	      '(" "
		"" "%3l:%2c"
		" · " (:eval (abbreviate-file-name default-directory)) (:eval (or (buffer-name) ""))
		" " mode-line-modified
		(:eval (when (and vc-mode (string-match "Git" vc-mode))
			 (concat " · " (substring-no-properties vc-mode 5))))
		" · " (:eval (format-mode-line mode-name))
	      ))

;;; Language-dependant

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'conf-mode-hook 'display-line-numbers-mode)
(add-hook 'tex-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'visual-line-mode)

;;; Keys

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
(global-set-key (kbd "M-k") 'delete-indentation)
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
(global-set-key (kbd "M-p") 'scroll-down-command)
(global-set-key (kbd "M-n") 'scroll-up-command)

;; buffers
(global-set-key (kbd "C-x C-<up>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'above)))
(global-set-key (kbd "C-x C-<down>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'below)))
(global-set-key (kbd "C-x C-<left>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'left)))
(global-set-key (kbd "C-x C-<right>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'right)))
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

;; System
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c r") 'recompile)
(global-set-key (kbd "C-c n") 'next-error)
(global-set-key (kbd "C-x C-w") 'write-file)
(global-set-key (kbd "C-x w") 'save-buffer-copy)
(global-set-key (kbd "M-o i") #'(lambda() (interactive) (message (buffer-file-name))))
(global-set-key (kbd "M-o M-i") #'(lambda() (interactive) (kill-new (message (buffer-file-name)))))

(provide 'init-standalone)
