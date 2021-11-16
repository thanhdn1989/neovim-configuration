local setup = {}
function setup:install_language_server()
    -- LSP
    local cmp_setup = require 'lspconfigs.completion_setup'
    cmp_setup.setup()
	require'lspconfigs.language_server_setup'.setup()
	
end

function setup:setup_keybindings()
    -- Setup keybinding
    require'keybindings.default_keybindings'.setup()
    require('keybindings.whichkey_config').setup()
end

return setup
