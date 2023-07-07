local mem_storage = require "shared.storages.mem"

local langsvrs_storage =  mem_storage.new(
    {}
)

return langsvrs_storage