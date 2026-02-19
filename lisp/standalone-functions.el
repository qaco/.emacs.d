(defun swap-buffer-with-adjacent (direction)
  "Swap the current buffer with the buffer in the adjacent window in
   the specified DIRECTION, and move the cursor to the adjacent window."
  (let ((current-window (selected-window))
        (other-window (window-in-direction direction)))
    (when other-window
      (let ((current-buffer (window-buffer current-window))
            (other-buffer (window-buffer other-window)))
        (set-window-buffer current-window other-buffer)
        (set-window-buffer other-window current-buffer)
        (select-window other-window)))))

(defun smarter-beginning-of-line ()
  "Move point to the first non-whitespace character or beginning of
   line. Move point to the beginning of line if point was already at
   the indentation."
  (interactive)
  (let ((initial-point (point)))
    (back-to-indentation)
    (when (= initial-point (point))
      (beginning-of-line))))

(defun wise-kill-whitespaces ()
 (if (< (line-end-position) (point-max))
	  (delete-region (point) (+ 1 (line-end-position)))
	(delete-region (point) (line-end-position))))

(defun wise-copy-line ()
  (interactive)
  (wise-kill-or-copy-line nil))

(defun wise-kill-line ()
  (interactive)
  (wise-kill-or-copy-line 1))

(defun wise-kill-or-copy-line (should-kill)

  "Copy/kill the current line preserving column position. Doesn't save
   nor newline char nor indentation (doesn't save anything if blank line.)"
  
  (interactive)

  ;; Save the column position and go to indentation
  (let ((former-column (current-column)))
    (move-to-column (current-indentation))
    ;; Copy & delete (instead of kill) the text until the end of line
    (call-interactively 'set-mark-command)
    (call-interactively 'end-of-line)
    (copy-region-as-kill (mark) (point))
    (when should-kill
      (delete-region (mark) (point))
      ;; Remove all remaining whitespaces (including newline)
      (beginning-of-line)
      (wise-kill-whitespaces))
    ;; Restore the column position
    (move-to-column former-column)))

(defun save-buffer-copy (filename)
  "Save a copy of the current buffer to a specified FILENAME without changing the buffer."
  (interactive "FSave buffer copy to file: ")
  (write-region (point-min) (point-max) filename)
  (message "Buffer saved to %s" filename))

(defun move-line-up ()
  "Move the current line up by one."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  "Move the current line down by one."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(defun project-eshell ()
  (interactive)
  (let ((default-directory (project-root (project-current t))))
    (eshell)))

(defun my/git-branch ()
  (let ((branch (string-trim
                 (shell-command-to-string
                  "git rev-parse --abbrev-ref HEAD 2>/dev/null"))))
    (unless (string-empty-p branch) branch)))

(provide 'standalone-functions)
