local service = {
  client = {
    load = function(snippets_engines) end
  },
  snippets_engine = {},
}

function service.setup_completion()
  service.client.load(service.snippets_engine)
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
