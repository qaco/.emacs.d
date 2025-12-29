(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-display-buffer-function
        #'magit-display-buffer-same-window-except-diff-v1))

(defun magit-run-post-commit-hook (&rest _args)
  nil)

(defun my/git-gutter ()
  (unless (bound-and-true-p olivetti-mode)
    (git-gutter-mode 1)))

(use-package git-gutter
  :ensure t
  :hook ((prog-mode . my/git-gutter)
         (text-mode . my/git-gutter)
         (conf-mode . my/git-gutter))
  :config
  (setq git-gutter:refresh-timer 1)
  (setq git-gutter:update-interval 1)
  (setq git-gutter:delay 0)
  :bind
  ("C-x v h" . 'git-gutter:stage-hunk)
  ("C-x v n" . 'git-gutter:next-hunk)
  ("C-x v p" . 'git-gutter:previous-hunk)
  ("C-x v r" . 'git-gutter:revert-hunk)
  ("C-x v d" . 'git-gutter:popup-hunk)
  )

(defun my/git-gutter-set-window-margin (orig-fn width)
  (let* ((win (get-buffer-window))
         (cur (car (window-margins win)))
         (w (max (or cur 0) (or width 0))))
    (funcall orig-fn w)))

(advice-add 'git-gutter:set-window-margin :around
            #'my/git-gutter-set-window-margin)

(global-set-key (kbd "C-x v u") #'my/magit-stage-modified-no-confirm)
(global-set-key (kbd "C-x v c") #'magit-commit-create)
(global-set-key (kbd "C-x v C") #'magit-commit-amend)
(global-set-key (kbd "C-x v P") #'magit-push-current-to-pushremote)

(defun my/magit-stage-modified-no-confirm ()
  "Stage all modified and deleted files without asking for confirmation.
Runs `git add -u` directly, refreshes Magit, and shows a success message."
  (interactive)
  (require 'magit)
  (if (not (magit-toplevel))
      (user-error "Not inside a Git repository")
    (let ((default-directory (magit-toplevel)))
      ;; Stage all modified/deleted files (no prompt)
      (magit-git-success "add" "-u")
      ;; Refresh Magit status buffer(s)
      (dolist (buf (buffer-list))
        (with-current-buffer buf
          (when (derived-mode-p 'magit-mode)
            (ignore-errors (magit-refresh)))))
      ;; Show confirmation message
      (message "Staging successful !"))))

(provide 'init-git)
