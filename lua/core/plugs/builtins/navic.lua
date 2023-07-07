local navic = {
  name = "navic",
  cfg = { "SmiteshP/nvim-navic" },
  def_opts = {
    icons = {
      File          = "󰈙 ",
      Module        = " ",
      Namespace     = "󰌗 ",
      Package       = " ",
      Class         = "󰌗 ",
      Method        = "󰆧 ",
      Property      = " ",
      Field         = " ",
      Constructor   = " ",
      Enum          = "󰕘",
      Interface     = "󰕘",
      Function      = "󰊕 ",
      Variable      = "󰆧 ",
      Constant      = "󰏿 ",
      String        = "󰀬 ",
      Number        = "󰎠 ",
      Boolean       = "◩ ",
      Array         = "󰅪 ",
      Object        = "󰅩 ",
      Key           = "󰌋 ",
      Null          = "󰟢 ",
      EnumMember    = " ",
      Struct        = "󰌗 ",
      Event         = " ",
      Operator      = "󰆕 ",
      TypeParameter = "󰊄 ",
    },
    lsp = {
      auto_attach = false,
      preference = nil,
    },
    highlight = false,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
    lazy_update_context = false,
    click = true
  }

}

function navic.on_attach(client, bufnr)
  require("nvim-navic").attach(client, bufnr)
end

function navic.implementation()
  return require("nvim-navic")
end

function navic.get_ctx()
  return require 'nvim-navic'.get_location()
end

return navic
