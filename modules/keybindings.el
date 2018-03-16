;;; keybindings.el --- Keybinding Configuration

;;; Commentary:
;; Keybinding Configuration

;;; Code:

(global-set-key (kbd "C-M-c") 'comment-region)
(global-set-key (kbd "C-M-u") 'uncomment-region)
(global-set-key (kbd "C-M-s") 'ispell)
(global-set-key (kbd "C-M-d") 'magit-ediff-compare)
(global-set-key (kbd "M-j") 'yas-expand)
(global-set-key (kbd "M-n") 'yas-next-field-or-maybe-expand)
(global-set-key (kbd "M-o m") (kbd "RET"))
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-M-p") 'package-list-packages)
(global-set-key (kbd "C-M-x s") 'server-start)

(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-select-next)
     (define-key company-active-map [tab] 'company-select-next)
     (define-key company-active-map (kbd "<S-tab>") 'company-select-previous)
     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))

;;; keybindings.el ends here
