local service = {
    client = {}
}
function service.get_buffer_diffs()
    service.client.get_buffer_diffs()
end

function service.blame_curr_line()
    service.client.blame_curr_line()
end

return service