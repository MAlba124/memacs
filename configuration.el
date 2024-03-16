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

(setq
 ;; Performance
 memacs-native-compilation t                   ;; Enable native compilation. This required gccemacs

 ;; UI
 memacs-font             "Iosevka Semibold-10" ;; Font to use
 memacs-scroll-margin    5                     ;; Scroll margin
 memacs-tab-width        4                     ;; Tab width
 memacs-blink-cursor     0                     ;; Wheter to enable cursor blinking or not
 memacs-hl-line          t                     ;; Highlight current line
 memacs-show-linenumbers nil                   ;; Linenumbers
 memacs-use-mm-modeline  t                     ;; Wheter to use memacs' modeline

 ;; Packages
 memacs-enable-evil      t                     ;; Vim keybindings
 memacs-enable-ivy       t                     ;; Good completion menu
 memacs-enable-magit     t                     ;; Git UI
 memacs-enable-lsp       t                     ;; LSP
 memacs-enable-pomidor   nil                   ;; Pomidor timer
 memacs-enable-elfeed    nil                   ;; RSS feed reader
 memacs-enable-yas       nil                   ;; YASnippets
 memacs-enable-vterm     t                     ;; Terminal emulator
 memacs-vterm-shell      "zsh"                 ;; What shell vterm should use

 ;; Languages
 memacs-enable-markdown  t                     ;; Markdown
 memacs-enable-rust      t                     ;; Rust
 memacs-enable-html      t                     ;; HTML
 memacs-enable-nix       t                     ;; Nix
 memacs-enable-sql       nil                   ;; SQL
 memacs-enable-glsl      nil                   ;; GLSL
 memacs-enable-lua       nil                   ;; Lua
 memacs-enable-clisp     nil                   ;; Common Lisp
 memacs-enable-haskell   nil                   ;; Haskell
 memacs-enable-zig       nil)                  ;; Zig
