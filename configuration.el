;; This file is a part of memacs
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

;; Some basic settings you can change

;; Performance
(setq memacs-native-compilation t)                   ;; Enable native compilation. This required gccemacs

;; UI
(setq memacs-font             "Iosevka Semibold-10") ;; Font to use
(setq memacs-scroll-margin    5)                     ;; Scroll margin
(setq memacs-tab-width        4)                     ;; Tab width
(setq memacs-blink-cursor     0)                     ;; Wheter to enable cursor blinking or not
(setq memacs-hl-line          t)                     ;; Highlight current line
(setq memacs-show-linenumbers nil)                   ;; Linenumbers
(setq memacs-use-mm-modeline  t)                     ;; Wheter to use memacs' modeline

;; Packages
(setq memacs-use-evil         t)                     ;; Vim keybindings
(setq memacs-use-ivy          t)                     ;; Good completion menu
(setq memacs-use-magit        t)                     ;; Git UI
(setq memacs-use-lsp          t)                     ;; LSP
(setq memacs-enable-pomidor   nil)                   ;; Pomidor timer
(setq memacs-enable-elfeed    nil)                   ;; RSS feed reader
(setq memacs-enable-yas       nil)                   ;; YASnippets
(setq memacs-enable-vterm     t)                     ;; Terminal emulator
(setq memacs-vterm-shell      "zsh")                 ;; What shell vterm should use

;; Languages
(setq memacs-enable-markdown  t)                     ;; Markdown
(setq memacs-enable-rust      t)                     ;; Rust
(setq memacs-enable-html      t)                     ;; HTML
(setq memacs-enable-nix       t)                     ;; Nix
(setq memacs-enable-sql       nil)                   ;; SQL
(setq memacs-enable-glsl      nil)                   ;; GLSL
(setq memacs-enable-lua       nil)                   ;; Lua
(setq memacs-enable-clisp     nil)                   ;; Common Lisp
(setq memacs-enable-haskell   nil)                   ;; Haskell
(setq memacs-enable-zig       nil)                   ;; Zig
