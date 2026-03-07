(ert-deftest test/init-git-loads ()
  "init-git module loads"
  (should (featurep 'init-git)))

(ert-deftest test/git-gutter-skips-olivetti ()
  "my/git-gutter does not enable git-gutter-mode when olivetti-mode is active"
  (with-temp-buffer
    (let ((olivetti-mode t)
          (calls nil))
      (cl-letf (((symbol-function 'git-gutter-mode)
                 (lambda (&rest args) (push args calls))))
        (my/git-gutter)
        (should (null calls))))))

(ert-deftest test/git-gutter-enables-without-olivetti ()
  "my/git-gutter enables git-gutter-mode with arg 1 when olivetti-mode is off"
  (with-temp-buffer
    (let ((calls nil))
      (cl-letf (((symbol-function 'git-gutter-mode)
                 (lambda (&rest args) (push args calls))))
        (my/git-gutter)
        (should (equal (car calls) '(1)))))))

;;; test/test-init-git.el ends here
