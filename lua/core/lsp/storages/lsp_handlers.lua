local mem_storage = require "shared.storages.mem"

local lsphandlers_storage = mem_storage.new(
  {
    {
      name = "textDocument/hover",
      cfg = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        focusable = false,
        style = "minimal",
        source = "always"
      })
    },
  }
)

return lsphandlers_storage
