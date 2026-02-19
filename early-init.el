(setq load-path
      (append load-path
              (list (expand-file-name "lisp" user-emacs-directory))))

(setq backup-directory-alist
      `(("." . ,(expand-file-name ".saves/" user-emacs-directory))))

(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name ".autosaves/" user-emacs-directory) t)))

(setq auto-save-list-file-prefix "~/.emacs.d/.auto-save-list/.saves-")

(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(setq project-list-file (expand-file-name ".projects" user-emacs-directory))

(setq eshell-directory-name (expand-file-name ".eshell" user-emacs-directory))

(setq custom-file null-device)

;; Disable package.el's automatic initialization before init.el
(setq package-enable-at-startup nil)

;; Speed up startup by delaying garbage collection
(setq gc-cons-threshold most-positive-fixnum)

;; Increase subprocess I/O performance (useful for LSP, etc.)
(setq read-process-output-max (* 1024 1024))  ;; 1MB

;; Disable unneeded UI elements early for a cleaner startup
(menu-bar-mode -1)

;; Disable startup messages and screens
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name)

;; Setup the transient state
(let ((tdir (expand-file-name ".transient/" user-emacs-directory)))
  (make-directory tdir t)
  (setq transient-history-file (expand-file-name "history.el" tdir)
        transient-levels-file  (expand-file-name "levels.el"  tdir)
        transient-values-file  (expand-file-name "values.el"  tdir)))

;; Setup the compilation cache
(let ((eln-dir (expand-file-name ".eln-cache/" user-emacs-directory)))
  ;; Create directory if it doesn't exist
  (unless (file-directory-p eln-dir)
    (make-directory eln-dir t))
  ;; Use the new variable on Emacs 29+, fallback for older versions
  (if (boundp 'native-comp-cache-directory)
      (setq native-comp-cache-directory eln-dir)
    (setq native-comp-eln-load-path (list eln-dir)))
  ;; Remove old cache folder if it exists (cleanup)
  (let ((old-cache (expand-file-name "eln-cache/" user-emacs-directory)))
    (when (and (file-directory-p old-cache)
               (not (string-equal old-cache eln-dir)))
      (delete-directory old-cache t))))

(setq my/early-init-loaded t)

(provide 'early-init)
