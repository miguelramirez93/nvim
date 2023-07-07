local storage = require "shared.storages.mem".new({})

local service = {
    client = {
        load = function (runners) end,
        add_runner = function (runner) end
    },
}

function service.add_runner(runner)
    storage.add(runner)
end

function service.load_runners()
    local runners = storage.get_all()
    local translated_runners = {}
    for _, runner in ipairs(runners) do
        table.insert(translated_runners, runner.runner())
    end
    service.client.load(translated_runners)
end

function service.run_current_file()
    service.client.run_current_file()
end

function service.run_current_root()
   service.client.run_current_root()
end
function service.run_nearest()
    service.client.run_nearest()
end

function service.stop_running()
    service.client.stop_running()
end

function service.run_nearest_debug()
    service.client.run_nearest_debug()
end

function service.summary_toggle()
    service.client.summary_toggle()
end


function service.summary_open()
    service.client.summary_open()
end

function service.summary_close()
    service.client.summary_close()
end
function service.go_to_prev_failed()
    service.client.go_to_prev_failed()
end

function service.go_to_next_failed()
    service.client.go_to_next_failed()
end

function service.current_test_result()
    service.client.current_test_result()
end

return service