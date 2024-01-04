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
    (setq package-native-compile t)
    (native-compile-async "~/.emacs.d" 'recursively)
    (setq comp-async-report-warnings-errors nil))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; (package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(global-auto-revert-mode t)
;; --------------------------------- END SECTION -------------------------------

;; -----------------------------------------------------------------------------
;; -------------------------------- Navigation ---------------------------------
;; -----------------------------------------------------------------------------
;; Install evil mode
(when memacs-use-evil
    (unless (package-installed-p 'evil)
      (package-install 'evil))

    ;; Install evil-collection for better evil
    (unless (package-installed-p 'evil-collection)
        (package-install 'evil-collection))

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

    (use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init)))

;; --------------------------------- END SECTION -------------------------------

;; -----------------------------------------------------------------------------
;; ---------------------------------- General ----------------------------------
;; -----------------------------------------------------------------------------
;; Install ivy
(when memacs-use-ivy
    (unless (package-installed-p 'ivy)
        (package-install 'ivy))
    (ivy-mode)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t))

;; Install magit
(when memacs-use-magit
    (unless (package-installed-p 'magit)
        (package-install 'magit)))

(when memacs-enable-pomidor
  (unless (package-installed-p 'pomidor)
    (package-install 'pomidor)

    (use-package pomidor
    :bind (("<f12>" . pomidor))
    :config (setq pomidor-sound-tick nil
                    pomidor-sound-tack nil)
    :hook (pomidor-mode . (lambda ()
                            (display-line-numbers-mode -1) ; Emacs 26.1+
                            (setq left-fringe-width 0 right-fringe-width 0)
                            (setq left-margin-width 2 right-margin-width 0)
                            ;; force fringe update
                            (set-window-buffer nil (current-buffer)))))))

(unless (package-installed-p 'yasnippet)
  (package-install 'yasnippet))
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))
(yas-global-mode 1)

(unless (package-installed-p 'vterm)
  (package-install 'vterm))
(setq vterm-shell "zsh")

(when memacs-enable-elfeed
  (unless (package-installed-p 'elfeed)
    (package-install 'elfeed))

  (setq elfeed-feeds
        '()))
;; --------------------------------- END SECTION -------------------------------

;; -----------------------------------------------------------------------------
;; ------------------------------------ LSP ------------------------------------
;; -----------------------------------------------------------------------------
;; Install lsp mode
(when memacs-use-lsp
    (unless (package-installed-p 'flycheck)
      (package-install 'flycheck))

    (unless (package-installed-p 'lsp-mode)
      (package-install 'lsp-mode))

    (unless (package-installed-p 'lsp-ui)
      (package-install 'lsp-ui))

    (use-package lsp-mode
    :init
    (setq lsp-keymap-prefix "C-c C-l")
    :hook (
            (rust-mode . lsp))
    :commands lsp)

    (use-package lsp-ui
      :commands
      lsp-ui-mode)
    (setq lsp-ui-flycheck-enable t)
    (setq lsp-ui-sideline-enable t)
    (setq lsp-ui-sideline-enable t))

;; Install company mode
(unless (package-installed-p 'company)
  (package-install 'company)
  (setq company-idle-delay 0.1))

(company-tng-configure-default)
;; --------------------------------- END SECTION -------------------------------

;; -----------------------------------------------------------------------------
;; --------------------------------- Languages ---------------------------------
;; -----------------------------------------------------------------------------
;; --------------------------------- Rust
(when memacs-enable-rust
    (unless (package-installed-p 'rustic)
      (package-install 'rustic))

    (use-package rustic
      :bind (:map rustic-mode-map
                  ("C-c C-c t" . rustic-cargo-test)
                  ("C-c C-c b" . rustic-cargo-bench)
                  ("C-c C-c f" . lsp-find-definition)
                  ("C-c C-c c" . rustic-cargo-check))
      :config
      (setq rustic-format-on-save nil) ;; Set to t if you wish to run rustfmt on save
    (when memacs-use-lsp
        (setq rustic-lsp-client 'lsp-mode))))

;; --------------------------------- HTML
(when memacs-enable-html
    (unless (package-installed-p 'web-mode)
      (package-install 'web-mode))

    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

;; --------------------------------- Nix
(when memacs-enable-nix
    (unless (package-installed-p 'nix-mode)
      (package-install 'nix-mode))

    (use-package nix-mode
    :mode "\\.nix\\'"))

;; --------------------------------- GLSL
(when memacs-enable-glsl
  (unless (package-installed-p 'glsl-mode)
    (package-install 'glsl-mode))

  (use-package glsl-mode
    :mode ("\\.frag\\'" "\\.vert\\'" "\\.glsl\\'"))

  (unless (package-installed-p 'company-glsl)
    (package-install 'company-glsl))

  (use-package company-glsl
    :mode ("\\.frag\\'" "\\.vert\\'" "\\.glsl\\'")))
;; --------------------------------- END SECTION -------------------------------

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
;; --------------------------------- END SECTION -------------------------------

;; -----------------------------------------------------------------------------
;; ---------------------------------- AUCTeX -----------------------------------
;; -----------------------------------------------------------------------------
(unless (package-installed-p 'auctex)
  (package-install 'auctex))

(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(unless (package-installed-p 'pdf-tools)
  (package-install 'pdf-tools))
;; --------------------------------- END SECTION -------------------------------

;; -----------------------------------------------------------------------------
;; ------------------------------------ UI -------------------------------------
;; -----------------------------------------------------------------------------
(unless (package-installed-p 'all-the-icons)
  (package-install 'all-the-icons))
(use-package all-the-icons
  :if (display-graphic-p))

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

    (defun memacs-disable-hl-line-in-vterm ()
    (when (equal major-mode 'vterm-mode)
        (setq-local global-hl-line-mode nil)))

    (add-hook 'vterm-mode-hook 'memacs-disable-hl-line-in-vterm))

;; Blinking cursor
(blink-cursor-mode memacs-blink-cursor)

(setq ring-bell-function 'ignore)

(setq column-number-mode t)
;; --------------------------------- END SECTION -------------------------------
