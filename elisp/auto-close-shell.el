;;; auto-close-shell.el --- auto close shell when exit  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  OGAWA Hirofumi

;; Author: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
;; Keywords: convenience, processes

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This makes a `shell' session, but windows are closed automatically
;; when shell process has exited.
;;
;; For example, use `auto-close-shell' command instead of shell
;;
;; M-x auto-close-shell
;;
;; or
;;
;; (autoload 'auto-close-shell "auto-close-shell" nil t)
;; (global-set-key "\C-cs" 'auto-close-shell)

;;; Code:

(defgroup auto-close-shell nil
  "Auto close shell."
  :prefix "auto-close-shell-"
  :version "25.1"
  :group 'auto-close-shell)

(defcustom auto-close-shell-kill-buffer nil
  "If non-nil, kill buffer even if shell exited in background."
  :type 'boolean
  :group 'auto-close-shell)

(defun auto-close-shell-sentinel (process event)
  "When shell PROCESS exit, kill buffer and window.
PROCESS and EVENT are to used to call original sentinel."
  (let ((sentinel (process-get process 'auto-close-shell-original-sentinel))
	(buffer (process-buffer process))
	had-window)
    ;; call original sentinel
    (funcall sentinel process event)
    ;; start auto close
    (when (not (process-live-p process))
      ;; close windows first
      (if (dolist (window (get-buffer-window-list buffer nil t) had-window)
	    (when (window-live-p window)
	      (quit-window nil window)
	      (setq had-window t)))
	  ;; kill buffer was in window
	  (and (buffer-live-p buffer)
	       (kill-buffer buffer))
	;; kill buffer was not in window (killed in background)
	(and auto-close-shell-kill-buffer
	     (buffer-live-p buffer)
	     (kill-buffer buffer))))))

;;;###autoload
(defun auto-close-shell (&rest args)
  "Setup shell with ARGS arguments, then add sentinel chain to shell process."
  (interactive)
  (let* ((buffer (call-interactively #'shell args))
	 (process (get-buffer-process buffer))
	 (sentinel (and process (process-sentinel process))))
    (when (and process (not (eq sentinel 'auto-close-shell-sentinel)))
      (process-put process 'auto-close-shell-original-sentinel sentinel)
      (set-process-sentinel process #'auto-close-shell-sentinel))
    buffer))

(provide 'auto-close-shell)
;;; auto-close-shell.el ends here
