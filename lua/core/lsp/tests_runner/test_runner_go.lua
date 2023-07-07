local test_runner_go = {
    cfg = {"nvim-neotest/neotest-go"},
    opts = {},
}

function test_runner_go.runner()
    return require("neotest-go")(test_runner_go.opts)
end

return test_runner_go