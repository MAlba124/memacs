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

(setq gc-cons-threshold most-positive-fixnum)

(load "~/.emacs.d/configuration.el")

(when memacs-native-compilation
  (setq package-native-compile t))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(setq package-install-upgrade-built-in t)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-always-ensure t)
;; -----------------------------------------------------------------------------
;; -------------------------------- Navigation ---------------------------------
;; -----------------------------------------------------------------------------
;; Install evil mode
(when memacs-enable-evil
    ;; Init evil
    (use-package evil
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
    :config
    (evil-collection-init)))

;; -----------------------------------------------------------------------------
;; ---------------------------------- General ----------------------------------
;; -----------------------------------------------------------------------------
;; Install ivy
(when memacs-enable-ivy
    (unless (package-installed-p 'ivy)
        (package-install 'ivy))
    (use-package ivy
      :config
      (setq ivy-use-virtual-buffers t)
      (setq enable-recursive-minibuffers t)
      (ivy-mode)))

;; Install magit
(when memacs-enable-magit
  (use-package magit))

(when memacs-enable-pomidor
    (use-package pomidor
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
    :config
    (setq vterm-shell memacs-vterm-shell)))

(when memacs-enable-elfeed
  (use-package elfeed
    :config
    (setq elfeed-feeds
      '())))

(use-package smartparens
  :config
  (smartparens-global-mode 1))

(setq-default fill-column 80)

(use-package company
  :init
  (setq company-idle-delay 0.1)
  :hook
  (company-tng-configure-default))

(add-hook 'after-init-hook 'global-company-mode)

(when memacs-enable-lsp
  (require 'eglot)
  (define-key eglot-mode-map (kbd "C-c C-l a") 'eglot-code-actions)
  (define-key eglot-mode-map (kbd "C-c C-l d") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "C-c C-l f") 'xref-find-references)
  (define-key eglot-mode-map (kbd "C-c C-l r") 'eglot-rename))

(when memacs-enable-git-gutter
  (use-package git-gutter
    :config
    (global-git-gutter-mode t)))

;; -----------------------------------------------------------------------------
;; --------------------------------- Languages ---------------------------------
;; -----------------------------------------------------------------------------
;; --------------------------------- Rust
(when memacs-enable-rust
    (use-package rustic
      :bind (:map rustic-mode-map
                  ("C-c C-c t" . rustic-cargo-test)
                  ("C-c C-c b" . rustic-cargo-bench)
                  ("C-c C-c c" . rustic-cargo-check))
      :config
      (setq rustic-format-on-save nil) ;; Set to t if you wish to run rustfmt on save
      (when memacs-enable-lsp
        (setq rustic-lsp-client 'eglot)
        (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1))))))

;; --------------------------------- HTML
(when memacs-enable-html
    (use-package web-mode
      :init
      (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))))

;; --------------------------------- Nix
(when memacs-enable-nix
    (use-package nix-mode
      :mode "\\.nix\\'"))

;; --------------------------------- GLSL
(when memacs-enable-glsl
  (use-package glsl-mode
    :mode ("\\.frag\\'" "\\.vert\\'" "\\.glsl\\'"))

  (use-package company-glsl
    :mode ("\\.frag\\'" "\\.vert\\'" "\\.glsl\\'")))

(when memacs-enable-lua
  (use-package lua-mode)

  (use-package flymake-lua
    :hook
    (lua-mode . flymake-lua-load)))

;; --------------------------------- Common Lisp
(when memacs-enable-clisp
  (use-package slime
    :init
    (setq slime-lisp-implementations
      '((sbcl ("sbcl" "--dynamic-space-size" "4gb"))))
    (setq inferior-lisp-program "")
    :hook
    (common-lisp-mode . slime-mode)))

;; --------------------------------- Haskell
(when memacs-enable-haskell
  (use-package haskell-mode))

;; --------------------------------- Zig
(when memacs-enable-zig
  (use-package zig-mode))

;; --------------------------------- Markdown
(when memacs-enable-markdown
  (use-package markdown-mode))

;; --------------------------------- C
(when memacs-enable-c
  (setq-default c-basic-offset 4))
  ;; (when memacs-enable-lsp
  ;;   (add-to-list 'eglot-server-programs '((c-mode) "clangd"))
  ;;   (add-hook 'c-mode-hook 'eglot-ensure)))

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
  :init
  (setq TeX-PDF-mode t)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil))

(use-package pdf-tools)

;; -----------------------------------------------------------------------------
;; ------------------------------------ UI -------------------------------------
;; -----------------------------------------------------------------------------
(use-package all-the-icons
  :if (display-graphic-p))
(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))

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

(when memacs-use-mm-modeline
    (load "~/.emacs.d/mode_line.el"))

(setq inhibit-startup-screen t)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))
