local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
end

return require('packer').startup(function(use)
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
        'hrsh7th/cmp-cmdline', 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-vsnip',
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
    use {'joshdick/onedark.vim'}
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

    if packer_bootstrap then require('packer').sync() end
end)
