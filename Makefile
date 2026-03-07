EMACS   = emacs
EMACS_D = $(HOME)/.emacs.d

.PHONY: check init standalone byte unit

check: init standalone byte unit clean

init:
	$(EMACS) --batch \
		--eval '(setq debug-on-error t inhibit-startup-screen t)' \
		--eval '(setq user-emacs-directory (expand-file-name "~/.emacs.d/"))' \
		-l $(EMACS_D)/early-init.el \
		-l $(EMACS_D)/init.el

standalone:
	$(EMACS) --batch \
		-L $(EMACS_D) \
		--eval '(setq debug-on-error t inhibit-startup-screen t)' \
		--eval '(setq user-emacs-directory (expand-file-name "~/.emacs.d/"))' \
		-l $(EMACS_D)/standalone.el

byte:
	$(EMACS) --batch \
		-l $(EMACS_D)/early-init.el \
		-l $(EMACS_D)/init.el \
		--eval '(setq debug-on-error t)' \
		--eval '(byte-recompile-directory (expand-file-name "~/.emacs.d/lisp") 0 t)'

unit:
	$(EMACS) --batch \
		-L $(EMACS_D) \
		-L $(EMACS_D)/test \
		-l $(EMACS_D)/early-init.el \
		-l $(EMACS_D)/init.el \
		-l $(EMACS_D)/test/test-init.el \
		--eval '(ert-run-tests-batch-and-exit)'

clean:
	rm -rf *.elc $(EMACS_D)/lisp/*.elc
