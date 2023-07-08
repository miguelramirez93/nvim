local autopairs = {
    name = "autopairs",
    cfg = {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
    },
    def_opts = {
        disable_filetype = { "TelescopePrompt" , "vim" },
    }
}

function autopairs.implementation()
    return require('nvim-autopairs')
end

function autopairs.on_confirm_done()
    require('nvim-autopairs.completion.cmp').on_confirm_done()
end
return autopairs