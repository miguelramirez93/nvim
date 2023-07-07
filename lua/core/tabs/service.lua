local service = {
  client = {
    go_to_next = function() end,
    go_to_prev = function() end,
  },
}

function service.go_to_next()
  service.client.go_to_next()
end

function service.go_to_prev()
  service.client.go_to_prev()
end

return service
