(use-package org
  :ensure t
  :config
  (setq org-highlight-latex-and-related '(native latex script entities))
  (setq org-hide-emphasis-markers t)
  :bind ("C-x C-a t" . org-todo-list)
  :bind ("C-x C-a a" . org-agenda-list)
  :bind ("C-x C-a A" . org-agenda)
  )

(setq org-agenda-start-with-follow-mode nil)
(setq org-agenda-span 60)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-o") nil))

(setq org-agenda-window-setup 'current-window)
(when (getenv "ORG_HOME")
  (setq org-agenda-files
        (append
         (directory-files-recursively
          (expand-file-name "agenda" (getenv "ORG_HOME")) "\\.org$"))))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-todo-log-states)
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)

(provide 'init-org)
