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

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq gc-cons-threshold most-positive-fixnum)

(module-load (concat (getenv "HOME") "/.emacs.d/luamacs/luamacs.so"))

(defun memacs-set-eglot-key-maps ()
  (define-key eglot-mode-map (kbd "C-c C-l a") 'eglot-code-actions)
  (define-key eglot-mode-map (kbd "C-c C-l d") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "C-c C-l f") 'xref-find-references)
  (define-key eglot-mode-map (kbd "C-c C-l r") 'eglot-rename))

(setq luamacs-state (luamacs-state-init))
(luamacs-exec-str luamacs-state (with-temp-buffer (insert-file-contents "~/.emacs.d/init.lua") (buffer-string)))
