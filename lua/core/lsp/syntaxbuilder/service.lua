local memory_storage = require "shared.storages.mem"

local storage = memory_storage.new({})

local service = {
    client = {
        load = function(ensure_installed) end
    }
}

function service.add_lang(lang)
    storage.add(lang)
end

function service.load_builder()
  local enabled_langs = storage.get_all()
  service.client.load(enabled_langs)
end

return service