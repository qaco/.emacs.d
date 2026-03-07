;;; test/test-init-text.el --- Tests for init-text -*-

;; This file is part of my Emacs configuration

;;; Code:

(ert-deftest test/yaml-mode-available ()
  "yaml-mode is available"
  (require 'yaml-mode)
  (should (featurep 'yaml-mode)))

(ert-deftest test/markdown-mode-available ()
  "markdown-mode is available"
  (should (featurep 'markdown-mode)))

(ert-deftest test/olivetti-available ()
  "olivetti is available"
  (require 'olivetti)
  (should (featurep 'olivetti)))

(ert-deftest test/markdown-mode-activation ()
  "markdown-mode is activated on .md files"
  (with-temp-buffer
    (let ((buffer-file-name "test.md"))
      (set-auto-mode))
    (should (eq major-mode 'markdown-mode))))

(ert-deftest test/markdown-enables-olivetti ()
  "olivetti-mode is enabled when opening a .md file"
  (with-temp-buffer
    (let ((buffer-file-name "test.md"))
      (set-auto-mode))
    (should (bound-and-true-p olivetti-mode))))

(ert-deftest test/yaml-does-not-enable-olivetti ()
  "olivetti-mode is NOT enabled when opening a .yaml file"
  (with-temp-buffer
    (let ((buffer-file-name "test.yaml"))
      (set-auto-mode))
    (should-not (bound-and-true-p olivetti-mode))))

(provide 'test-init-text)

;;; test/test-init-text.el ends here
