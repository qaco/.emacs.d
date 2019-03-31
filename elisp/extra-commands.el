(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun newline-above ()
  (interactive)
  (end-of-line 0)
  (newline-and-indent))

(defun new-compile-cmd (nveau)
  "Change the compile command without compiling."
  (interactive "sNew compile command: ")
  (setq compile-command nveau))

(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer 
          (delq (current-buffer) 
                (remove-if-not 'buffer-file-name (buffer-list)))))

(provide 'extra-commands)
