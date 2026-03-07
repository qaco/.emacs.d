(ert-deftest test/python-mode-activation ()
  "python-mode is activated on .py files"
  (with-temp-buffer
    (let ((buffer-file-name "test.py"))
      (set-auto-mode))
    (should (eq major-mode 'python-mode))))

(ert-deftest test/c-mode-activation ()
  "c-mode is activated on .c files"
  (with-temp-buffer
    (let ((buffer-file-name "test.c"))
      (set-auto-mode))
    (should (eq major-mode 'c-mode))))

(ert-deftest test/c++-mode-activation ()
  "c++-mode is activated on .cpp files"
  (with-temp-buffer
    (let ((buffer-file-name "test.cpp"))
      (set-auto-mode))
    (should (eq major-mode 'c++-mode))))

(ert-deftest test/mlir-mode-activation ()
  "mlir-mode is activated on .mlir files"
  (with-temp-buffer
    (let ((buffer-file-name "test.mlir"))
      (set-auto-mode))
    (should (eq major-mode 'mlir-mode))))

(ert-deftest test/tablegen-mode-activation ()
  "tablegen-mode is activated on .td files"
  (with-temp-buffer
    (let ((buffer-file-name "test.td"))
      (set-auto-mode))
    (should (eq major-mode 'tablegen-mode))))

(provide 'test-modes)

;;; test/test-modes.el ends here
