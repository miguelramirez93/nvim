local service = {
  client = {
  }
}

function service.open_vertical()
  service.client.open_vertical()
end

function service.open_horizontal()
  service.client.open_horizontal()
end

function service.open_float()
  service.client.open_float()
end

return service
