(use-package org
  :ensure t
  :bind ("C-c C-o t" . org-todo-list)
  :bind ("C-c C-o a" . org-agenda-list)
  :bind ("C-c C-o A" . org-agenda)
  )

(setq org-agenda-window-setup 'current-window)
(setq org-agenda-files (append (directory-files-recursively "~/org/agenda/" "\\.org$")
                               (directory-files-recursively "~/org/journal/" "\\.org$")))

(use-package org-journal
  :ensure t
  :config
  (setq org-journal-dir "~/org/journal/"
        org-journal-date-format "%A, %d %B %Y"
        org-journal-enable-agenda-integration t
        ;; org-journal-carryover-items nil
        org-journal-find-file 'find-file
        org-journal-file-format "%Y-%m-%d.org"
        )
  )

(global-set-key (kbd "C-c C-o j") 'my-org-journal-new-entry)

(defun my-org-journal-new-entry()
  (interactive)
  ;; Simulate the prefix C-u
  (let ((current-prefix-arg '(1)))
    (call-interactively 'org-journal-new-entry)))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-todo-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)

(provide 'org-conf)
