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

(unless (package-installed-p 'smartparens)
  (package-install 'smartparens))
(require 'smartparens-config)
(smartparens-global-mode 1)

(setq-default fill-column 80)

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0.1)
  :hook
  (company-tng-configure-default))

(add-hook 'after-init-hook 'global-company-mode)
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
                  ("C-c C-c c" . rustic-cargo-check))
      :config
      (setq rustic-format-on-save nil) ;; Set to t if you wish to run rustfmt on save
    (when memacs-use-lsp
      (setq rustic-lsp-client 'eglot)
      (add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1))))))

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

(when memacs-enable-lua
  (unless (package-installed-p 'lua-mode)
    (package-install 'lua-mode))
  (use-package lua-mode)

  (unless (package-installed-p 'flymake-lua)
    (package-install 'flymake-lua)
  (add-hook 'lua-mode-hook 'flymake-lua-load)))

;; --------------------------------- Common Lisp
(when memacs-enable-clisp
  (unless (package-installed-p 'slime)
    (package-install 'slime))

  (defun memacs-clisp-hook ()
    (slime-mode))

  (add-hook 'common-lisp-mode-hook 'memacs-clisp-hook)

  (setq slime-lisp-implementations
    '((sbcl ("sbcl" "--dynamic-space-size" "4gb"))))

  (setq inferior-lisp-program ""))

;; --------------------------------- Haskell
(when memacs-enable-haskell
  (unless (package-installed-p 'haskell-mode)
    (package-install 'haskell-mode)))

;; --------------------------------- Zig
(when memacs-enable-zig
  (unless (package-installed-p 'zig-mode)
    (package-install 'zig-mode)))
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
(unless (package-installed-p 'all-the-icons-dired)
  (package-install 'all-the-icons-dired))
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
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

(load "~/.emacs.d/mode_line.el")
;; --------------------------------- END SECTION -------------------------------
