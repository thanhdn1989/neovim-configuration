local T = {}

function T:setup()   
    require'lualine'.setup{
        options = {
            -- theme = "codedark",
            section_separators = '', 
            component_separators = ''
        }
    }
end

return T