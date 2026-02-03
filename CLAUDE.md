# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Testing Commands

```bash
# Test full Emacs startup
emacs --batch -l early-init.el -l init.el

# Test standalone mode (no package management)
emacs --batch -L ~/.emacs.d -l standalone.el

# Byte-compile all Elisp files
emacs --batch -f batch-byte-compile lisp/*.el
```

CI runs these tests automatically on push/PR via `.github/workflows/emacs-startup.yml`.

## Architecture

This is a modular Emacs configuration using **use-package** for package management with MELPA.

### Entry Points

- `early-init.el` - Early initialization (load paths, gc optimization, UI disabling)
- `init.el` - Main init that requires all feature modules
- `standalone.el` - Minimal config without package management

### Feature Modules (in `lisp/`)

| Module | Purpose |
|--------|---------|
| `init-standalone.el` | Core editing defaults, keybindings, UI setup |
| `init-git.el` | Magit, git-gutter |
| `init-ui.el` | anzu, company, which-key |
| `init-edit.el` | move-text, avy navigation |
| `init-windows.el` | winum, windresize |
| `init-languages.el` | eglot LSP (clangd for C/C++, Python) |
| `init-org.el` | Org-mode with agenda, custom todo hooks |
| `init-text.el` | yaml-mode, markdown-mode, olivetti |
| `init-system.el` | xclip, recentf, consult |
| `init-console.el` | vterm/multi-vterm terminal |
| `init-ai.el` | ellama with local Ollama models |

### Custom Modes (in `lisp/`)

- `mlir-mode.el` - MLIR major mode
- `tablegen-mode.el` - TableGen major mode
- `smtlib.el` - SMT-LIB v2 major mode

### Utility Functions

`standalone-functions.el` contains reusable utilities:
- Window management: `swap-buffer-with-adjacent`, `split-window-below-and-center-cursor`
- Editing: `wise-kill-line`, `wise-copy-line`, `smarter-beginning-of-line`
- Git: `my/magit-stage-modified-no-confirm`
- Terminal: `project-vterm`, `my/vterm-setup`

## Keybinding Conventions

- `C-x v` - Git/VC operations (h=stage hunk, d=diff)
- `C-c c/r/n` - Compilation workflow
- `C-c e <key>` - AI/ellama operations
- `C-c w` - Window resizing
- `M-g` - Navigation (goto char/line/word)

## Commit Message Style

Follow the pattern: `<feature>: <change-description> (#<PR-number>)`

Examples from history:
- `vc-diff: fills the full frame (#52)`
- `cpp: clangd instead of ccls (#51)`
