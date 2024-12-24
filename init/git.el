(use-package magit
  :ensure t
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package git-timemachine
  :ensure t
  :bind ("C-x v t" . git-timemachine))

;; Displays the git blame on the current line
;; (use-package blamer
;;   :ensure t
;;   :config
;;   (global-blamer-mode 1))

(use-package git-gutter
  :ensure t
  :hook ((prog-mode . git-gutter-mode)
         (text-mode . git-gutter-mode))
  :config
  (setq git-gutter:refresh-timer 1)
  (setq git-gutter:update-interval 1)
  (setq git-gutter:delay 0)
  (set-face-background 'git-gutter:modified "purple")
  (set-face-foreground 'git-gutter:added "green")
  (set-face-foreground 'git-gutter:deleted "red")
  :bind
  ("C-x v h" . 'git-gutter:stage-hunk)
  ("C-x v n" . 'git-gutter:next-hunk)
  ("C-x v p" . 'git-gutter:previous-hunk)
  ("C-x v r" . 'git-gutter:revert-hunk)
  )

(global-set-key (kbd "C-x v a") 'my-git-add)
(global-set-key (kbd "C-x v A") 'my-git-add-all)
(global-set-key (kbd "C-x v u") 'my-git-add-update)
(global-set-key (kbd "C-x v c") 'my-git-commit)
(global-set-key (kbd "C-x v C") 'my-git-amend)
(global-set-key (kbd "C-x v p") 'my-git-push)
(global-set-key (kbd "C-x v H") 'my-git-stage-hunks)

(defun my-stage-hunks ()
  "Stage hunks one by one until there are no more hunks to stage.
   Return the cursor to its initial position afterwards."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (let ((initial-point (point)))
             (git-gutter:next-hunk 1)
             (not (= initial-point (point))))
      (git-gutter:stage-hunk)))
  (message "Staging complete."))

(defun my-git-add ()
  "Stage the current buffer's file in Git."
  (interactive)
  (when (and buffer-file-name
             (locate-dominating-file buffer-file-name ".git"))
    (shell-command (concat "git add " (shell-quote-argument buffer-file-name)))
    (message "Staged file: %s" buffer-file-name)))


(defun my-git-get-repo-root ()
  "Return the root directory of the current Git repository."
  (string-trim (shell-command-to-string "git rev-parse --show-toplevel")))

(defun my-git-get-files (command)
  "Return the list of files from the specified Git COMMAND."
  (split-string (shell-command-to-string command) "\n" t))

(defun my-git-add-files (files)
  "Ask for confirmation before staging each file in FILES."
  (let ((total (length files)))
    (dolist (file files)
      (let ((index (1+ (cl-position file files :test 'equal))))
        (when (yes-or-no-p (format "Stage file %s? (%d/%d) " file index total))
          (shell-command (concat "git add " (shell-quote-argument file)))
          (message "Staging file: %s" file))
        (message "")
        (sit-for 0.1))))
  (message "Staging complete."))

(defun my-git-run-command (command success-message failure-message)
  "Run a Git COMMAND and display a SUCCESS-MESSAGE if successful, or
   a FAILURE-MESSAGE if it fails."
  (with-temp-buffer
    (let ((exit-code (call-process-shell-command command nil t)))
      (if (eq exit-code 0)
          (message success-message)
        (let ((error-message (buffer-string)))
          (message "%s: %s" failure-message error-message))))))

(defun my-git-add-update ()
  "Run 'git add -u' from the root of the current Git repository. Ask
   for confirmation for each file before staging it."
  (interactive)
  (let ((default-directory (my-git-get-repo-root))
        (unstaged-files (my-git-get-files "git diff --name-only")))
    (my-git-add-files unstaged-files)))

(defun my-git-add-all ()
  "Run 'git add -A' from the root of the current Git repository. Ask for
   confirmation for each file before staging it."
  (interactive)
  (let* ((default-directory (my-git-get-repo-root))
         (unstaged-files (my-git-get-files "git diff --name-only"))
         (untracked-files (my-git-get-files "git ls-files --others --exclude-standard"))
         (all-files (append unstaged-files untracked-files)))
    (my-git-add-files(all-files))))

(defun my-git-commit ()
  "Run 'git commit' in the current directory. Prompt for a commit
   message in the minibuffer."
  (interactive)
  (let ((commit-message (read-string "Commit message: ")))
    (my-git-run-command (concat "git commit -m " (shell-quote-argument commit-message))
                        "Commit successful!" "Commit failed")))

(defun my-git-amend ()
  "Run 'git commit --amend --no-edit' in the current directory. If
   the commit fails, display the error message in the minibuffer."
  (interactive)
  (my-git-run-command "git commit --amend --no-edit"
                      "Amend successful!" "Amend failed"))

(defun my-git-push ()
  "Run 'git push origin' in the current directory. Prompt for the
   branch to push in the minibuffer."
  (interactive)
  (let* ((current-branch (string-trim (shell-command-to-string "git branch --show-current")))
         (branch (read-string (format "Branch to push (default %s): " current-branch) nil nil current-branch)))
    (my-git-run-command (concat "git push origin " (shell-quote-argument branch))
                        "Push successful!" "Push failed")))

(provide 'git)
