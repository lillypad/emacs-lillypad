;;; generic.el --- Generic Configuration

;;; Commentary:
;; Generic Configuration

;;; Code:

(defun eshell/clear ()
  "EShell Clear Buffer."
  (interactive)
  (let ((eshell-buffer-maximum-lines 0)) (eshell-truncate-buffer)))
(xterm-mouse-mode)
(setq ring-bell-function 'ignore)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-directory-alist
    `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
    `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)
(ivy-mode)
(projectile-mode t)
(helm-projectile-on)
;;; generic.el ends here
