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

  "Kills the current line preserving column position. Doesn't save newline
char (and doesn't save anything if blank.)"
  
  (interactive)

  (let ((former-column (current-column)))      ; save column
    
    (beginning-of-line)
    
    (cond ((looking-at "[[:space:]]*$")        ; blank line
	   (smarter-kill-whitespaces))         ; just kill it

	  ((= (line-end-position) (point-max)) ; last line
	   (smarter-kill-line))                ; just kill it
	  
	  (t                                   ; any other line :  
	   (delete-indentation)                ; join to above, del spaces
	   (delete-forward-char 1 nil)         ; del last whitespace
	   (kill-line)                         ; regular kill
	   (if (= (point) (point-min))         ; nothing above :
	       (smarter-kill-whitespaces)      ; achieve it
					       ; something above :
	     (next-line))))                    ; back to next line

    (move-to-column former-column)))           ; restore column

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
    (save-excursion
      (progn
	(beginning-of-line)
	(indent-for-tab-command)
        (kill-ring-save (point) (line-end-position))))))

(provide 'smarter-edition)
