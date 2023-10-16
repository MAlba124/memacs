;; memacs, marcu5h's emacs
;; Copyright (C) 2023  marcu5h

;; memacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; memacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with memacs.  If not, see <https://www.gnu.org/licenses/>.
;;
;; marcu5h's emacs
;; Key chords:
;;      C-x C-f         Find file
;;      C-x g           Open magit

;; Some basic settings you can change
(setq memacs-font "Iosevka Semibold-10") ;; Font to use
(setq memacs-scroll-margin 5)            ;; Scroll margin
(setq memacs-tab-width 4)                ;; Tab width

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Install evil mode
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Install evil-collection for better evil
(unless (package-installed-p 'evil-collection)
  (package-install 'evil-collection))

;; Install ivy
(unless (package-installed-p 'ivy)
  (package-install 'ivy))

;; Install magit
(unless (package-installed-p 'magit)
  (package-install 'magit))

;; Install lsp mode
(unless (package-installed-p 'lsp-mode)
  (package-install 'lsp-mode))

;; Install company mode
(unless (package-installed-p 'company)
  (package-install 'company))

;; Install rustic for Rust programming
(unless (package-installed-p 'rustic)
  (package-install 'rustic))

;; Init evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-d-scroll t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package evil-collection)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Remove UI bloat
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(setq scroll-margin memacs-scroll-margin)

;; Set `nil` to `t` if you want line numbers
(setq display-line-numbers-type nil)

(setq-default tab-width memacs-tab-width)
(setq-default indent-tabs-mode nil)

;; Disable emacs littering projects with backups
(setq make-backup-files nil)

(require-theme 'modus-themes)
(load-theme 'modus-operandi)

(add-to-list 'default-frame-alist
             `(font . ,memacs-font))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (rust-mode . lsp)
         )
  :commands lsp)

(use-package rustic)
