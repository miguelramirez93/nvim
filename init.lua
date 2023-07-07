local pvim = require "api.pvim"
local user_configs = require "user.configs"
local user_langservs = require "user.ls"

pvim.set_options(user_configs.options)
pvim.setup({
    lsp = {
        lang_servers = user_langservs,
    },
    plugs = {
        specs = user_configs.plugin_specs,
    },
})
pvim.set_colorscheme(user_configs.colorscheme)
user_configs.setup_keymap(pvim)
