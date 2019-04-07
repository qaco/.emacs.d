(defun smarter-kill-whitespaces ()
 (if (< (line-end-position) (point-max))
	  (delete-region (point) (+ 1 (line-end-position)))
	(delete-region (point) (line-end-position))))

(defun smarter-kill-line ()
  
  "Kills the text until end of line, or deletes the line (without saving) 
if empty."
  
  (interactive)
  
  (if (looking-at "[[:space:]]*$")
      (smarter-kill-whitespaces)
    (kill-line)))

(defun smarter-kill-whole-line ()

  "Kills the current line preserving column position. Doesn't save nor newline
char nor indentation (doesn't save anything if blank line.)"
  
  (interactive)

  (let ((former-column (current-column)))

    (move-to-column (current-indentation))

    (when (not (looking-at "[[:space:]]*$"))
      (smarter-kill-line))

    (beginning-of-line)
    (smarter-kill-whitespaces)
    (move-to-column former-column)))

(defun kill-region-or-line ()

  "Kills marked region if exists, current line otherwise."
  
  (interactive)
  
  (if mark-active
      (kill-region (mark) (point))
    (smarter-kill-whole-line)))

(defun copy-region-or-line ()

  "Saves marked region if exists, current line otherwise."
  
  (interactive)
  
  (if mark-active
      (copy-region-as-kill (mark) (point))
    (kill-ring-save (+ (line-beginning-position) (current-indentation))
		    (line-end-position))))

(provide 'smarter-edition)
