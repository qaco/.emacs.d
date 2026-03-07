;;; test/lib/helpers.el --- Test helpers for Emacs configuration tests -*-

;; This file is part of my Emacs configuration

;;; Commentary:

;; Helper functions for writing ERT tests

;;; Code:

(defun test/create-buffer-and-check-mode (mode &optional file-name)
  "Create a buffer with auto-mode set and check if MODE is active."
  (with-temp-buffer
    (when file-name
      (let ((buffer-file-name file-name))
        (set-auto-mode)
        (eq major-mode mode)))
    (set-auto-mode)
    (eq major-mode mode)))

(defun test/key-bound-p (key &optional map)
  "Check if KEY is bound in MAP (defaults to current-global-map)."
  (let ((map (or map (current-global-map))))
    (key-binding (read-kbd-macro key) t)))

(provide 'test/helpers)

;;; test/lib/helpers.el ends here
