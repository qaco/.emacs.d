(ert-deftest test/initial-major-mode ()
  "Initial major mode is text-mode"
  (should (eq initial-major-mode 'text-mode)))

(ert-deftest test/variables-configured ()
  "Variables are configured correctly"
  (should (= (bound-and-true-p fill-column) 80))
  (should (eq case-fold-search t)))

(ert-deftest test/modes-enabled ()
  "Global modes are enabled"
  (should (bound-and-true-p global-auto-revert-mode))
  (should (bound-and-true-p save-place-mode))
  (should (bound-and-true-p delete-selection-mode)))

;;; Advice: comment-region saves to kill-ring

(ert-deftest test/comment-region-saves-to-kill-ring ()
  "comment-region advice saves the region content to kill-ring before commenting"
  (with-temp-buffer
    (emacs-lisp-mode)
    (insert "hello")
    (let ((kill-ring nil))
      (comment-region (point-min) (point-max))
      (should (equal (car kill-ring) "hello")))))

;;; Advice: kill-ring-save dispatches on region

(ert-deftest test/kill-ring-save-no-region-copies-line ()
  "kill-ring-save without active region copies current line"
  (with-temp-buffer
    (insert "  hello\nworld")
    (goto-char (point-min))
    (let ((kill-ring nil)
          (mark-active nil))
      (kill-ring-save nil nil)
      (should (equal (car kill-ring) "hello")))))

(ert-deftest test/kill-ring-save-with-region-copies-region ()
  "kill-ring-save with active region copies only the region"
  (with-temp-buffer
    (insert "hello world")
    (goto-char (point-min))
    (set-mark 6)
    (let ((kill-ring nil)
          (mark-active t)
          (transient-mark-mode t))
      (kill-ring-save (point) (mark))
      (should (equal (car kill-ring) "hello")))))

;;; Advice: kill-region dispatches on interactive + region

(ert-deftest test/kill-region-interactive-no-region-kills-line ()
  "kill-region called interactively without region kills current line"
  (with-temp-buffer
    (insert "  hello\nworld")
    (goto-char (point-min))
    (set-mark 1)
    (let ((mark-active nil))
      (call-interactively 'kill-region)
      (should (equal (buffer-string) "world")))))

(ert-deftest test/kill-region-non-interactive-kills-region ()
  "kill-region called non-interactively kills the specified region"
  (with-temp-buffer
    (insert "hello world")
    (let ((mark-active nil))
      (kill-region 1 7)                 ; positions 1-6 = "hello "
      (should (equal (buffer-string) "world")))))

;;; Advice: move-beginning-of-line overridden by smarter-beginning-of-line

(ert-deftest test/move-bol-goes-to-indent ()
  "move-beginning-of-line goes to indentation on first call"
  (with-temp-buffer
    (insert "  hello")
    (end-of-line)
    (move-beginning-of-line nil)
    (should (= (current-column) 2))))

(ert-deftest test/move-bol-goes-to-column-zero ()
  "move-beginning-of-line goes to column 0 when already at indentation"
  (with-temp-buffer
    (insert "  hello")
    (back-to-indentation)
    (move-beginning-of-line nil)
    (should (= (current-column) 0))))

(provide 'test-init-standalone)

;;; test/test-init-standalone.el ends here
