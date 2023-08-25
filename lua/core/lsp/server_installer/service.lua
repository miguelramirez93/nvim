local service = {
    client = {},
}

function service.install_servers(servers)
    for _, server in ipairs(servers) do
        service.client.add_server(server)
    end
end

return service