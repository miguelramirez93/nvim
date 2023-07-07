local mem_storage = require "shared.storages.mem"

local lsphandlers_storage = mem_storage.new(
  {}
)

return lsphandlers_storage
