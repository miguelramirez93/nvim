local luasnip = {
    name = "",
}

function luasnip.expand(args)
    local status_ok, engine = pcall(require, "luasnip")
    if not status_ok then return end
    engine.lsp_expand(args.body)
end


return luasnip