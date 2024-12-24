(use-package vterm
  :ensure t)

(use-package multi-vterm
  :ensure t
  :bind
  ("C-c s" . multi-vterm))

(add-hook 'vterm-mode-hook
          (lambda ()
            (define-key vterm-mode-map (kbd "C-<left>") 'windmove-left)
            (define-key vterm-mode-map (kbd "C-<right>") 'windmove-right)
            (define-key vterm-mode-map (kbd "C-<up>") 'windmove-up)
            (define-key vterm-mode-map (kbd "C-<down>") 'windmove-down)))

(add-hook 'vterm-mode-hook
          (lambda ()
            (define-key vterm-mode-map (kbd "C-k") 'my/vterm-kill-line)))

(defun my/vterm-kill-line ()
  (interactive)
  (let ((beg (point))
        (end (point-at-eol)))
    (kill-new (buffer-substring beg end))
    (vterm-send-string (kbd "C-k"))))

(defun project-vterm ()
  "Open a `vterm` buffer in the project root."
  (interactive)
  (let ((default-directory (project-root (project-current t))))
    (multi-vterm)))

(define-key project-prefix-map (kbd "s") 'project-vterm)

(provide 'console)
