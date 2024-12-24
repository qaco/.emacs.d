;; Environment variables

(setq custom-file null-device)
(setq backup-directory-alist `(("." . "~/.saves")))

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

(menu-bar-mode -1) ; hide the menubar
(blink-cursor-mode 0) ; stop the cursor from blinking
(setq inhibit-startup-message t) ; disable startup message
(setq initial-scratch-message nil) ; disable initial scratch message

(show-paren-mode t) ; highlight matching parentheses
(global-hl-line-mode t) ; highlight the current line

;; Less confirms
(fset 'yes-or-no-p 'y-or-n-p) ; use y/n instead of yes/no
(setq confirm-nonexistent-file-or-buffer nil ; create file without confirm
      vc-follow-symlinks nil ; follows symlinks
      revert-without-query '(".*")) ; reverts buffer

(icomplete-mode 1)
(setq read-file-name-completion-ignore-case t)
(setq read-file-name-function 'read-file-name-default)

(fido-vertical-mode 1)
(setq ido-everywhere t
      ido-create-new-buffer 'always
      ido-auto-merge-work-directories-length -1)

;; Hooks

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'visual-line-mode)

;; Theme

(load-theme 'modus-vivendi t)


;; Functions

(defun swap-buffer-with-adjacent (direction)
  "Swap the current buffer with the buffer in the adjacent window in
   the specified DIRECTION, and move the cursor to the adjacent window."
  (let ((current-window (selected-window))
        (other-window (window-in-direction direction)))
    (when other-window
      (let ((current-buffer (window-buffer current-window))
            (other-buffer (window-buffer other-window)))
        (set-window-buffer current-window other-buffer)
        (set-window-buffer other-window current-buffer)
        (select-window other-window)))))

(defun split-window-below-and-center-cursor ()
  "Split the window horizontally and center the cursor both in the old
   window and in the new one."
  (interactive)
  (let ((current-window (selected-window)))
    (select-window (split-window-below))
    (recenter-top-bottom)
    (select-window current-window)
    (recenter-top-bottom)))

(defun smarter-beginning-of-line ()
  "Move point to the first non-whitespace character or beginning of
   line. Move point to the beginning of line if point was already at
   the indentation."
  (interactive)
  (let ((initial-point (point)))
    (back-to-indentation)
    (when (= initial-point (point))
      (move-beginning-of-line 1))))

(defun wise-kill-whitespaces ()
 (if (< (line-end-position) (point-max))
	  (delete-region (point) (+ 1 (line-end-position)))
	(delete-region (point) (line-end-position))))

(defun wise-copy-line ()
  (interactive)
  (wise-kill-or-copy-line nil))

(defun wise-kill-line ()
  (interactive)
  (wise-kill-or-copy-line 1))

(defun wise-kill-or-copy-line (should-kill)

  "Copy/kill the current line preserving column position. Doesn't save
   nor newline char nor indentation (doesn't save anything if blank line.)"
  
  (interactive)

  ;; Save the column position and go to indentation
  (let ((former-column (current-column)))
    (move-to-column (current-indentation))
    ;; Copy & delete (instead of kill) the text until the end of line
    (call-interactively 'set-mark-command)
    (call-interactively 'end-of-line)
    (copy-region-as-kill (mark) (point))
    (when should-kill
      (delete-region (mark) (point))
      ;; Remove all remaining whitespaces (including newline)
      (beginning-of-line)
      (wise-kill-whitespaces))
    ;; Restore the column position
    (move-to-column former-column)))

(defun save-buffer-copy (filename)
  "Save a copy of the current buffer to a specified FILENAME without changing the buffer."
  (interactive "FSave buffer copy to file: ")
  (write-region (point-min) (point-max) filename)
  (message "Buffer saved to %s" filename))

(defvar my-last-compile-command "make"
  "Last compile command used in the current Emacs session.")

(defun my-project-run-command (command)
  "Run the given compile COMMAND from the project root."
  (let* ((project (project-current t))
         (root (project-root project))
         (default-directory root))
    (compile command)))

(defun my-project-compile-command ()
  "Ask for compile command and run it from the project root.
   Use the last compile command as default."
  (interactive)
  (let ((command (read-string "Compile command: " my-last-compile-command)))
    (setq my-last-compile-command command)
    (my-project-run-command command)))

(defun my-project-recompile-command ()
  "Recompile using the last compile command."
  (interactive)
  (my-project-run-command my-last-compile-command))

;; Keys

;; display informations
(global-set-key (kbd "C-x \"") 'display-fill-column-indicator-mode)
(global-set-key (kbd "C-x l") 'count-lines-page)

;; windows
(global-set-key (kbd "C-x 2") 'split-window-below-and-center-cursor)
(global-set-key (kbd "M-=") 'enlarge-window)
(global-set-key (kbd "M--") 'shrink-window)
(global-set-key (kbd "C-x N") 'other-window)
(global-set-key (kbd "C-x P") #'(lambda() (interactive) (other-window -1)))
(global-set-key (kbd "<C-right>")   'windmove-right)
(global-set-key (kbd "<C-left>")   'windmove-left)
(global-set-key (kbd "<C-up>")   'windmove-up)
(global-set-key (kbd "<C-down>")   'windmove-down)

;; edit
(advice-add 'comment-region :before #'copy-region-as-kill)
(global-set-key (kbd "C-q")   'delete-region)
(global-set-key (kbd "C-j") #'(lambda() (interactive) (delete-region (point) (line-end-position))))
(global-set-key (kbd "M-_") 'undo-only)
(global-set-key (kbd "C-x :") 'dabbrev-expand)
(global-set-key (kbd "C-x q") 'join-line)
(global-set-key (kbd "C-w") #'(lambda() (interactive) (if mark-active
                                                          (kill-region (mark) (point))
                                                        (wise-kill-line))))
(global-set-key (kbd "M-w") #'(lambda() (interactive) (if mark-active
                                                          (copy-region-as-kill (mark) (point))
                                                        (wise-copy-line))))

;; navigation
(global-set-key (kbd "C-a") 'smarter-beginning-of-line)
(global-set-key (kbd "<mouse-4>") 'previous-line)
(global-set-key (kbd "<mouse-5>") 'next-line)
(global-set-key (kbd "M-<mouse-4>") #'(lambda() (interactive) (forward-line -5)))
(global-set-key (kbd "M-<mouse-5>") #'(lambda() (interactive) (forward-line 5)))
(global-set-key (kbd "<M-down>") #'(lambda() (interactive) (forward-line 5)))
(global-set-key (kbd "<M-up>") #'(lambda() (interactive) (forward-line -5)))

;; buffers
(global-set-key (kbd "C-x C-<up>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'above)))
(global-set-key (kbd "C-x C-<down>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'below)))
(global-set-key (kbd "C-x C-<left>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'left)))
(global-set-key (kbd "C-x C-<right>") #'(lambda() (interactive) (swap-buffer-with-adjacent 'right)))
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

;; System
(global-set-key (kbd "C-c c") 'my-project-compile-command)
(global-set-key (kbd "C-c r") 'my-project-recompile-command)
(global-set-key (kbd "C-x C-w") 'write-file)
(global-set-key (kbd "C-x w") 'save-buffer-copy)
(global-set-key (kbd "M-o i") #'(lambda() (interactive) (message (buffer-file-name))))
(global-set-key (kbd "M-o M-i") #'(lambda() (interactive) (kill-new (message (buffer-file-name)))))

(provide 'standalone)
