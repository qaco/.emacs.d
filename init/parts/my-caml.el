(load "~/.emacs.d/opam-user-setup.el")
(require 'opam-user-setup)
(require 'menhir-mode)
(require 'heptagon-mode)
(require 'mlir-mode)

(setq tuareg-indent-align-with-first-arg t
      tuareg-match-patterns-aligned 1
      tuareg-prettify-symbols-basic-alist
      `(("'a" . ?α)
        ("'b" . ?β)
        ("'c" . ?γ)
        ("'d" . ?δ)
        ("'e" . ?ε)
        ("'f" . ?φ)
        ("'i" . ?ι)
        ("'k" . ?κ)
        ("'m" . ?μ)
        ("'n" . ?ν)
        ("'o" . ?ω)
        ("'p" . ?π)
        ("'r" . ?ρ)
        ("'s" . ?σ)
        ("'t" . ?τ)
        ("'x" . ?ξ)))

(add-hook 'tuareg-mode-hook
 (lambda()
   (when (functionp 'prettify-symbols-mode)
     (prettify-symbols-mode))
   (setq mode-name "🐫")
   ))

(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)

(defun llvm-cout ()
  (interactive)
  (insert "std::error_code err;\n")
  (insert "llvm::raw_fd_ostream stream(\"/dev/stdout\", err);\n"))

(provide 'my-caml)
