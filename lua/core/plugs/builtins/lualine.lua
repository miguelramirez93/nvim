local lualine = {
    name = "lualine",
    cfg = {
        'nvim-lualine/lualine.nvim',
    },
    def_opts = {},
}

function lualine.implementation()
    return require('lualine')
end

return lualine