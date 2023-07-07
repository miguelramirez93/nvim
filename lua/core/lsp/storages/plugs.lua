local lspconfig = require "core.plugs.builtins.lspconfig"
local mem_storage = require "shared.storages.mem"
local cmp         = require "core.plugs.builtins.cmp"
local treesitter  = require "core.plugs.builtins.treesitter"

local plugs_storage =  mem_storage.new(
    {
        lspconfig,
        cmp,
        treesitter,
    }
)


return plugs_storage
