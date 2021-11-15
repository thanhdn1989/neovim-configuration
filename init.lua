require('plugins')
local st = require('setup')
st.install_language_server()
st.setup_keybindings()
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.tokyonight_style = "night"
vim.o.swapfile = false
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.hidden = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.cmd([[
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})
augroup END
]])
