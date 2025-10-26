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

(defun my/agenda-apply-category-faces ()
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (let* ((cat  (or (get-text-property (point) 'org-category) ""))
             (face (cdr (assoc cat '(("TRAVEL" . (:foreground "DodgerBlue" :weight bold))
                                     ("RDV_REG" . (:foreground "gray60"))
                                     ("TODO_WARN" . (:foreground "red" :weight bold))
                                     )))))
        (when face
          (add-text-properties (line-beginning-position) (line-end-position)
                               `(face ,face))))
      (forward-line 1))))
(add-hook 'org-agenda-finalize-hook #'my/agenda-apply-category-faces)

(provide 'init-org)
