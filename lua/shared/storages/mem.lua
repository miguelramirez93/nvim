local memory_storage = {}

function memory_storage.new(preloaded_table)
    local storage = {mem = preloaded_table}
    function storage.get_all()
        return storage.mem
    end

    function storage.add(cfg) 
        table.insert(storage.mem, cfg) 
    end

    return storage
end

return memory_storage
