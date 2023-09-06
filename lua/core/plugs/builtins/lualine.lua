local lualine = {
    name = "lualine",
    cfg = {
        'nvim-lualine/lualine.nvim',
        'arkav/lualine-lsp-progress',
    },
    def_opts = {
        sections = {
            lualine_c = {
                'lsp_progress'
            }
        }
    },
}

function lualine.implementation()
    return require('lualine')
end

return lualine