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
                     recentf))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq load-path (append load-path '("~/.emacs.d/elisp")))
(require 'fill-column-indicator)
(require 'buffer-move)
(require 'auto-close-shell)
(require 'recentf)
(require 'opam-user-setup)
(require 'menhir-mode)

;; ===========================================================================
;; BACKUPS
;; ===========================================================================

(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/")))
      vc-make-backup-files t                      ; on fait des backups
      version-control t                           ; vérification des versions
      kept-new-versions 10                        ; on garde 10 backups
      kept-old-versions 0                         ; rien de plus ancien
      delete-old-versions t                       ; suppr vieilles versions
      backup-by-copying t)                        ; bkp = cpy

;; ===========================================================================
;; FORMAT
;; ===========================================================================

(setq-default fill-column 80                      ; largeur de page : 80 char
              word-wrap t                         ; coupe après le mot
              indent-tabs-mode nil)               ; pas de tabs

(global-set-key (kbd "C-<f5>") 'fci-mode)

;; ===========================================================================
;; AFFICHAGE
;; ===========================================================================

(load-theme 'base16-google-dark t)                ; charger theme

(add-to-list 'default-frame-alist '(height . 30)) ; hauteur par défaut
(add-to-list 'default-frame-alist '(width . 81))  ; largeur par défaut
(setq frame-title-format "%b"                     ; titre : nom du fichier
      icon-title-format "%b"                      ; titre : nom du fichier
      inhibit-startup-message t                   ; cacher startup-message
      display-time-24hr-format t)                 ; horloge format 24h

(menu-bar-mode -1)                                ; cacher barre de menu
(tool-bar-mode -1)                                ; cacher outils

(set-fontset-font "fontset-default" nil           ; unicode 
                  (font-spec :size 20
                             :name "Symbola"))
(scroll-bar-mode -1)                              ; cacher scroll bar
(blink-cursor-mode 0)                             ; curseur fixe
(fset 'yes-or-no-p 'y-or-n-p)                     ; yes-or-no remplace y-or-n
(set-face-attribute 'default nil :height 100)     ; taille de police
(setq-default indicate-empty-lines t)             ; marque lignes vides
(show-paren-mode t)                               ; matching des parentheses

;; Mode line
(column-number-mode 1)                            ; afficher numéro de colonne
(line-number-mode 1)                              ; afficher numéro de ligne
(global-hl-line-mode t)                           ; highlight ligne courante
(size-indication-mode 1)

(setq-default mode-line-buffer-identification
  (propertized-buffer-identification "%b"))

(defun shorten-directory (dir)
  (file-name-nondirectory
   (directory-file-name dir)))

(defvar mode-line-directory
  '(:propertize
    (:eval (shorten-directory default-directory)))
  "Formats the current directory.")
(put 'mode-line-directory 'risky-local-variable t)

(setq-default mode-line-format
       '(
         "%e"
         mode-line-front-space
         mode-line-directory                      ; dossier courant
         " "
         "%*"                                     ; modifié/read-only
         " "
         mode-line-buffer-identification          ; le nom du buffer
         "    "
         "%p of %I (%l,%c)"                       ; position
         "    "
         "%m"                                     ; major mode
         minor-mode-alist                         ; minor modes
        ))

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
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'smarter-move-beginning-of-line)

;; ===========================================================================
;; FENETRES
;; ===========================================================================

(winner-mode 1)                                   ; undo/redo fenetres

(advice-add 'split-window-horizontally :after #'balance-windows)

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(windmove-default-keybindings)                    ; S-<arrow> navig fenetres
(global-set-key (kbd "<f5>") 'split-window-horizontally)
(global-set-key (kbd "<f6>") 'split-window-vertically)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)
(global-set-key (kbd "C-x k")  'kill-current-buffer)

;; ===========================================================================
;; EXPLORATEUR
;; ===========================================================================

(setq browse-url-browser-function                 ; firefox browser par défaut
      'browse-url-firefox)

(setq confirm-nonexistent-file-or-buffer nil      ; créa file sans confirmer
      vc-follow-symlinks nil                      ; symlink sans confirmer
      revert-without-query '(".*"))               ; revert sans confirmer

(ido-mode 1)                                      ; active ido
(ido-vertical-mode 1)                             ; disposition verticale
(setq ido-everywhere t                            ; tous les buffers/fichiers
      ido-create-new-buffer 'always               ; nveau quand pas trouvé
      ido-auto-merge-work-directories-length -1)  ; pas ds les autres dossiers

(setq recentf-max-saved-items 50)                 ; 50 derniers fichiers
(recentf-mode 1)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "<f4>") 'revert-buffer)

;; ===========================================================================
;; ÉDITION
;; ===========================================================================

(delete-selection-mode t)                         ; overwrite region

(defun newline-above ()
  (interactive)
  (end-of-line 0)
  (newline-and-indent))

(defun smarter-kill-line ()
  (interactive)
  (if (looking-at "[[:space:]]*$")
      (delete-region (point) (+ 1 (line-end-position)))
    (kill-line)))

(defun current-line-empty-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*$")))

(defun smarter-kill-whole-line ()
  (interactive)
  (if (current-line-empty-p)
      (progn
        (beginning-of-line)
        (smarter-kill-line))
    (delete-indentation)
    (kill-line)
    (next-line)
    (call-interactively 'smarter-move-beginning-of-line)))

(advice-add 'kill-whole-line :override #'smarter-kill-whole-line)

(defun kill-region-or-line ()
  (interactive)
  (if mark-active
      (kill-region (mark) (point))
    (kill-whole-line)))

(defun copy-region-or-line ()
  (interactive)
  (if mark-active
      (copy-region-as-kill (mark) (point))
    (save-excursion
      (progn
        (call-interactively 'smarter-move-beginning-of-line)
        (kill-ring-save (point) (line-end-position))))))

(advice-add 'comment-region :before #'copy-region-as-kill)

(global-set-key (kbd "C-<return>") 'newline-above)
(global-set-key (kbd "C-k") 'smarter-kill-line)
(global-set-key (kbd "C-x <down>") 'reverse-region)
(global-set-key (kbd "C-w") 'kill-region-or-line)
(global-set-key (kbd "M-w") 'copy-region-or-line)
(global-set-key (kbd "M-_") 'undo-only)
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

(global-set-key (kbd "<f1>") 'compile)
(global-set-key (kbd "C-<f1>") 'new-compile-cmd)
(global-set-key (kbd "<f2>") 'recompile)
(global-set-key (kbd "<f3>") 'next-error)

;; ===========================================================================
;; OCAML
;; ===========================================================================

(setq tuareg-indent-align-with-first-arg t
      tuareg-match-patterns-aligned 1
      tuareg-prettify-symbols-basic-alist
      `(("'a" . ?α)
        ("'b" . ?β)
        ("'c" . ?γ)
        ("'d" . ?δ)
        ("'e" . ?ε)
        ("'f" . ?φ)
        ("'i" . ?ι)
        ("'k" . ?κ)
        ("'m" . ?μ)
        ("'n" . ?ν)
        ("'o" . ?ω)
        ("'p" . ?π)
        ("'r" . ?ρ)
        ("'s" . ?σ)
        ("'t" . ?τ)
        ("'x" . ?ξ)))

(add-hook 'tuareg-mode-hook
 (lambda()
   (when (functionp 'prettify-symbols-mode)
     (prettify-symbols-mode))
   (setq mode-name "🐫")
   ))

;; ===========================================================================
;; UNIX
;; ===========================================================================

;; coloration de man
(require 'man)
(set-face-attribute 'Man-overstrike nil
                    :inherit font-lock-function-name-face
                    :bold t)
(set-face-attribute 'Man-underline nil
                    :inherit font-lock-variable-name-face
                    :bold t)

;; Préfixe C-u pour en créer un nouveau
(global-set-key (kbd "C-x C-x") 'auto-close-shell)

;; ===========================================================================
;; PRINT
;; ===========================================================================

(setq ps-font-size 10.0)
(global-set-key (kbd "C-x p") 'ps-print-buffer)

;; ===========================================================================
;; TMP
;; ===========================================================================
