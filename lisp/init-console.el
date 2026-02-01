(use-package vterm
  :ensure t
  :init
  (setq vterm-always-compile-module t)
  :hook
  (vterm-mode . my/vterm-setup)
  :bind
  (:map vterm-mode-map
        ("C-k"        . my/vterm-kill-line)
        ("C-z"        . suspend-frame)
        ("C-<left>"   . windmove-left)
        ("C-<right>"  . windmove-right)
        ("C-<up>"     . windmove-up)
        ("C-<down>"   . windmove-down)
        ("<deletechar>" . my/vterm-forward-delete))
  :config
  (define-key vterm-mode-map (kbd "ESC") 
              (lambda () (interactive) (vterm-send-escape)))
  (custom-theme-set-faces
   'user
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
    (set-face-attribute (car pair) nil :inherit (cdr pair)))
  )

(use-package multi-vterm
  :ensure t
  :bind
  ("C-x t" . multi-vterm))

(defun my/vterm-setup ()
  (face-remap-add-relative 'bold '(:weight normal))
  (when (bound-and-true-p global-hl-line-mode)
    (setq-local global-hl-line-mode nil))
  (vterm-send-string "EDITOR=vi;VISUAL=vi;clear")
  (vterm-send-return)
  )
  
(defun my/vterm-forward-delete ()
  (interactive)
  (vterm-send-key "d" nil nil t))

(defun my/vterm-kill-line ()
  (interactive)
  (let ((beg (point))
        (end (line-end-position)))
    (when (< beg end)
      (kill-new (buffer-substring beg end))))
  (vterm-send-key "k" nil nil t))

(defun project-vterm ()
  (interactive)
  (let ((default-directory (project-root (project-current t))))
    (multi-vterm)))

(define-key project-prefix-map (kbd "t") 'project-vterm)

(provide 'init-console)
