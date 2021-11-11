local kb = {}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true -- use `nowait` when creating keymaps
}

local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true -- use `nowait` when creating keymaps
}

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        },
        spelling = {enabled = true, suggestions = 20} -- use which-key for spelling hints
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true -- show help message on the command line when the popup is visible
}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("Closing terminal")
  end,
})
function _lazygit_toggle()
  lazygit:toggle()
end


local mappings = {
    ["w"] = {"<cmd>w!<CR>", "Save"},
    ["q"] = {"<cmd>q!<CR>", "Quit"},
    ["/"] = {"<cmd>lua require('Comment').toggle()<CR>", "Comment"},
    ["c"] = {"<cmd>BufferClose!<CR>", "Close Buffer"},
    ["h"] = {"<cmd>nohlsearch<CR>", "No Highlight"},
    b = {
        name = "Buffers",
        j = {"<cmd>BufferPick<cr>", "Jump"},
        f = {"<cmd>Telescope buffers<cr>", "Find"},
        b = {"<cmd>b#<cr>", "Previous"},
        w = {"<cmd>BufferWipeout<cr>", "Wipeout"},
        e = {"<cmd>BufferCloseAllButCurrent<cr>", "Close all but current"},
        h = {"<cmd>BufferCloseBuffersLeft<cr>", "Close all to the left"},
        l = {"<cmd>BufferCloseBuffersRight<cr>", "Close all to the right"},
        D = {"<cmd>BufferOrderByDirectory<cr>", "Sort by directory"},
        L = {"<cmd>BufferOrderByLanguage<cr>", "Sort by language"}
    },
    p = {
        name = "Packer",
        c = {"<cmd>PackerCompile<cr>", "Compile"},
        i = {"<cmd>PackerInstall<cr>", "Install"},
        s = {"<cmd>PackerSync<cr>", "Sync"},
        S = {"<cmd>PackerStatus<cr>", "Status"},
        u = {"<cmd>PackerUpdate<cr>", "Update"}
    },
    l = {
        name = "LSP",
        a = {
            "<cmd>lua require('lspconfigs.completion_setup').code_actions()<cr>",
            "Code Action"
        },
        d = {
            "<cmd>Telescope lsp_document_diagnostics<cr>",
            "Document Diagnostics"
        },
        w = {
            "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            "Workspace Diagnostics"
        },
        f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        I = {"<cmd>LspInstallInfo<cr>", "Installer Info"},
        j = {
            "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = 'single'}})<cr>",
            "Next Diagnostic"
        },
        k = {
            "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<cr>",
            "Prev Diagnostic"
        },
        l = {"<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action"},
        p = {
            name = "Peek",
            d = {
                "<cmd>lua require('lspconfigs.peek').Peek('definition')<cr>",
                "Definition"
            },
            t = {
                "<cmd>lua require('lspconfigs.peek').Peek('typeDefinition')<cr>",
                "Type Definition"
            },
            i = {
                "<cmd>lua require('lspconfigs.peek').Peek('implementation')<cr>",
                "Implementation"
            }
        },
        q = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix"},
        r = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols"
        }
    },
	g = { '<cmd>lua _lazygit_toggle()<CR>', 'Git'	}
}

local vmappings = {
    ["/"] = {"<ESC><CMD>lua ___comment_gc(vim.fn.visualmode())<CR>", "Comment"},
    l = {
	    name = "LSP",
	    f = {
		"<ESC><cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format"
	    }
    }
}
function kb:setup()
    local wk = require 'which-key'
    wk.setup(setup)
    wk.register(mappings, opts)
    wk.register(vmappings, vopts)
end

return kb
