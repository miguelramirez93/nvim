local service = {
  client = {
    open_all = function() end,
    fold_all = function() end,
  }
}

function service.open_all()
  service.client.open_all()
end

function service.fold_all()
  service.client.fold_all()
end

return service
