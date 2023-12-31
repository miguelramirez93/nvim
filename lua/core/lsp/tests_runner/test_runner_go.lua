local test_runner_go = {
    cfg = { "nvim-neotest/neotest-go" },
    opts = {
        args = { "-timeout=30s" }
    },
}

function test_runner_go.runner()
    return require("neotest-go")(test_runner_go.opts)
end

return test_runner_go
