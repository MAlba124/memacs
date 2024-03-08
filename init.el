;; memacs, marcu5h's emacs
;; Copyright (C) 2023 marcu5h
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

(unless (package-installed-p 'gcmh)
    (package-install 'gcmh))
(gcmh-mode 1)

(load "~/.emacs.d/configuration.el")

(when memacs-native-compilation
  (setq package-native-compile t))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; -----------------------------------------------------------------------------
;; -------------------------------- Navigation ---------------------------------
;; -----------------------------------------------------------------------------
;; Install evil mode
(when memacs-use-evil
    ;; Init evil
    (use-package evil
    :ensure t
    :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-want-C-u-scroll t)
    (setq evil-want-C-d-scroll t)
    (setq evil-undo-system 'undo-redo)
    :config
    (evil-mode 1))

    ;; Install evil-collection for better evil
    (use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init)))

;; -----------------------------------------------------------------------------
;; ---------------------------------- General ----------------------------------
;; -----------------------------------------------------------------------------
;; Install ivy
(when memacs-use-ivy
    (unless (package-installed-p 'ivy)
        (package-install 'ivy))
    (use-package ivy
      :ensure t
      :config
      (setq ivy-use-virtual-buffers t)
      (setq enable-recursive-minibuffers t)
      (ivy-mode)))

;; Install magit
(when memacs-use-magit
  (use-package magit
    :ensure t))

(when memacs-enable-pomidor
    (use-package pomidor
      :ensure t
        :bind (("<f12>" . pomidor))
        :config (setq pomidor-sound-tick nil
                        pomidor-sound-tack nil)
        :hook (pomidor-mode . (lambda ()
                              (display-line-numbers-mode -1) ; Emacs 26.1+
                              (setq left-fringe-width 0 right-fringe-width 0)
                               (setq left-margin-width 2 right-margin-width 0)
                               ;; force fringe update
                               (set-window-buffer nil (current-buffer))))))

(when memacs-enable-yas
    (use-package yasnippet
      :init
      (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
      :config
      (yas-global-mode 1)))

(when memacs-enable-vterm
    (use-package vterm
    :ensure t
    :config
    (setq vterm-shell "zsh")))

(when memacs-enable-elfeed
  (use-package elfeed
    :ensure t
    :config
    (setq elfeed-feeds
      '())))

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode 1))

;; (require 'smartparens-config)

(setq-default fill-column 80)

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0.1)
  :hook
  (company-tng-configure-default))

(add-hook 'after-init-hook 'global-company-mode)

;; -----------------------------------------------------------------------------
;; --------------------------------- Languages ---------------------------------
;; -----------------------------------------------------------------------------
;; --------------------------------- Rust
(when memacs-enable-rust
    (use-package rustic
      :ensure t
      :bind (:map rustic-mode-map
                  ("C-c C-c t" . rustic-cargo-test)
                  ("C-c C-c b" . rustic-cargo-bench)
                  ("C-c C-c c" . rustic-cargo-check))
      :config
      (setq rustic-format-on-save nil) ;; Set to t if you wish to run rustfmt on save
      (when memacs-use-lsp
        (setq rustic-lsp-client 'eglot)
        (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1))))))

;; --------------------------------- HTML
(when memacs-enable-html
    (use-package web-mode
      :ensure t
      :init
      (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))))

;; --------------------------------- Nix
(when memacs-enable-nix
    (use-package nix-mode
      :ensure t
      :mode "\\.nix\\'"))

;; --------------------------------- GLSL
(when memacs-enable-glsl
  (use-package glsl-mode
    :ensure t
    :mode ("\\.frag\\'" "\\.vert\\'" "\\.glsl\\'"))

  (use-package company-glsl
    :ensure t
    :mode ("\\.frag\\'" "\\.vert\\'" "\\.glsl\\'")))

(when memacs-enable-lua
  (use-package lua-mode
    :ensure t)

  (use-package flymake-lua
    :ensure t
    :hook
    (lua-mode . flymake-lua-load)))

;; --------------------------------- Common Lisp
(when memacs-enable-clisp
  (use-package slime
    :ensure t
    :init
    (setq slime-lisp-implementations
      '((sbcl ("sbcl" "--dynamic-space-size" "4gb"))))
    (setq inferior-lisp-program "")
    :hook
    (common-lisp-mode . slime-mode)))

;; --------------------------------- Haskell
(when memacs-enable-haskell
  (use-package haskell-mode
    :ensure t))

;; --------------------------------- Zig
(when memacs-enable-zig
  (use-package zig-mode
    :ensure t))

;; --------------------------------- Markdown
(when memacs-enable-markdown
  (use-package markdown-mode
    :ensure t))

;; -----------------------------------------------------------------------------
;; -------------------------------- Autoinsert ---------------------------------
;; -----------------------------------------------------------------------------
(eval-after-load 'autoinsert
  '(define-auto-insert
     '("shell.nix" . "nix shell skeleton")
     '("Short description: "
       "{ pkgs ? import <nixpkgs> {} }:\n\n"
       "with pkgs;\n\n"
        "mkShell rec {\n"
        "  nativeBuildInputs = [];\n"
        "  buildInputs = [];\n\n"
        "  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;\n"
        "}\n")))
;; (auto-insert-mode)

;; -----------------------------------------------------------------------------
;; ---------------------------------- AUCTeX -----------------------------------
;; -----------------------------------------------------------------------------
(use-package auctex
  :ensure t
  :init
  (setq TeX-PDF-mode t)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil))

(use-package pdf-tools
  :ensure t)

;; -----------------------------------------------------------------------------
;; ------------------------------------ UI -------------------------------------
;; -----------------------------------------------------------------------------
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))
(use-package all-the-icons-dired
  :ensure t
  :hook
  (dired-mode . all-the-icons-dired-mode))
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; Remove UI bloat
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq scroll-margin memacs-scroll-margin)

(setq display-line-numbers-type memacs-show-linenumbers)

(setq-default tab-width memacs-tab-width)
(setq-default indent-tabs-mode nil)

;; Disable emacs littering projects with backups
(setq make-backup-files nil)

(require-theme 'modus-themes)
(load-theme 'modus-operandi)

(add-to-list 'default-frame-alist
             `(font . ,memacs-font))

(when memacs-hl-line
    (require 'hl-line)
    (global-hl-line-mode t)

    (defun memacs-vterm-hook ()
    (when (equal major-mode 'vterm-mode)
      (setq-local global-hl-line-mode nil)
      (setq-local show-trailing-whitespace nil)))

    (add-hook 'vterm-mode-hook 'memacs-vterm-hook))

;; Blinking cursor
(blink-cursor-mode memacs-blink-cursor)

(setq ring-bell-function 'ignore)

(setq column-number-mode t)

(setq-default show-trailing-whitespace t)

(global-auto-revert-mode t)

(load "~/.emacs.d/mode_line.el")
