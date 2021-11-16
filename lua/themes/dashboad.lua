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

    -- require("core.autocmds").define_augroups {
    --   _dashboard = {
    --     -- seems to be nobuflisted that makes my stuff disappear will do more testing
    --     {
    --       "FileType",
    --       "dashboard",
    --       "setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= ",
    --     },
    --     {
    --       "FileType",
    --       "dashboard",
    --       "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=" .. vim.opt.showtabline._value,
    --     },
    --     { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
    --   },
    -- }
  end

return T