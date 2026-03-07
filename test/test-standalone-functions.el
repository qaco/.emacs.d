;;; test/test-standalone-functions.el --- Tests for standalone-functions -*-

;; This file is part of my Emacs configuration

;;; Code:

;;; smarter-beginning-of-line

(ert-deftest test/smarter-bol-from-middle ()
  "From middle of indented line, moves to indentation"
  (with-temp-buffer
    (insert "  hello")
    (end-of-line)
    (smarter-beginning-of-line)
    (should (= (current-column) 2))))

(ert-deftest test/smarter-bol-from-indentation ()
  "From indentation, moves to column 0"
  (with-temp-buffer
    (insert "  hello")
    (back-to-indentation)
    (smarter-beginning-of-line)
    (should (= (current-column) 0))))

(ert-deftest test/smarter-bol-no-indent ()
  "On non-indented line, always moves to column 0"
  (with-temp-buffer
    (insert "hello")
    (end-of-line)
    (smarter-beginning-of-line)
    (should (= (current-column) 0))))

;;; wise-copy-line

(ert-deftest test/wise-copy-line-content ()
  "wise-copy-line copies line without indentation into kill-ring"
  (with-temp-buffer
    (insert "  hello\nworld")
    (goto-char (point-min))
    (let ((kill-ring nil))
      (wise-copy-line)
      (should (equal (car kill-ring) "hello")))))

(ert-deftest test/wise-copy-line-no-modify ()
  "wise-copy-line does not modify the buffer"
  (with-temp-buffer
    (insert "  hello\nworld")
    (goto-char (point-min))
    (let ((before (buffer-string)))
      (wise-copy-line)
      (should (equal (buffer-string) before)))))

;;; wise-kill-line

(ert-deftest test/wise-kill-line-removes-line ()
  "wise-kill-line removes the whole line from buffer"
  (with-temp-buffer
    (insert "  hello\nworld")
    (goto-char (point-min))
    (wise-kill-line)
    (should (equal (buffer-string) "world"))))

(ert-deftest test/wise-kill-line-to-kill-ring ()
  "wise-kill-line puts content without indentation into kill-ring"
  (with-temp-buffer
    (insert "  hello\nworld")
    (goto-char (point-min))
    (let ((kill-ring nil))
      (wise-kill-line)
      (should (equal (car kill-ring) "hello")))))

(ert-deftest test/wise-kill-line-blank-line ()
  "wise-kill-line on blank line removes it and its newline"
  (with-temp-buffer
    (insert "\nworld")
    (goto-char (point-min))
    (wise-kill-line)
    (should (equal (buffer-string) "world"))))

;;; move-line-up / move-line-down

(ert-deftest test/move-line-up-swaps ()
  "move-line-up swaps current line with the previous one"
  (with-temp-buffer
    (insert "line1\nline2\nline3\n")
    (goto-char (point-min))
    (forward-line 1)
    (move-line-up)
    (should (string-prefix-p "line2\nline1\n" (buffer-string)))))

(ert-deftest test/move-line-down-swaps ()
  "move-line-down swaps current line with the next one"
  (with-temp-buffer
    (insert "line1\nline2\nline3\n")
    (goto-char (point-min))
    (move-line-down)
    (should (string-prefix-p "line2\nline1\n" (buffer-string)))))

(provide 'test-standalone-functions)

;;; test/test-standalone-functions.el ends here
