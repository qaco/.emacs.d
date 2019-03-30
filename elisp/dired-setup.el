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
