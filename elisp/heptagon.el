(require 'font-lock)

(defvar heptagon-mode-hook nil)

(defvar heptagon-mode-map
  (let ((heptagon-mode-map (make-keymap)))
    (define-key heptagon-mode-map "\C-j" 'newline-and-indent)
    heptagon-mode-map)
  "Keymap for Heptagon major mode")

;; SYNTAX HIGHLIGHTING

(defvar heptagon-font-lock-keywords nil
  "Regular expression used by Font-lock mode.")

(setq heptagon-font-lock-keywords
      '(
        ;; Commentaires
        ("\\((\\*.*\\)" . font-lock-comment-face)

        ;; Fonctions & variables
        ("\\(?:node\\|fun\\)\\s-+\\(\\sw+\\)\\s-*(" 1 font-lock-function-name-face)
        ("\\(\\sw+\\)\\s-*:.*\\s-+;" 1 font-lock-variable-name-face)

        ;; Fonction built-in
        ("\\(\\<\\(fby\\|pre\\|last\\)\\>\\|->\\)"
         . font-lock-constant-face)
        ("\\(\\<\\(or\\|xor\\|xor\\|not\\)\\>\\|&\\)"
         . font-lock-constant-face)
        ("\\(>=\\|<=\\|<\\|>\\)" . font-lock-constant-face)

        ;; Keywords
        ("\\<\\(node\\|fun\\|var\\)\\>" . font-lock-keyword-face)
        ("\\<\\(returns\\)\\>" . font-lock-keyword-face)
        ("\\<\\(let\\|tel\\)\\>" . font-lock-keyword-face)
        ("\\<\\(if\\|then\\|else\\)\\>" . font-lock-keyword-face)

        ;; Types
        ("\\<\\(bool\\|int\\|float\\)\\>" . font-lock-type-face)

        ;; Constantes
        ("\\<\\(true\\|false\\|[0-9.]+\\)\\>" . font-lock-string-face)

        ;; Automates
        ("\\<\\(automaton\\|end\\)\\>" . font-lock-keyword-face)
        ("\\<\\(do\\|until\\)\\>" . font-lock-keyword-face)
        ("\\<\\(state\\)\\>" . font-lock-type-face)
        ("\\<state\\>\\s-+\\([A-Z]\\sw+*\\)" 1 font-lock-variable-name-face)
        ))

;; INDENTATION

(defun heptagon-indent-line ()
    (let ((continue t)
          (indent 0))
      (save-excursion
        (beginning-of-line)

        (prog2

            ;; On récupère les informations d'indentation éventuellement
            ;; contenues dans la ligne courante.

            (cond ((should-not-indent) (setq continue nil))
                  
                  ((find-unmatching-paren)
                   (setq indent (find-unmatching-paren)
                         continue nil))
                  
                  ((should-deindent)
                   (setq indent (- indent default-tab-width))))

            ;; Si besoin, on récupère les informations d'indentation
            ;; manquantes en remontant dans les lignes précédentes.
            
            (while continue
              (forward-line -1)
                 
              (cond ((<= (point) 1)
                     (setq continue nil))
                    
                    ((should-4-indent-next)
                     (setq indent (+ indent 4)
                           continue nil))
                       
                    ((should-2-indent-next)
                     (setq indent (+ indent 2)
                           continue nil))
                       
                    ((should-deindent-next)
                     (setq indent (- indent default-tab-width)))
                       
                    ((should-indent-next)
                     (setq indent (+ indent default-tab-width)))))))
      
    (indent-line-to indent)))

(defun find-unmatching-paren()
  (save-excursion
    (beginning-of-line)
    (let ((count 0)
          (continue t)
          (result nil))
      (while continue
        (forward-char -1)
        (cond  ((or (= (point) 1) (has-indent-hint))
               (setq continue nil))

               ((looking-at ")")
                (setq count (- count 1)))

               ((and (looking-at "(") (< count 0))
                (setq count (+ count 1)))
               
               ((and (looking-at "(") (>= count 0))
                (setq result (current-column)
                      continue nil))

               (t (setq continue t))))
      result)))

(defun should-not-indent ()
   (looking-at "\\s-*\\<\\(node\\|fun\\|let\\|tel\\|var\\|returns\\)"))

(defun should-deindent ()
  (looking-at "\\s-*\\<\\(end\\)\\>"))

(defun should-deindent-next ()
  (looking-at "\\s-*\\<\\(end\\|until\\)\\>"))

(defun should-indent-next ()
  (looking-at "\\s-*\\<\\(automaton\\|state\\)\\>"))

(defun should-4-indent-next ()
  (looking-at "\\s-*\\<\\(var\\)\\>"))

(defun should-2-indent-next ()
  (looking-at "\\s-*\\<\\(let\\|node\\|fun\\)\\>"))

(defun has-indent-hint ()
  (or (should-not-indent)
       (or (should-deindent-next)
            (or (should-indent-next)))))

(defvar heptagon-mode-syntax-table
  (let ((heptagon-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" heptagon-mode-syntax-table)
    heptagon-mode-syntax-table)
  "Syntax table for heptagon-mode")

;;;###autoload
(defun heptagon-mode ()
  "Major mode for editing Heptagon files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table heptagon-mode-syntax-table)
  (use-local-map heptagon-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(heptagon-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'heptagon-indent-line)
  (setq major-mode 'heptagon-mode)
  (setq mode-name "Heptagon")
  (run-hooks 'heptagon-mode-hook))

(provide 'heptagon)


