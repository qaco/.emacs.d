(use-package vterm
  :ensure t
  :init
  (setq vterm-always-compile-module t)
  )

(use-package multi-vterm
  :ensure t
  :bind
  ("C-x t" . multi-vterm))

(add-hook 'vterm-mode-hook
          (lambda ()
            (face-remap-add-relative 'bold '(:weight normal))
            (when (bound-and-true-p global-hl-line-mode)
              (setq-local global-hl-line-mode nil))
            (define-key vterm-mode-map (kbd "C-k") 'my/vterm-kill-line)
            (define-key vterm-mode-map (kbd "C-z") 'suspend-frame)
            (define-key vterm-mode-map (kbd "C-<left>") 'windmove-left)
            (define-key vterm-mode-map (kbd "C-<right>") 'windmove-right)
            (define-key vterm-mode-map (kbd "C-<up>") 'windmove-up)
            (define-key vterm-mode-map (kbd "C-<down>") 'windmove-down)
            (define-key vterm-mode-map (kbd "<deletechar>") (lambda () (interactive) (vterm-send-key "C-d")))
            (vterm-send-string "EDITOR=vi;VISUAL=vi")
            (vterm-send-return)
            (vterm-send-string "clear")
            (vterm-send-return)
            ))

(with-eval-after-load 'vterm
  (custom-set-faces
   '(vterm-color-black   ((t (:foreground "gray25"      :background "gray25"))))
   '(vterm-color-red     ((t (:foreground "red2"        :background "red2"))))
   '(vterm-color-green   ((t (:foreground "green3"      :background "green3"))))
   '(vterm-color-yellow  ((t (:foreground "goldenrod3"  :background "goldenrod3"))))
   '(vterm-color-blue    ((t (:foreground "RoyalBlue2"  :background "RoyalBlue2"))))
   '(vterm-color-magenta ((t (:foreground "purple2"     :background "purple2"))))
   '(vterm-color-cyan    ((t (:foreground "cyan3"       :background "cyan3"))))
   '(vterm-color-white   ((t (:foreground "gray97"      :background "gray97")))))

  (dolist (pair '((vterm-color-bright-black   . vterm-color-black)
                  (vterm-color-bright-red     . vterm-color-red)
                  (vterm-color-bright-green   . vterm-color-green)
                  (vterm-color-bright-yellow  . vterm-color-yellow)
                  (vterm-color-bright-blue    . vterm-color-blue)
                  (vterm-color-bright-magenta . vterm-color-magenta)
                  (vterm-color-bright-cyan    . vterm-color-cyan)
                  (vterm-color-bright-white   . vterm-color-white)))
    (set-face-attribute (car pair) nil :inherit (cdr pair))))

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

(provide 'init-console)
