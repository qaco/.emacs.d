;;; test/test-init-console.el --- Tests for init-console -*-

;; This file is part of my Emacs configuration

;;; Code:

(ert-deftest test/vterm-kill-line-adds-to-kill-ring ()
  "my/vterm-kill-line saves content from point to end of line"
  (with-temp-buffer
    (insert "hello world")
    (goto-char (point-min))
    (let ((kill-ring nil))
      (cl-letf (((symbol-function 'vterm-send-key) #'ignore))
        (my/vterm-kill-line)
        (should (equal (car kill-ring) "hello world"))))))

(ert-deftest test/vterm-kill-line-from-middle ()
  "my/vterm-kill-line saves only from point to end of line"
  (with-temp-buffer
    (insert "hello world")
    (goto-char 7)                       ; 'w' of "world"
    (let ((kill-ring nil))
      (cl-letf (((symbol-function 'vterm-send-key) #'ignore))
        (my/vterm-kill-line)
        (should (equal (car kill-ring) "world"))))))

(ert-deftest test/vterm-kill-line-empty-line ()
  "my/vterm-kill-line does not add to kill-ring on empty line"
  (with-temp-buffer
    (let ((kill-ring nil))
      (cl-letf (((symbol-function 'vterm-send-key) #'ignore))
        (my/vterm-kill-line)
        (should (null kill-ring))))))

(provide 'test-init-console)

;;; test/test-init-console.el ends here
