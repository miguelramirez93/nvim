local vsnip = {
    name = "vsnip",
    cfg = {
        { 'hrsh7th/cmp-vsnip'},
        { 'hrsh7th/vim-vsnip'},
    }
}

function vsnip.expand()
    local status_ok, _ = pcall(require, "vsnip")
    if not status_ok then return end
    vim.fn["vsnip#anonymous"](args.body)
end

return vsnip