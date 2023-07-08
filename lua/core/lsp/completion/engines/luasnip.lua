local luasnip = {
    name = "luasnip",
    cfg = {
        { 'saadparwaiz1/cmp_luasnip' },
        { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" },},
    }
}

function luasnip.preload()
    require("luasnip.loaders.from_vscode").lazy_load()
end

function luasnip.expand(args)
    require("luasnip").lsp_expand(args.body)
end

function luasnip.visible()
    return require("luasnip").expand_or_jumpable()
end

function luasnip.select_next_item()
    require("luasnip").expand_or_jump()
end

function luasnip.prev_item_selectable()
    return require("luasnip").jumpable(-1)
end

function luasnip.select_prev_item()
    require("luasnip").jump(-1)
end

return luasnip