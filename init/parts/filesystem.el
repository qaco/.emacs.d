;; backups

(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/")))
      vc-make-backup-files t                      ; on fait des backups
      version-control t                           ; vérification des versions
      kept-new-versions 10                        ; on garde 10 backups
      kept-old-versions 0                         ; rien de plus ancien
      delete-old-versions t                       ; suppr vieilles versions
      backup-by-copying t)                        ; bkp = cpy

;; ido

(ido-mode 1)                                      ; active ido
(ido-vertical-mode 1)                             ; disposition verticale
(setq ido-everywhere t                            ; tous les buffers/fichiers
      ido-create-new-buffer 'always               ; nveau quand pas trouvé
      ido-auto-merge-work-directories-length -1)  ; pas ds les autres dossiers

;; recentf

(require 'recentf)
(setq recentf-max-saved-items 50)                 ; 50 derniers fichiers
(recentf-mode 1)

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(provide 'filesystem)
