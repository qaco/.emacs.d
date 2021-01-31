(require 'font-lock)

(defvar heptagon-mode-hook nil)

(defvar heptagon-font-lock-keywords nil
  "Regular expression used by Font-lock mode.")

(setq heptagon-font-lock-keywords
      '(
	;; Comments
	("(\\*.*" . font-lock-comment-face)
	;; Preprocessors
	("\\(![a-zA-Z0-9_]*\\)\\>" . font-lock-keyword-face)
	("\\(#include\\|#define\\|#ifndef\\|#endif\\|#if\\|#else\\)\\>" . font-lock-keyword-face)
	("#define \\([a-zA-Z0-9_]*\\)" 1 font-lock-variable-name-face)
	("#ifndef \\([a-zA-Z0-9_]*\\)" 1 font-lock-variable-name-face)
	("![a-zA-Z0-9_]* +\\([a-zA-Z0-9_]*\\)" 1 font-lock-variable-name-face)
	;; Keywords
	("\\<\\(open\\|fun\\|node\\|let\\|tel\\|var\\|returns\\)\\>" . font-lock-keyword-face)
	("\\<\\(const\\|type\\|if\\|then\\|else\\|end\\|switch\\|do\\)\\>" . font-lock-keyword-face)
	;; Functions
	("\\<\\(map\\|mapi\\|fold\\|foldi\\|mapfold\\)\\>" . font-lock-builtin-face)
	("\\<\\(fby\\|pre\\|->\\|and\\|or\\)\\>" . font-lock-builtin-face)
	("\\<\\(when\\|whenot\\|merge\\)\\>" . font-lock-builtin-face)
	("\\([a-zA-Z0-9_]*\\)\\( \\|\\\n\\)*<<" 1 font-lock-function-name-face)
	("\\([a-zA-Z0-9_]*\\)\\( \\|\\\n\\)*([^\\*]" 1 font-lock-function-name-face)
        ("fun *\\([a-zA-Z0-9_]*\\) *" 1 font-lock-function-name-face)
	("node *\\([a-zA-Z0-9_]*\\) *" 1 font-lock-function-name-face)
	;; Variables
        ("\\<\\([a-zA-Z0-9_]*\\) *:" 1 font-lock-variable-name-face)
	(": *\\([a-zA-Z0-9_\\^ ]*\\)" 1 font-lock-type-face)
	("\\<type +\\([a-zA-Z0-9_]*\\) *" 1 font-lock-type-face)
        ))

(defun smooth-indent(ind)
  (if (< ind 0)
      0
    ind))

(defun current-line-empty-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*$")))

(defun jump-to-last-nonblank-line (res)
  (interactive)
  (if (and (current-line-empty-p) (< 1 (line-beginning-position)))
      (prog2
	  (forward-line -1)
	  (jump-to-last-nonblank-line t))
    nil))

(defun get-next-indentation (curr)
  (interactive)
  (save-excursion
    (if (= (line-end-position) (point))
	curr
      (cond 
	     ((looking-at "\\(!.*\\)")
	      (prog2
	     	  (goto-char (match-end 1))
	     	  (get-next-indentation curr)))

	     ((looking-at "\\([a-zA-Z0-9_]+ *: *[a-zA-Z0-9_]+ *\\)[}]")
	      (prog2
		  (goto-char (match-end 1))
		  (get-next-indentation curr)))
	     
	     ((looking-at "\\<\\(let\\|fun\\|var\\|switch\\)\\>")
	      (prog2
		 (goto-char (match-end 1))
		  (get-next-indentation (+ curr 2))))

	     ((looking-at "\\(\\<*[a-zA-Z0-9_]+ *=\\|\\<if\\>.*\\|\\<const\\>.*=\\|:\\|| *[a-zA-Z0-9_]+ +do\\)")
	      (prog2
		 (goto-char (match-end 1))
		 (get-next-indentation (+ curr 2))))
	    
	     ((looking-at "\\(<<\\)")
	     (prog2
		 (goto-char (match-end 1))
		 (get-next-indentation (+ curr 3))))
	     
	    ((looking-at "\\((\\)")
	     (prog2
		 (goto-char (match-end 1))
		 (get-next-indentation (+ curr 1))))
	    
	    ((looking-at "\\()\\)")
	     (prog2
		 (goto-char (match-end 1))
		 (get-next-indentation (- curr 1))))
	    
	    ((looking-at "\\(tel\\|returns\\|;\\|[}]\\)")
	     (prog2
		 (goto-char (match-end 1))
		 (get-next-indentation (- curr 2))))

	    ((looking-at "\\([a-zA-Z0-9_]+ *: *[a-zA-Z0-9_]+ *>>\\|[a-zA-Z0-9_]+ *: *[a-zA-Z0-9_]+ *)\\|>>\\)")
	     (prog2
		 (goto-char (match-end 1))
		 (get-next-indentation (- curr 3))))

	    (t
	     (prog2
	     	 (forward-char)
	     	 (get-next-indentation curr)))))))

(defun get-curr-indentation (curr)
  (interactive)
  (save-excursion
    (cond
     
     ((looking-at "\\(tel\\|let\\|var\\|const\\|type\\|open\\|#\\|returns\\)\\>")
      0)

     ((looking-at "\\(| *[a-zA-Z0-9_]+ +do\\)")
      (- curr 2))
     
     ((looking-at "\\<\\(then\\|else\\|end\\)\\>")
      (- curr 2))
     
     (t curr))))

(defun heptagon-indent-line ()
  (interactive)
  (let* (
	 (last-line-indent
	  (if (= 1 (line-beginning-position))
	      0
	    (save-excursion
	      (forward-line -1)
	      (jump-to-last-nonblank-line nil)
	      (back-to-indentation)
	      (get-next-indentation (current-indentation)))))
	 
	 (cur-line-indent
	  (save-excursion
	    (back-to-indentation)
	    (get-curr-indentation last-line-indent))))
    
    (indent-line-to (smooth-indent cur-line-indent))))

(defun heptagon-font-mode ()
  "Initialisation of font-lock for Heptagon mode."
  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
        '(heptagon-font-lock-keywords t)))
  
(defun heptagon-indent-mode ()
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'heptagon-indent-line))

(if window-system
    (progn
      (add-hook 'heptagon-mode-hook
		'turn-on-font-lock)
      (add-hook 'heptagon-mode-hook
		'heptagon-font-mode)
      (add-hook 'heptagon-mode-hook
		'heptagon-indent-mode)
      (setq font-lock-maximum-decoration t)))

(defun heptagon-mode ()
  "Major mode for editing Heptagon files"
  (interactive)
  (kill-all-local-variables)
  (setq-local comment-start "(* ")
  (setq-local comment-end " *)")
  (setq major-mode 'heptagon-mode)
  (setq mode-name "Heptagon")
  (run-hooks 'heptagon-mode-hook))

(setq auto-mode-alist (cons '("\\.ept" . heptagon-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.epi" . heptagon-mode) auto-mode-alist))

(provide 'heptagon-mode)
