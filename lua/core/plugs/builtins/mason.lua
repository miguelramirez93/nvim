local mem_storage = require "shared.storages.mem"

local mason = {
  cfg = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  lsp_servers = mem_storage.new({})
}

function mason.setup()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = mason.lsp_servers.get_all(),
    })
end

function mason.add_server(server)
    mason.lsp_servers.add(server)
end

return  mason