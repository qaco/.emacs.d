(defun smarter-beginning-of-line (arg)
  
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

(defun yank-and-indent ()
  (interactive)
  (yank)
  (indent-region (mark) (point)))

(provide 'extra-commands)
