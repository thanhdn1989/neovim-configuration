local T = {}

local header = {
   '        ▄▄▄▄▄███████████████████▄▄▄▄▄     ',
   '      ▄██████████▀▀▀▀▀▀▀▀▀▀██████▀████▄   ',
   '     █▀████████▄             ▀▀████ ▀██▄  ',
   '    █▄▄██████████████████▄▄▄         ▄██▀ ',
   '     ▀█████████████████████████▄    ▄██▀  ',
   '       ▀████▀▀▀▀▀▀▀▀▀▀▀▀█████████▄▄██▀    ',
   '         ▀███▄              ▀██████▀      ',
   '           ▀██████▄        ▄████▀         ',
   '              ▀█████▄▄▄▄▄▄▄███▀           ',
   '                ▀████▀▀▀████▀             ',
   '                  ▀███▄███▀                ',
   '                     ▀█▀                   ',
}

local custom_section = {
    a = {
      description = { "  Find File          " },
      command = "Telescope find_files",
    },
    b = {
      description = { "  New File           " },
      command = ":ene!",
    },
    c = {
      description = { "  Recent Projects    " },
      command = "Telescope projects",
    },
    d = {
      description = { "  Recently Used Files" },
      command = "Telescope oldfiles",
    },
    e = {
      description = { "  Find Word          " },
      command = "Telescope live_grep",
    },
    f = {
      description = { "❂  Colorschemes        " },
      command = "Telescope colorscheme",
    }
  }

  local footer = { 'dnt' }

  function T:setup() 
    vim.g.dashboard_custom_header = header

    vim.g.dashboard_default_executive = 'telescope'
  
    vim.g.dashboard_custom_section = custom_section

    local text = require "interface.text"
    vim.g.dashboard_custom_footer = text.align_center({ width = 0 }, footer, 0.49)
  end

return T