-- TODO: add colors and theme variables based on 'theme_name'
-- or maybe entire new setup() function for dark/light theme
local theme_name = vim.g.colors_name  -- Fetch the current theme name dynamically

local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
  background = '#b2b2b2',
  foreground = '#3a3a3a',
}

local github_gm_light = {
  normal = {
    a = { fg = colors.white, bg = colors.grey},
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white},
  },

  insert = { a = { fg = colors.white, bg = colors.grey} },
  visual = { a = { fg = colors.white, bg = colors.grey} },
  replace = { a = { fg = colors.white, bg = colors.grey} },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.grey},
  },
}


require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = github_gm_light,
       -- theme ='onedark',
        component_separators = { left = ' ', right = ' '},
        section_separators = { left = ' ', right = ' '},
        disabled_filetypes = {
          statusline = {},
          winbar = {{}},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'} ,
        --lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_b = {'branch', 'diagnostics'},
        lualine_c = { {
            'filename',
            color = function()
              if theme_name == 'github_gm_light' then
                return { fg = colors.foreground, bg = colors.background }
              else
                return { fg = 'orange' }
              end
            end,
            section = {2, -1},      -- Move these inside the 'filename' table
            file_status = true,     
            newfile_status = false,
            path = 1,
            shorting_target = 0,
            symbols = {
              modified = '[+]',
              readonly = '[-]',
              unnamed = '[No Name]',
              newfile = '[New]',
            }
          }
        },

        --lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_x = {},
        --lualine_y = {'progress'},
        --lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {}, -- lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {
        lualine_c = { 
          {
            'filename', 
            path = 0, -- 0: Just the filename, 1: Relative path, 2: Absolute path
            color = { fg = colors.foreground, bg = colors.background } -- Active window bar colors
          }
        },
      },
      inactive_winbar = {
        lualine_c = { 
          {
            'filename', 
            path = 0, -- 0: Just the filename, 1: Relative path, 2: Absolute path
            color = { fg = colors.foreground, bg = colors.background } -- Active window bar colors
          }
        },
      },
      extensions = {}
    }
