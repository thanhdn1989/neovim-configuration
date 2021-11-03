local M = {}

function M:setup()
    local lsp_installer = require("nvim-lsp-installer")

    -- Provide settings first!
    lsp_installer.settings {
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    }

    lsp_installer.on_server_ready(function(server)
        local opts = { capabilities = capabilities }
        local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                             .protocol
                                                                             .make_client_capabilities())
        
        if server.name == "angularls" then
            --local languageServerPath = vim.fn.stdpath('data').."/lsp_servers/angularls/node_modules/@angular/language-server"
            local languageServerPath = vim.env.HOME.."/.nvm/versions/node/v16.13.0/lib/node_modules"
            local cmd = {"ngserver", "--stdio", "--tsProbeLocations", languageServerPath , "--ngProbeLocations", languageServerPath}

            server:setup{
                capabilities = capabilities,
                cmd = cmd,
                on_new_config = function(new_config, new_root_dir)
                    new_config.cmd = cmd
                end,
            }
        else
            server:setup({capabilities = capabilities})
        end
    end)
end

return M
