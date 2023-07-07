local memory_storage = require "shared.storages.mem"

local storage = memory_storage.new({})

local service = {
  client = {
    load = function(snippets_engines) end
  },
}

function service.add_engine(engine)
  storage.add(engine)
end

function service.get_engines()
  return service.snippets_engines
end

function service.setup_completion()
  local engines = storage.get_all()
  service.client.load(engines)
end

function service.complete()
  service.client.complete()
end

function service.close_suggestions()
  service.client.abort()
end

function service.scroll_docs_up()
  service.client.scroll_docs(4)
end

function service.scroll_docs_down()
  service.client.scroll_docs(-4)
end

return service
