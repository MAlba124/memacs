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
(setq memacs-native-compilation t) ;; Enable native compilation. This required gccemacs
(setq memacs-font               "Iosevka Semibold-10") ;; Font to use
(setq memacs-scroll-margin      5)            ;; Scroll margin
(setq memacs-tab-width          4)            ;; Tab width
(setq memacs-blink-cursor       0)
(setq memacs-hl-line            t)
(setq memacs-show-linenumbers   nil)
(setq memacs-use-evil           t)
(setq memacs-use-ivy            t)
(setq memacs-use-magit          t)
(setq memacs-use-lsp            t)
(setq memacs-enable-rust        t)
(setq memacs-enable-html        t)
(setq memacs-enable-nix         t)
(setq memacs-enable-sql         nil)
(setq memacs-enable-pomidor     nil)
(setq memacs-enable-glsl        nil)
(setq memacs-enable-elfeed      t)
(setq memacs-enable-lua         t)
(setq memacs-enable-clisp       t)
