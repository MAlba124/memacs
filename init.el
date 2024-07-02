;; memacs, marcu5h's emacs
;; Copyright (C) 2024 marcu5h
;;
;; memacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; memacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with memacs.  If not, see <https://www.gnu.org/licenses/>.

;; -----------------------------------------------------------------------------
;; ------------------------------ Imports/setup --------------------------------
;; -----------------------------------------------------------------------------
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq gc-cons-threshold most-positive-fixnum)


(module-load (concat (getenv "HOME") "/.emacs.d/luamacs/luamacs.so"))

(defun memacs-set-eglot-key-maps ()
   (define-key eglot-mode-map (kbd "C-c C-l a") 'eglot-code-actions)
   (define-key eglot-mode-map (kbd "C-c C-l d") 'xref-find-definitions)
   (define-key eglot-mode-map (kbd "C-c C-l f") 'xref-find-references)
   (define-key eglot-mode-map (kbd "C-c C-l r") 'eglot-rename))

(defun memacs-add-rustic-eglot-hook ()
  (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1))))

(defun memacs-vterm-hook ()
    (when (equal major-mode 'vterm-mode)
    (setq-local global-hl-line-mode nil)
    (setq-local show-trailing-whitespace nil)))

(defun memacs-fix-vterm-hl-line ()
    (add-hook 'vterm-mode-hook 'memacs-vterm-hook))

(let ((state (luamacs-state-init)))
  (luamacs-exec-str state (with-temp-buffer (insert-file-contents "~/.emacs.d/init.lua") (buffer-string))))

(setq package-install-upgrade-built-in t)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-always-ensure t)

(setq-default fill-column 80)

(use-package all-the-icons
  :if (display-graphic-p))
(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))

(setq-default indent-tabs-mode nil)

(add-to-list 'default-frame-alist
             `(font . ,memacs-font))

(setq-default show-trailing-whitespace t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))
