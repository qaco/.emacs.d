;; elisp built-in files :
;;
;; /usr/local/share/emacs/$VERSION/

;; ===========================================================================
;; F-KEYS
;; ===========================================================================
;; compile                             f1
;; new-compile-cmd                     C-f1
;; recompile                           f2
;; flycheck                            C-f2
;; next-error                          f3
;; flycheck-next-error                 C-f3
;; make clean                          f4
;;
;; split-horizontally                  f5
;; regle                               C-f5
;; delete-window                       f6

;; maximize                            f11
;; fullscreen                          C-f11
;;
;; ===========================================================================
;; DOCUMENTATION
;; ===========================================================================
;; 
;; [emacs/elisp]
;; describe-function                    C-h f 
;; describe-variable                    C-h v
;; describe-bindings                    C-h b
;; describe-key                         C-h k 
;; recherche commande                   C-h a
;; view-emacs-problems                  C-h C-p
;; view-emacs-todo                      C-h C-t
;; [shell/C]
;; man UNIX                             M-x man

;; ===========================================================================
;; EVAL
;; ===========================================================================
;; 
;; [elisp]
;; elisp interpreter                    M-:
;; Définir macro                        C-x ( / C-x )
;; Exécuter la dernière macro           C-x e
;; [ocaml]
;; toplevel ocaml                       M-x run-ocaml
;; evaluate ocaml                       C-c C-e
;; [shell]
;; commande UNIX                        M-!
;;
;; ===========================================================================
;; NAVIGATION
;; ===========================================================================
;; 
;; caractère                            C-b/C-f
;; mot                                  M-b/M-f
;; ligne                                C-p/C-n
;; fin/début de ligne                   C-a/C-e
;; fin/début de fonction                C-M-a/C-M-e
;; écran suivant/précédent              C-v/M-v
;; centrer l'écran                      C-l
;; goto-line                            M-g M-g
;; scroll other window                  M-C-V/M-C-v
;; select other window                  S-<arrow>
;;
;; ===========================================================================
;; RECHERCHE
;; ===========================================================================
;;
;; rechercher                           C-s/C-r
;; chercher et remplacer                M-%
;; completion                           C-:
;;
;; ===========================================================================
;; KILL/DEL/COMMENT
;; ===========================================================================
;; 
;; comment current line                 C-x C-;
;; copy and comment                     C-;
;; supprimer caractère                  DEL/C-d
;; supprimer mot                        M-DEL/M-d
;; kill phrase                          M-k
;; kill sexp                            C-M-k
;; zap-to-char                          M-z
;; naviguer kill-ring                   M-y
;;
;; ===========================================================================
;; RÉGION
;; ===========================================================================
;;
;; marquer le paragraphe                M-h
;; marquer la fonction                  C-M-h
;; marquer le buffer                    C-x h
;; étendre région                       C-=
;;
;; ===========================================================================
;; UNDO/REDO
;; ===========================================================================
;;
;; undo/redo                            C-_
;; remonter undo-ring                   M-_
;; undo/redo window configuration       C-c <left>/C-c <right>

;; ===========================================================================
;; VARIABLES D'ENVIRONNEMENT
;; ===========================================================================

(setq browse-url-browser-function (quote browse-url-generic)
      backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))

;; ===========================================================================
;; LOAD
;; ===========================================================================

(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)

(package-initialize)                    

;; ===========================================================================
;; INTERFACE DISTRACTION-FREE
;; ===========================================================================

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
(setq-default fringe-indicator-alist
              '((truncation left-arrow right-arrow)
                (continuation nil nil) ;; left-curly-arrow & right-curly-arrow
                (overlay-arrow . right-triangle)
                (up . up-arrow)
                (down . down-arrow)
                (top top-left-angle top-right-angle)
                (bottom
                 bottom-left-angle bottom-right-angle
                 top-right-angle top-left-angle)
                (top-bottom
                 left-bracket right-bracket top-right-angle top-left-angle)
                (empty-line . empty-line)
                (unknown . question-mark)))

;; ===========================================================================
;; INFORMATIONS À AFFICHER
;; ===========================================================================

(display-time-mode 1)                             ; afficher horloge
(column-number-mode 1)                            ; afficher numéro de colonne
(line-number-mode 1)                              ; afficher numéro de ligne
;; (global-linum-mode t)                          ; num toutes les lignes
;; (global-hl-line-mode t)                        ; highlight ligne courante
(show-paren-mode t)                               ; matching des parentheses

(setq-default fill-column 80                      ; largeur de page : 80 char
              indicate-empty-lines t)             ; marque lignes vides

(setq display-time-24hr-format t)                 ; horloge format 24h

;; ===========================================================================
;; FENETRES
;; ===========================================================================

(winner-mode 1)                                   ; undo/redo fenetres

(add-to-list 'default-frame-alist '(height . 30)) ; hauteur par défaut
(add-to-list 'default-frame-alist '(width . 81))  ; largeur par défaut


;; ===========================================================================
;; COMPORTEMENT DES COMMANDES
;; ===========================================================================

(delete-selection-mode t)                         ; overwrite region
;; (global-aggressive-indent-mode 1)

(setq scroll-step 1)                              ; scrolling ligne par ligne
(setq-default indent-tabs-mode nil)               ; pas de tabs
(setq case-fold-search t)                         ; search ignore la casse

(ac-config-default)
(setq ac-use-quick-help nil)

;; ===========================================================================
;; COMPILATION
;; ===========================================================================

(setq compile-command "")

;; ===========================================================================
;; IDO
;; ===========================================================================

(ido-mode 1)                                      ; active ido
(ido-vertical-mode 1)                             ; disposition verticale

(setq ido-enable-flex-matching t                  ; souplesse du matching
      ido-everywhere t                            ; tous les buffers/fichiers
      ido-create-new-buffer 'always               ; nveau quand pas trouvé
      ido-auto-merge-work-directories-length -1)  ; pas ds les autres dossiers

;; ===========================================================================
;; INTÉGRITÉ DES DONNÉES
;; ===========================================================================

(setq vc-make-backup-files t                      ; on fait des backups
      version-control t                           ; vérification des versions
      kept-new-versions 10                        ; on garde 10 backups
      kept-old-versions 0                         ; rien de plus ancien
      delete-old-versions t                       ; suppr des vieilles versions
      backup-by-copying t)                        ; bkp = cpy

;; ===========================================================================
;; FONCTIONS
;; ===========================================================================

(defun new-compile-cmd (nveau)
  "Change the compile command without compiling."
  (interactive "sNew compile command: ")
  (setq compile-command nveau))

(defun clean()
  "Launch make clean from the current directory."
  (interactive)
  (shell-command "make clean"))
    
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

(defun kill-region-or-line ()
  (interactive)
  (if mark-active
      (call-interactively 'kill-region)
    (call-interactively 'kill-whole-line)))

(defun copy-region-or-line ()
  (interactive)
  (if mark-active
      (call-interactively 'copy-region-as-kill)
    (kill-ring-save (line-beginning-position)
                    (line-beginning-position 2))))

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

;; ===========================================================================
;; MODIFIER FONCTIONS
;; ===========================================================================

(advice-add 'split-window-horizontally :after #'balance-windows)
(advice-add 'split-window-vertically :after #'balance-windows)
(advice-add 'delete-window :after #'balance-windows)

;; ===========================================================================
;; BINDINGS
;; ===========================================================================

;; Bindings++

(global-set-key (kbd "C-w") 'kill-region-or-line)
(global-set-key (kbd "C-a") 'smarter-move-beginning-of-line)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "M-w") 'copy-region-or-line)
(windmove-default-keybindings)                    ; S-<arrow> navig fenetres

;; Remap

(global-set-key (kbd "C-:") 'dabbrev-expand)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Unset

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

;; New bindings

(global-set-key (kbd "M-_") 'undo-only)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-;") 'copy-and-comment-region)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; F-keys

(global-set-key (kbd "<f1>") 'compile)
(global-set-key (kbd "C-<f1>") 'new-compile-cmd)
(global-set-key (kbd "<f2>") 'recompile)
(global-set-key (kbd "C-<f2>") 'global-flycheck-mode)
(global-set-key (kbd "<f3>") 'next-error)
(global-set-key (kbd "C-<f3>") 'flycheck-next-error)
(global-set-key (kbd "<f4>") 'clean)

(global-set-key (kbd "<f5>") 'split-window-horizontally)
(global-set-key (kbd "C-<f5>") 'fci-mode)
(global-set-key (kbd "<f6>") 'delete-window)

(global-set-key (kbd "<f11>") 'toggle-frame-maximized)
(global-set-key (kbd "C-<f11>") 'toggle-frame-fullscreen)
