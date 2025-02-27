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
(setq org-agenda-span 'month)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-o") nil))

(setq org-agenda-window-setup 'current-window)
(setq org-agenda-files (append (directory-files-recursively "~/org/agenda/" "\\.org$")
                               ;; (directory-files-recursively "~/org/journal/" "\\.org$")
                               (directory-files-recursively "~/org/notes/" "\\.org$")))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-todo-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)

;; (use-package org-modern
;;   :ensure t
;;   :config (setq org-modern-table nil)
;;   :hook (org-mode . org-modern-mode))

;; (use-package org-journal
;;   :ensure t
;;   :config
;;   (setq org-journal-dir "~/org/journal/"
;;         org-journal-date-format "%A, %d %B %Y"
;;         org-journal-enable-agenda-integration t
;;         ;; org-journal-carryover-items nil
;;         org-journal-find-file 'find-file
;;         org-journal-file-format "%Y-%m-%d.org"
;;         )
;;   )

;; (global-set-key (kbd "C-c C-o j") 'my-org-journal-new-entry)

;; (defun my-org-journal-new-entry()
;;   (interactive)
;;   ;; Simulate the prefix C-u
;;   (let ((current-prefix-arg '(1)))
;;     (call-interactively 'org-journal-new-entry)))

(provide 'org-conf)
