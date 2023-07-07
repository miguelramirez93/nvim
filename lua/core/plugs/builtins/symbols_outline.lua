local symbolsoutline = {
  name = "symbolsoutline",
  cfg = {
    'simrat39/symbols-outline.nvim',
  },
  def_opts = {
    auto_close = true,
  },
}

function symbolsoutline.implementation()
  return require("symbols-outline")
end

function symbolsoutline.toggle()
  vim.cmd [[SymbolsOutline]]
end

return symbolsoutline
