;;; test/test-init.el --- Test suite for Emacs configuration -*-

;; This file is part of my Emacs configuration

;;; Code:

(let ((default-directory (expand-file-name "." user-emacs-directory)))
  (load "test/lib/helpers" nil t)
  (load "test/test-standalone-functions" nil t)
  (load "test/test-init-standalone" nil t)
  (load "test/test-modes" nil t)
  (load "test/test-init-system" nil t)
  (load "test/test-init-git" nil t)
  (load "test/test-init-languages" nil t)
  (load "test/test-init-org" nil t)
  (load "test/test-init-text" nil t)
  (load "test/test-init-console" nil t))

(provide 'test-init)

;;; test/test-init.el ends here
