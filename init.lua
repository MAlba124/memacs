-- Copyright (C) 2024 marcu5h
--
-- memacs is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- memacs is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with memacs.  If not, see <https://www.gnu.org/licenses/>.

package.path = os.getenv("HOME") .. "/.emacs.d/emacs/?.lua;" .. package.path

local em = require("emacs")
local ui = require("ui")
local pakage = require("pakage")

local config = {
   font = "Iosevka Semibold-10",
   native_compilation = true,
   evil = true,
   ivy = true,
   magit = true,
   vterm = {
      use = true,
      shell = "zsh"
   },
   smartparens = true,
   company = true,
   lsp = true,
   git_gutter = true,
   pdf_tools = true,
   all_the_icons = true,
   hl_line = true,
   custom_modeline = true,
   scroll_margin = 5,
   tab_width = 4,
   show_line_numbers = false,
   languages = {
      rust = true,
      html = true,
      nix = true,
      lua = true;
      markdown = true
   }
}

pakage.add_pkg_archive({ name = "melpa", url = "https://melpa.org/packages" })
em.set(em.intern("package-install-upgrade-built-in"), true)
if config["native_compilation"] then
   pakage.enable_native_compilation()
end
pakage.init()

if config["evil"] then
   em.set(em.intern("evil-want-integration"), true)
   em.set(em.intern("evil-want-keybinding"), nil)
   em.set(em.intern("evil-want-C-u-scroll"), true)
   em.set(em.intern("evil-want-C-d-scroll"), true)
   em.set(em.intern("evil-undo-system"), em.intern("undo-redo"))

   pakage.install_if_not_installed(em.intern("evil"))
   functioncall(emacs_environment, "evil-mode", 1, {1})

   pakage.install_if_not_installed(em.intern("evil-collection"))
   functioncall(emacs_environment, "evil-collection-init", 0, {})
end

if config["ivy"] then
   pakage.install_if_not_installed(em.intern("ivy"))
   em.set(em.intern("ivy-use-virtual-buffers"), true)
   em.set(em.intern("nable-recursive-minibuffers"), true)
   functioncall(emacs_environment, "ivy-mode", 0, {})
end

if config["magit"] then
   pakage.install_if_not_installed(em.intern("ivy"))
end

if config["vterm"]["use"] then
   pakage.install_if_not_installed(em.intern("vterm"))
   em.set(em.intern("vterm-shell"), config["vterm"]["shell"])
end

if config["smartparens"] then
   pakage.install_if_not_installed(em.intern("smartparens"))
   functioncall(emacs_environment, "smartparens-global-mode", 1, {1})
end

if config["company"] then
   em.set(em.intern("company-idle-delay"), 0.1)
   pakage.install_if_not_installed(em.intern("company"))
   functioncall(emacs_environment, "company-tng-mode", 0, {})
   functioncall(
      emacs_environment,
      "add-hook",
      2,
      {em.intern("after-init-hook"), em.intern("global-company-mode")}
   )
end

if config["lsp"] then
   em.require(em.intern("eglot"))
   functioncall(emacs_environment, "memacs-set-eglot-key-maps", 0, {})
end

if config["git_gutter"] then
   pakage.install_if_not_installed(em.intern("git-gutter"))
   functioncall(emacs_environment, "global-git-gutter-mode", 1, {true})
end

if config["pdf_tools"] then
   pakage.install_if_not_installed(em.intern("pdf-tools"))
end

if config["all_the_icons"] then
   pakage.install_if_not_installed(em.intern("all-the-icons"))
   pakage.install_if_not_installed(em.intern("all-the-icons-dired"))
   functioncall(emacs_environment, "memacs-dired-icons-dired-hook", 0, {})
end

if config["languages"]["rust"] then
   pakage.install_if_not_installed(em.intern("rustic"))
   em.set(em.intern("rustic-format-on-save"), nil)
   if config["lsp"] then
      em.set(em.intern("rustic-lsp-client"), em.intern("eglot"))
      functioncall(emacs_environment, "memacs-add-rustic-eglot-hook", 0, {})
   end
end

if config["languages"]["html"] then
   pakage.install_if_not_installed(em.intern("web-mode"))
   -- TODO
   -- em.add_to_list(
   --    em.intern("auto-mode-alist"),
   --    em.cons("\\.html?\\'", em.intern("web-mode"))
   -- )
end

if config["languages"]["nix"] then
   pakage.install_if_not_installed(em.intern("nix-mode"))
   -- TODO
   -- em.add_to_list(
   --    em.intern("auto-mode-alist"),
   --    em.cons("\\.nix\\'", em.intern("nix-mode"))
   -- )
end

if config["languages"]["lua"] then
   pakage.install_if_not_installed(em.intern("lua-mode"))
end

if config["languages"]["markdown"] then
   pakage.install_if_not_installed(em.intern("markdown-mode"))
end

ui.menu_bar_mode(em.Mode.DISABLE)
ui.scroll_bar_mode(em.Mode.DISABLE)
ui.tool_bar_mode(em.Mode.DISABLE)

em.set(em.intern("make-backup-files"), nil)

ui.require_theme(em.intern("modus-themes"))
ui.load_theme(em.intern("modus-operandi"))
ui.blink_cursor_mode(em.Mode.DISABLE)

if config["hl_line"] then
   em.require(em.intern("hl-line"))
   functioncall(emacs_environment, "global-hl-line-mode", 1, {true})
   functioncall(emacs_environment, "memacs-fix-vterm-hl-line", 0, {})
end

em.set(em.intern("ring-bell-function"), em.intern("ignore"))

if config["custom_modeline"] then
   em.load("~/.emacs.d/mode_line.el")
end

em.set(em.intern("inhibit-startup-screen"), true)
functioncall(emacs_environment, "global-auto-revert-mode", 1, {true})
em.set(em.intern("column-number-mde"), true)
em.set(em.intern("make-backup-files"), nil)
em.set(em.intern("scroll-margin"), config["scroll_margin"])
em.set(em.intern("tab-width"), config["tab_width"])
em.set(em.intern("dsplay-line-numbers-type"), config["show_line_numbers"])

em.set(em.intern("memacs-font"), config["font"])
