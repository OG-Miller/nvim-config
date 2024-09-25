-- Example config in Lua
-- require("github-theme").setup({
--   keyword_style = "NONE",
--   function_style = "NONE",
--   variable_style = "NONE",
--   theme_style = "dimmed",
--   dark_sidebar= "false",
--   function_style = "NONE",
--   sidebars = {"qf", "vista_kind", "terminal", "packer"},
-- 
--   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--   colors = {hint = "orange", error = "#ff0000"},
-- 
--   -- Overwrite the highlight groups
--   overrides = function(c)
--     return {
--      -- htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
--       DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
--       -- this will remove the highlight groups
--       TSField = {},
--       TSTitle = { fg = "orange", style = "bold" }
--     }
--   end
-- })

-- Example config in Lua
require('github-theme').setup({
  options = {
    transparent = false,
    hide_end_of_buffer = true,
    hide_nc_statusline = true,
    styles = {
      comments = 'NONE',
      functions = 'NONE',
      keywords = 'NONE',
      variables = 'NONE',
    },
    darken = {
      floats = true,
      sidebars = {
        enable = false,
        list = { 'qf', 'vista_kind', 'terminal', 'packer' },
      },
    },
  },

  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = { hint = 'orange', error = '#ff0000' },

  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      htmlTag = { fg = c.red, bg = '#282c34', sp = c.hint, style = 'underline' },
      DiagnosticHint = { link = 'LspDiagnosticsDefaultHint' },
      -- this will remove the highlight groups
      TSField = {},
    }
  end,
})

vim.cmd('colorscheme github_gm_light')
