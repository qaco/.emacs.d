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

;; Todo : restore column
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

    (if (<= former-column                      ; restore column
	    (- (line-end-position)
	       (line-beginning-position)))
	(move-to-column former-column)
      (end-of-line))))

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
