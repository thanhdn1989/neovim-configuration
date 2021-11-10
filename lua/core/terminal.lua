local T = {}

function T:setup()
    require("toggleterm").setup{
        size = 20 ,
        shade_terminals = true,
        open_mapping = [[<c-\>]],
        direction = 'float' 
    }
end

return T