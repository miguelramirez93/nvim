local service = {
  client = {
    on_attach = function(client, bufnr) end,
    get_ctx = function() end
  },
  signature_cli = {
    on_attach = function(client, bufnr) end,
  },
  outline_sym_cli = {
    toggle = function() end,
  },
}

function service.on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    service.client.on_attach(client, bufnr)
  end
  if service.signature_cli.on_attach then
    service.signature_cli.on_attach(client, bufnr)
  end
end

function service.get_ctx()
  return service.client.get_ctx()
end

function service.toggle_outline_sym()
  if service.outline_sym_cli then
    service.outline_sym_cli.toggle()
  end
end

return service
