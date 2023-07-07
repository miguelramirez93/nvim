local neotest = {
    name = "neotest",
    cfg = {"nvim-neotest/neotest", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim"},
}

function neotest.load(runners)
    require("neotest").setup({
        adapters = runners,
        diagnostic = {
            enabled = true,
        },
    })
end

function neotest.run_current_file()
    require("neotest").run.run(vim.fn.expand("%"))
end

function neotest.run_current_root()
    require('neotest').run.run(vim.fn.getcwd())
end

function neotest.run_nearest()
    require("neotest").run.run()
end

function neotest.stop_running()
    require("neotest").run.stop()
end

function neotest.run_nearest_debug()
    require("neotest").run.run({strategy = "dap"})
end

function neotest.summary_toggle()
    require("neotest").summary.toggle()
end

function neotest.summary_open()
    require("neotest").summary.open()
end

function neotest.summary_close()
    require("neotest").summary.close()
end

function neotest.go_to_prev_failed()
    require("neotest").jump.prev({ status = "failed" })
end

function neotest.go_to_next_failed()
    require("neotest").jump.next({ status = "failed" })
end

function neotest.current_test_result()
    require("neotest").output.open({ enter = true })
end

return neotest