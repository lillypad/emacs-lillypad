;;; init.el --- An Emacs Configuration for Humans

;; Author: Lilly Chalupowski
;; URL: http://github.com/lillypad/emacs.d

;; The GNU General Public License (GPL)

;; Copyright (C) 2018  Lilly Chalupowski

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;; Description: An Emacs Configuration for Humans
;; Author: Lilly Chalupowski

;;; Code:

(require 'cl)
(require 'package)

(setq warning-minimum-level :emergency)

(package-initialize)

(cond
 ((string-equal system-type "windows-nt")
  (progn
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))))
 ((string-equal system-type "darwin")
  (progn
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))))
 ((string-equal system-type "gnu/linux")
  (progn
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")))))

(defvar required-packages
  '(emojify
    dashboard
    auctex
    company-auctex
    dockerfile-mode
    yaml-mode
    ace-jump-mode
    ivy
    paredit
    rainbow-mode
    hydra
    helm-swoop
    emmet-mode
    neotree
    ruby-mode
    rust-mode
    web-mode
    projectile
    helm
    helm-projectile
    eshell
    xterm-color
    elixir-mode
    elixir-yasnippets
    alchemist
    powershell
    actionscript-mode
    yara-mode
    go-mode
    company-go
    slime
    slime-company
    magit
    php-mode
    flycheck
    flycheck-pycheckers
    flycheck-popup-tip
    markdown-mode
    autopair
    js2-mode
    tern
    yasnippet
    yasnippet-snippets
    popwin
    pos-tip
    json-mode
    company
    company-quickhelp
    company-tern
    company-jedi
    company-c-headers
    company-php
    clojure-mode
    cmake-mode
    jedi-core
    rainbow-delimiters
    powerline
    airline-themes
    highlight-indent-guides
    jquery-doc
    js2-refactor))

(defvar required-packages-core
  '(dashboard
    ace-jump-mode
    ivy
    rainbow-mode
    hydra
    helm-swoop
    neotree
    projectile
    helm
    helm-projectile
    helm-config
    eshell
    xterm-color
    magit
    flycheck
    flycheck-popup-tip
    autopair
    yasnippet
    yasnippet-snippets
    popwin
    pos-tip
    company
    company-quickhelp
    company-tern
    rainbow-delimiters
    powerline
    airline-themes
    highlight-indent-guides))

(defvar required-packages-latex '(auctex company-auctex))

(defvar required-packages-docker '(dockerfile-mode))

(defvar required-packages-yaml '(yaml-mode))

(defvar required-packages-elisp '(paredit))

(defvar required-packages-ruby '(ruby-mode))

(defvar required-packages-rust '(rust-mode))

(defvar required-packages-web '(web-mode emmet-mode))

(defvar required-packages-clojure '(clojure-mode paredit))

(defvar required-packages-php '(php-mode company-php))

(defvar required-packages-powershell '(powershell))

(defvar required-packages-yara '(yara-mode))

(defvar required-packages-markdown '(markdown-mode))

(defvar required-packages-actionscript '(actionscript-mode))

(defvar required-packages-js '(json-mode js2-refactor js2-mode tern jquery-doc company-tern))

(defvar required-packages-go '(go-mode company-go))

(defvar required-packages-c '(company-c-headers cmake-mode))

(defvar required-packages-python '(jedi-core company-jedi flycheck-pycheckers))

(defvar required-packages-elixir '(elixir-mode elixir-yasnippets alchemist))

(defvar required-packages-lisp '(slime slime-company paredit))

(defun packages-installed-p ()
  "Install package-list if not installed."
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (packages-installed-p)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(dolist (p required-packages-core)
  (require p))

(load "~/.emacs.d/packages/anarchy-theme.el")
(load "~/.emacs.d/packages/hydra-helm.el")
(load "~/.emacs.d/packages/commando.el")

(setq compilation-finish-functions
  (lambda (buf str)
    (if (null (string-match ".*exited abnormally.*" str))
      (progn
        (run-at-time "0.4 sec" nil
          (lambda ()
          (select-window (get-buffer-window (get-buffer-create "*compilation*")))
          (switch-to-buffer nil)))
          (message "No Compilation Errors!")))))

(defun load-directory (dir)
  "DIR: Directory to load user configuration modules."
  (let ((load-it (lambda (f)
    (load-file (concat (file-name-as-directory dir) f)))
    ))
  (mapc load-it (directory-files dir nil "\\.el$"))))

(load-directory "~/.emacs.d/modules/")

(my/theme-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-split-window-function (quote split-window-horizontally))
 '(package-selected-packages
   (quote
    (hacker-typer emojify dashboard company-auctex auctex dockerfile-mode yaml-mode js2-refactor jquery-doc highlight-indent-guides airline-themes powerline rainbow-delimiters cmake-mode clojure-mode company-php company-c-headers company-jedi company-tern company-quickhelp json-mode pos-tip popwin yasnippet-snippets tern js2-mode autopair markdown-mode flycheck-popup-tip flycheck-pycheckers flycheck php-mode magit slime-company slime company-go go-mode yara-mode actionscript-mode powershell alchemist elixir-yasnippets elixir-mode xterm-color helm-projectile projectile web-mode rust-mode neotree emmet-mode helm-swoop hydra rainbow-mode paredit ivy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))
