local lua_ls = require "core.lsp.ls.lua_ls"
local test_runner_go = require "core.lsp.tests_runner.test_runner_go"
local function get_root_dir(...)
  local status_ok, util = pcall(require, "lspconfig/util")
  if not status_ok then return end
  return util.root_pattern(...)
end

return {
  lua_ls,
  {
    name = "go",
    ls = {
      name = "gopls",
      lang = "go",
      opts = {
        cmd = { "gopls", "serve" },
        filetypes = { "go", "gomod" },
        root_dir = get_root_dir("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      },
      tests_runners = {
        test_runner_go,
      },
    },
    cfg = {
      'crispgm/nvim-go',
      'nvim-lua/plenary.nvim',
    },
    setup = function()
      require('go').setup({
        auto_lint = false,
        linter = 'staticcheck',
        lint_prompt_style = 'vt',
        test_popup = true,
        test_popup_auto_leave = false,
        test_popup_width = 240,
        test_popup_height = 30,
      })
    end
  },
}
