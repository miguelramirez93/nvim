local service = {
  client = {
    toggle = function() end,
    split_open_vertical = function() end,
    close_parent_dir = function() end,
  }
}

function service.toggle()
  service.client.toggle()
end

function service.split_open_vertical(mode)
   service.client.split_open_vertical()
end

function service.close_parent_dir(mode)
   service.client.close_parent_dir()
end

return service
