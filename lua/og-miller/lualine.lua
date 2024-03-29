require('lualine').setup {
      options = {
        icons_enabled = false,
        theme ='github_dimmed',
       -- theme ='onedark',
        component_separators = { left = ' ', right = ' '},
        section_separators = { left = ' ', right = ' '},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
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
        lualine_c = {
          {
        'filename',
        color={fg='orange'},
        section = {2, -1},
        file_status = true,     
        newfile_status = false,
        path = 1,             
        shorting_target = 0,    
        symbols = {
          modified = '[+]',    
          readonly = '[-]',   
          unnamed = '[No Name]',
          newfile = '[New]',    
        },
      },
      },
        --lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_x = {},
        --lualine_y = {'progress'},
        --lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
       -- lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
