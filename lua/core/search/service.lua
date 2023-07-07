local service = {
  client = {
    find_files = function() end,
    search_terms = function() end,
    switch_tab = function() end,
  }
}

function service.find_files()
  service.client.find_files()
end

function service.search_term()
  service.client.search_term()
end

function service.search_open_buffer()
  service.client.search_open_buffer()
end

return service
