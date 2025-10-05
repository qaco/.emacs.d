(use-package ellama
  :ensure t
  :init
  (require 'llm-ollama)
  (setopt ellama-provider
  	  (make-llm-ollama
  	   :chat-model "gemma3:4b-it-qat"
  	   :embedding-model "nomic-embed-text"
  	   :default-chat-non-standard-params '(("num_ctx" . 128000))))
  (setopt ellama-providers
  	  '(("gemma3" . (make-llm-ollama
  			 :chat-model "gemma3:4b-it-qat"
  			 :embedding-model "nomic-embed-text"))
  	    ("qwen2.5-coder" . (make-llm-ollama
  			        :chat-model "qwen2.5-coder:7b"
  			        :embedding-model "nomic-embed-text"))
            ))
  (setopt
   ellama-coding-provider
   (make-llm-ollama
    :chat-model "qwen2.5-coder:7b"
    :embedding-model "nomic-embed-text"
    :default-chat-non-standard-params '(("num_ctx" . 32000))))
  :config
  (setopt ellama-auto-scroll t)
  (global-set-key (kbd "C-c e c") #'ellama-chat)
  ;; Code
  (global-set-key (kbd "C-c e r") #'ellama-code-review)
  (global-set-key (kbd "C-c e a") #'ellama-code-add)
  (global-set-key (kbd "C-c e f") #'ellama-fix-code)
  (global-set-key (kbd "C-c e d") #'ellama-docstring)
  (global-set-key (kbd "C-c e e") #'ellama-edit)
  (global-set-key (kbd "C-c e ?") #'ellama-ask-selection)
  (global-set-key (kbd "C-c e i") #'ellama-code-improve)
  (global-set-key (kbd "C-c e m") #'ellama-generate-commit-message)
  ;; Text
  (global-set-key (kbd "C-c e s") #'ellama-summarize)
  (global-set-key (kbd "C-c e t") #'ellama-translate-to-french)
  (global-set-key (kbd "C-c e b") #'ellama-translate-to-english)
  (global-set-key (kbd "C-c e p") #'ellama-proofread)
  (global-set-key (kbd "C-c e g") #'ellama-generate)
  )

(defvar ellama-translate-to-english-prompt
  (concat
   "Traduis fidèlement en anglais le texte suivant. "
   "N'ajoute pas de commentaires."
   "\n\n%s"
   ))

(defvar ellama-translate-to-french-prompt
  (concat
   "Traduis fidèlement en français le texte suivant. "
   "N'ajoute pas de commentaires."
   "\n\n%s"
   ))

(defun ellama-translate-to-english ()
  "Traduit le texte sélectionné (ou le buffer courant) en anglais avec Ellama."
  (interactive)
  (let ((text (ellama--get-region-or-buffer)))
    (ellama-chat
     (format ellama-translate-to-english-prompt text)
     nil
     :provider (alist-get "gemma3" ellama-providers)
     :ephemeral 1)))

(defun ellama-translate-to-french ()
  "Traduit le texte sélectionné (ou le buffer courant) en français avec Ellama."
  (interactive)
  (let ((text (ellama--get-region-or-buffer)))
    (ellama-chat
     (format ellama-translate-to-french-prompt text)
     nil
     :provider (alist-get "gemma3" ellama-providers)
     :ephemeral 1)))

(defun ellama--get-region-or-buffer ()
  "Retourne le texte sélectionné, ou tout le buffer s’il n’y a pas de sélection."
  (if (use-region-p)
      (buffer-substring-no-properties (region-beginning) (region-end))
    (buffer-substring-no-properties (point-min) (point-max))))

(provide 'init-ai)
