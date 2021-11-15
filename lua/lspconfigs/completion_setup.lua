local cmp_setup = {}

function cmp_setup:code_actions()
    local opts = {
        winblend = 15,
        layout_config = {prompt_position = "top", width = 80, height = 12},
        borderchars = {
            prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
            results = {"─", "│", "─", "│", "├", "┤", "╯", "╰"},
            preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}
        },
        border = {},
        previewer = false,
        shorten_path = false
    }
    local builtin = require "telescope.builtin"
    local themes = require "telescope.themes"
    builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function cmp_setup:setup()

    -- Setup nvim-cmp.
    local cmp = require 'cmp'
    local lspkind = require('lspkind')
    cmp.setup({
        confirm_opts = {behavior = cmp.ConfirmBehavior.Replace, select = false},
        completion = {
            ---@usage The minimum length of a word to complete on.
            keyword_length = 1
        },
        experimental = {ghost_text = true, native_menu = false},
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            end
        },
        documentation = {
            border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}
        },
        formatting = {
            format = lspkind.cmp_format()
        },
        mapping = {
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            -- TODO: potentially fix emmet nonsense
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, {"i", "s"}),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, {"i", "s"}),

            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({select = true})
        },
        sources = cmp.config.sources({
            {name = 'nvim_lsp'}, {name = 'vsnip'} -- For vsnip users.
        }, {{name = 'buffer'}})
    })

    -- Use buffer source for `/`.
    cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

    -- Use cmdline & path source for ':'.
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
    })
end

return cmp_setup
