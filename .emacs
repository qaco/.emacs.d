;; ===========================================================================
;; PACKAGES
;; ===========================================================================

(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)

(package-initialize)

(setq package-list '(base16-theme
		     buffer-move
		     ido-vertical-mode
                     smex
                     magit
                     recentf
                     sbt-mode))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq load-path
     (append load-path
	      '("~/.emacs.d/elisp")))

;; ===========================================================================
;; BACKUPS
;; ===========================================================================

(setq browse-url-browser-function (quote browse-url-generic)
      backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))

(setq vc-make-backup-files t                      ; on fait des backups
      version-control t                           ; vérification des versions
      kept-new-versions 10                        ; on garde 10 backups
      kept-old-versions 0                         ; rien de plus ancien
      delete-old-versions t                       ; suppr vieilles versions
      backup-by-copying t)                        ; bkp = cpy

;; ===========================================================================
;; AFFICHAGE
;; ===========================================================================

(require 'fill-column-indicator)

(load-theme 'base16-google-dark t)                ; charger theme

(menu-bar-mode -1)                                ; cacher barre de menu
(tool-bar-mode -1)                                ; cacher outils
(scroll-bar-mode -1)                              ; cacher scroll bar
(blink-cursor-mode 0)                             ; curseur fixe

(setq frame-title-format "%b"                     ; titre : nom du fichier
      icon-title-format "%b"                      ; titre : nom du fichier
      confirm-nonexistent-file-or-buffer nil      ; créa file sans confirmer
      inhibit-startup-message t)                  ; cacher startup-message

(fset 'yes-or-no-p 'y-or-n-p)                     ; yes-or-no remplace y-or-n

(set-face-attribute 'default nil :height 100)     ; taille de police
(setq-default word-wrap t)                        ; coupe après le mot

(display-time-mode 1)                             ; afficher horloge
(column-number-mode 1)                            ; afficher numéro de colonne
(line-number-mode 1)                              ; afficher numéro de ligne
(global-hl-line-mode t)                           ; highlight ligne courante
(show-paren-mode t)                               ; matching des parentheses

(setq-default fill-column 80                      ; largeur de page : 80 char
              indicate-empty-lines t)             ; marque lignes vides

(setq display-time-24hr-format t)                 ; horloge format 24h

(global-set-key (kbd "C-x l") 'linum-mode)
(global-set-key (kbd "M-l") 'count-lines-page)

;; ===========================================================================
;; NAVIGATION
;; ===========================================================================

; scroll sans jumps
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

(setq case-fold-search t)                         ; search ignore la casse

(defun smarter-move-beginning-of-line (arg)
  ;; Sebastian Wiesner
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'smarter-move-beginning-of-line)
;; (global-set-key (kbd "C-c SPC") 'ace-jump-word-mode)
(global-set-key (kbd "C-l") 'goto-line)

;; ===========================================================================
;; FENETRES
;; ===========================================================================

(winner-mode 1)                                   ; undo/redo fenetres

(add-to-list 'default-frame-alist '(height . 30)) ; hauteur par défaut
(add-to-list 'default-frame-alist '(width . 81))  ; largeur par défaut
(windmove-default-keybindings)                    ; S-<arrow> navig fenetres
(require 'buffer-move)                            ; M-S<arrow> swap buffers

(defun split-horizontally-and-balance ()
  (interactive)
  (split-window-horizontally)
  (balance-windows))

(defun delete-and-rebalance ()
  (interactive)
  (split-window-horizontally)
  (balance-windows))

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "<f5>") 'split-horizontally-and-balance)
(global-set-key (kbd "C-<f5>") 'fci-mode)
(global-set-key (kbd "<f6>") 'split-window-vertically)
(global-set-key (kbd "<f7>") 'delete-other-windows)
(global-set-key (kbd "<f8>") 'delete-window)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)
(global-set-key (kbd "C-x C-k")  'kill-current-buffer)

;; ===========================================================================
;; EXPLORATEUR
;; ===========================================================================

(ido-mode 1)                                      ; active ido
(ido-vertical-mode 1)                             ; disposition verticale

(setq ido-enable-flex-matching t                  ; souplesse du matching
      ido-everywhere t                            ; tous les buffers/fichiers
      ido-create-new-buffer 'always               ; nveau quand pas trouvé
      ido-auto-merge-work-directories-length -1)  ; pas ds les autres dossiers

(require 'recentf)
(setq recentf-max-saved-items 50)                 ; se souvient des 50 derniers
(recentf-mode 1)                                  ; fichiers

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(defun open-home-doc ()
  (interactive)
  (find-file-other-window "~/.emacs.d/README.org"))

(defun dired-mode-setup ()
  (dired-hide-details-mode 1)
  (defun dired-maybe-insert-subdir (&optional dirname switches)
    (interactive)
    (call-interactively 'dired-subtree-insert))
  (defun find-file-other-window (file &optional wildcards)
    (interactive)
    (set-window-buffer (other-window 1)
                       (find-file-noselect file nil nil wildcards)))
    
  (defun dired-mouse-find-file-other-window (event)
    "In Dired, visit the file or directory name you click on in another window."
    (interactive "e")
    (dired-mouse-find-file event
                           'find-file-other-window
                           'dired-maybe-insert-subdir))
  (define-key dired-mode-map ";" 'dired-subtree-remove))

(add-hook 'dired-mode-hook 'dired-mode-setup)

(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-h h") 'open-home-doc)
(global-set-key (kbd "<f4>") 'revert-buffer)

;; ===========================================================================
;; ÉDITION
;; ===========================================================================
(delete-selection-mode t)                         ; overwrite region
(setq-default indent-tabs-mode nil)               ; pas de tabs

(defun kill-region-or-line ()
  (interactive)
  (if mark-active
      (call-interactively 'kill-region)
    (call-interactively 'kill-whole-line)))

(defun copy-region-or-line ()
  (interactive)
  (if mark-active
      (call-interactively 'copy-region-as-kill)
    (save-excursion
      (progn
        (call-interactively 'smarter-move-beginning-of-line)
        (kill-ring-save (point)
                        (line-end-position))))))

(defun copy-and-comment-region ()
  (interactive)
  (if mark-active
      (progn
        (call-interactively 'copy-region-as-kill)
        (call-interactively 'comment-region))
    (progn
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position 2))
      (comment-region (line-beginning-position)
                      (line-end-position)))))

(global-set-key (kbd "C-w") 'kill-region-or-line)
(global-set-key (kbd "M-w") 'copy-region-or-line)
(global-set-key (kbd "M-_") 'undo-only)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-;") 'copy-and-comment-region)
(global-set-key (kbd "C-:") 'dabbrev-expand)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; ===========================================================================
;; COMPILATION
;; ===========================================================================

(setq compile-command "")
(defun new-compile-cmd (nveau)
  "Change the compile command without compiling."
  (interactive "sNew compile command: ")
  (setq compile-command nveau))

(defun clean()
  "Launch make clean from the current directory."
  (interactive)
  (shell-command "make clean"))

(global-set-key (kbd "<f1>") 'compile)
(global-set-key (kbd "C-<f1>") 'new-compile-cmd)
(global-set-key (kbd "<f2>") 'recompile)
(global-set-key (kbd "C-<f2>") 'global-flycheck-mode)
(global-set-key (kbd "<f3>") 'next-error)
(global-set-key (kbd "C-<f3>") 'flycheck-next-error)

;; ===========================================================================
;; OCAML
;; ===========================================================================

(let ((opam-share (ignore-errors
                    (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
  (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
  (autoload 'merlin-mode "merlin" nil t nil)
  (add-hook 'tuareg-mode-hook 'merlin-mode t)
  (add-hook 'caml-mode-hook 'merlin-mode t)))

(setq tuareg-indent-align-with-first-arg t)

(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")

;; ===========================================================================
;; ANSI-TERM
;; ===========================================================================

;; ansi-term lance automatiquement bash
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

;; tuer le buffer quand on fait exit
(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

(defun my-term-hook ()
  (goto-address-mode) ; URL cliquables
  (define-key term-raw-map (kbd "C-y") 'term-paste))
(add-hook 'term-mode-hook 'my-term-hook)

(global-set-key (kbd "C-x C-x") 'ansi-term)

;; ===========================================================================
;; LUSTRE
;; ===========================================================================

(setq auto-mode-alist (cons '("\\.lus$" . lustre-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ept" . heptagon-mode) auto-mode-alist))
(autoload 'lustre-mode "lustre" "Edition de code lustre" t)
(load "~/.emacs.d/elisp/heptagon.el")
(require 'heptagon-mode)

;; ===========================================================================
;; WHY3
;; ===========================================================================

(require 'why3)
