require('plugins')
local st = require('setup')
st.install_language_server()
st.setup_keybindings()
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "onedark"
vim.o.swapfile = false
vim.o.scrolloff = 8
vim.o.hidden = true
