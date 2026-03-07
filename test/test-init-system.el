(ert-deftest test/clipboard-enabled ()
  "clipboard settings are enabled"
  (should select-enable-clipboard)
  (should select-enable-primary))

(ert-deftest test/recentf-mode ()
  "recentf mode is enabled"
  (should (bound-and-true-p recentf-mode)))

(provide 'test-init-system)

;;; test/test-init-system.el ends here
