local pvim           = require "api.pvim"
local nvimtree       = require "core.plugs.builtins.nvimtree"
local user_configs   = require "user.configs"
local user_langservs = require "user.ls"

nvimtree.opts        = {
  view = {
    side = "right",
  }
}

pvim.set_options(user_configs.options)
pvim.setup({
  lsp = {
    lang_servers = user_langservs,
  },
  plugs = {
    specs = user_configs.plugin_specs,
  },
  explorer_cli = nvimtree,
  tabs_cli = false,
})
pvim.set_colorscheme(user_configs.colorscheme)
user_configs.setup_keymap(pvim)
