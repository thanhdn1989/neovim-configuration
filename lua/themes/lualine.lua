local T = {}

function T:setup()   
    require'lualine'.setup{
        option = {
            theme = "nightfly",
            section_separators = '', 
            component_separators = ''
        }
    }
end

return T