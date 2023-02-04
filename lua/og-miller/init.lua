require('og-miller.lspconfig')
require('og-miller.auto-complete2')
require('og-miller.github-theme')
require('og-miller.lualine')
require('og-miller.dev-icons')
require('og-miller.indent-blankline')
require('og-miller.treesitter')
require('og-miller.treesitter-context')
require('og-miller.harpoon')


-- --
-- -- Example config in Lua
-- require("github-theme").setup({
--   theme_style = "dark",
--   function_style = "italic",
--   sidebars = {"qf", "vista_kind", "terminal", "packer"},
-- 
--   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--   colors = {hint = "orange", error = "#ff0000"},
-- 
--   -- Overwrite the highlight groups
--   overrides = function(c)
--     return {
--       htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
--       DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
--       -- this will remove the highlight groups
--       TSField = {},
--     }
--   end
-- })
