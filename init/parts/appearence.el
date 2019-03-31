;; visual informations in buffers

(setq-default indicate-empty-lines t)             ; marque lignes vides
(show-paren-mode t)                               ; matching des parentheses
(global-hl-line-mode t)                           ; highlight ligne courante

;; theming & fonting

(load-theme 'base16-google-dark t)                ; charger theme
(set-face-attribute 'default nil :height 100)     ; taille de police
(set-fontset-font "fontset-default" nil           ; unicode 
                  (font-spec :size 20
                             :name "Symbola"))

(require 'man)
(set-face-attribute 'Man-overstrike nil           ; theming du man
                    :inherit
                    font-lock-function-name-face
                    :bold
                    t)
(set-face-attribute 'Man-underline nil
                    :inherit font-lock-variable-name-face
                    :bold t)

(setq ps-font-size 10.0)                          ; taille à l'impression

;; startup

(add-to-list 'default-frame-alist '(height . 30)) ; hauteur par défaut
(add-to-list 'default-frame-alist '(width . 81))  ; largeur par défaut
(setq inhibit-startup-message t)                  ; cacher startup-message

;; whole window

(setq frame-title-format "%b"                     ; titre : nom du fichier
      icon-title-format "%b")                     ; titre : nom du fichier
(menu-bar-mode -1)                                ; cacher barre de menu
(tool-bar-mode -1)                                ; cacher outils
(scroll-bar-mode -1)                              ; cacher scroll bar
(blink-cursor-mode 0)                             ; curseur fixe

;; line mode

(column-number-mode 1)                            ; afficher numéro de colonne
(line-number-mode 1)                              ; afficher numéro de ligne
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

(provide 'appearence)
