local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
end
local packer = require'packer'
packer.init({
git = {
    cmd = 'git', -- The base command for git operations
    subcommands = { -- Format strings for git subcommands
      update         = 'pull --ff-only --progress --rebase=false',
      install        = 'clone --depth %i --no-single-branch --progress',
      fetch          = 'fetch --depth 999999 --progress',
      checkout       = 'checkout %s --',
      update_branch  = 'merge --ff-only @{u}',
      current_branch = 'branch --show-current',
      diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
      diff_fmt       = '%%h %%s (%%cr)',
      get_rev        = 'rev-parse --short HEAD',
      get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
      submodules     = 'submodule update --init --recursive --progress'
    },
    depth = 1, -- Git clone depth
    clone_timeout = 600, -- Timeout, in seconds, for git clones
    default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
  }
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return packer.startup(function(use)
    use "wbthomason/packer.nvim"
    use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'}

    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}

    -- projects
    use {
        "ahmedkhalf/project.nvim",
        config = function() require'themes.project'.setup() end
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        config = function()
            require'telescope'.setup {
                defaults = {file_ignore_patterns = {"node_modules"}}
            }

            require'telescope'.load_extension('projects')
        end
    }

    -- Completion
    use {
        'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline', 'hrsh7th/nvim-cmp', 
	'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip'
    }

    -- Prettier
    use {'prettier/vim-prettier', run = 'npm install'}

    -- Comment
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }

    use 'folke/which-key.nvim'

    use {'altercation/vim-colors-solarized'}
    use {'joshdick/onedark.vim', config = function() vim.cmd('colorscheme onedark') end }
    use 'folke/tokyonight.nvim'
    use {"kyazdani42/nvim-web-devicons"}

    use {
        -- "hoob3rt/lualine.nvim",
        "nvim-lualine/lualine.nvim",
        config = function() require'lualine'.setup() end
    }

    use {"romgrk/barbar.nvim"}

    -- Dashboard
    use {
        "ChristianChiarulli/dashboard-nvim",
        config = function() require'themes.dashboad'.setup() end
    }

    -- Tree
    use { 'ms-jpq/chadtree', disable = true }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'nvim-tree'.setup {
            auto_close = true,
            update_focused_file = {
                enable = true
              }
        } end,
        disable = false
    }

    use {
        "akinsho/toggleterm.nvim",
        config = function()
          require("core.terminal").setup()
        end
      }

	use { 'nvim-treesitter/nvim-treesitter' }

	use { 'windwp/nvim-autopairs', config = function() require'nvim-autopairs'.setup() end }

	use { 'ggandor/lightspeed.nvim' }

	use { 'kosayoda/nvim-lightbulb', config = function() vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]] end }

    if packer_bootstrap then require('packer').sync() end
end)
