(use-package vterm
  :ensure t)

;; (use-package vterm
;;   :ensure t
;;   :bind
;;   ("C-x t" . vterm))

(use-package multi-vterm
  :ensure t
  :bind
  ("C-x t" . multi-vterm))

(add-hook 'vterm-mode-hook
          (lambda ()
            (define-key vterm-mode-map (kbd "C-<left>") 'windmove-left)
            (define-key vterm-mode-map (kbd "C-<right>") 'windmove-right)
            (define-key vterm-mode-map (kbd "C-<up>") 'windmove-up)
            (define-key vterm-mode-map (kbd "<deletechar>") (lambda () (interactive) (vterm-send-key "C-d")))
            (define-key vterm-mode-map (kbd "C-<down>") 'windmove-down)
            (vterm-send-string "EDITOR=vi;VISUAL=vi")
            (vterm-send-return)
            (vterm-send-string "clear")
            (vterm-send-return)
            ))

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

(define-key project-prefix-map (kbd "t") 'project-vterm)

(provide 'console)
