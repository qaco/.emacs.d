;; external tools

(setq browse-url-browser-function                 ; firefox browser par défaut
      'browse-url-firefox)
(setq compile-command "make")

;; scroll doesn't jump

(setq scroll-step 1
      scroll-conservatively 10000
      auto-window-vscroll nil)

;; prompt-free

(fset 'yes-or-no-p 'y-or-n-p)                 ; y-or-n remplace yes-or-no
(setq confirm-nonexistent-file-or-buffer nil  ; créa file sans confirmer
      vc-follow-symlinks nil                  ; symlink sans confirmer
      revert-without-query '(".*"))           ; revert sans confirmer

;; format

(setq-default fill-column 80                  ; largeur de page : 80 char
              word-wrap t)                    ; coupe après le mot
(setq indent-tabs-mode nil)

;; edition/navigation

(delete-selection-mode t)                     ; overwrite region
(setq case-fold-search t)                     ; search ignore la casse

;; advices

(advice-add 'comment-region :before #'copy-region-as-kill)
(advice-add 'split-window-horizontally :after #'balance-windows)

(provide 'default-behaviours)
