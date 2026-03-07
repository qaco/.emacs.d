;;; test/test-init-org.el --- Tests for init-org -*-

;; This file is part of my Emacs configuration

;;; Code:

(ert-deftest test/org-variables ()
  "org variables are configured"
  (should (= org-agenda-span 60))
  (should (eq org-agenda-window-setup 'current-window)))

(ert-deftest test/org-summary-todo-all-done ()
  "org-summary-todo calls org-todo with DONE when n-not-done is 0"
  (let (called-with)
    (cl-letf (((symbol-function 'org-todo)
               (lambda (state) (setq called-with state))))
      (org-summary-todo 3 0)
      (should (equal called-with "DONE")))))

(ert-deftest test/org-summary-todo-some-pending ()
  "org-summary-todo calls org-todo with TODO when some subtasks are pending"
  (let (called-with)
    (cl-letf (((symbol-function 'org-todo)
               (lambda (state) (setq called-with state))))
      (org-summary-todo 2 1)
      (should (equal called-with "TODO")))))

(ert-deftest test/org-summary-todo-none-done ()
  "org-summary-todo calls org-todo with TODO when no subtasks are done"
  (let (called-with)
    (cl-letf (((symbol-function 'org-todo)
               (lambda (state) (setq called-with state))))
      (org-summary-todo 0 3)
      (should (equal called-with "TODO")))))

(provide 'test-init-org)

;;; test/test-init-org.el ends here
