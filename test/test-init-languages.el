(ert-deftest test/eglot-hooks ()
  "eglot hooks are configured"
  (should (member 'eglot-ensure mlir-mode-hook))
  (should (member 'eglot-ensure python-mode-hook))
  (should (member 'eglot-ensure c-mode-hook))
  (should (member 'eglot-ensure c++-mode-hook)))

(provide 'test-init-languages)

;;; test/test-init-languages.el ends here
