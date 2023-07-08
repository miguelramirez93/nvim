local tablehlprs             = require "shared.table_helpers"
local completion_service     = require "core.lsp.completion.service"
local syntax_builder_service = require "core.lsp.syntaxbuilder.service"
local tests_runner_service                = require "core.lsp.tests_runner.service"

local service                = {
  plugs_storage = {},
  langsrvs_storage = {},
  capabilities_storage = {},
  diagnostic_storage = {},
  handlers_storage = {},
  completion_service = completion_service,
  attacheable_srcs = {},
  tests_runner_service = tests_runner_service,
}

function service.with_langsrvs_storage(storage)
  service.langsrvs_storage = storage
  return service
end

function service.with_plugs_storage(storage)
  service.plugs_storage = storage
  return service
end

function service.with_capabilities_storage(storage)
  service.capabilities_storage = storage
  return service
end

function service.with_diagnostic_storage(storage)
  service.diagnostic_storage = storage
  return service
end

function service.with_handlers_storage(storage)
  service.handlers_storage = storage
  return service
end

function service.with_snippets_engine(engine)
  service.completion_service.add_engine(engine)
  return service
end

function service.with_completion_client(cli)
  service.completion_service.client = cli
  return service
end

function service.with_autopairs_client(cli)
  service.completion_service.autopairs_cli = cli
  return service
end

function service.with_syntax_client(cli)
  syntax_builder_service.client = cli
  return service
end

function service.with_tests_runner_client(cli)
  service.tests_runner_service.client = cli
  return service
end

function service.get_plugs()
  return tablehlprs.merge_arrays(service.plugs_storage.get_all(), service.langsrvs_storage.get_all())
end

function service.setup_langsrvs()
  local lspconfig_installed, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_installed then return end

  local def_capabilities = service.capabilities_storage.get_default()

  for _, langsrvr in ipairs(service.langsrvs_storage.get_all()) do
    local opts = {
      capabilities = def_capabilities,
      on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        if langsrvr.ls.opts and langsrvr.ls.opts.on_attach then
          langsrvr.ls.opts.on_attach(client, bufnr)
        end

        for _, attacheable in ipairs(service.attacheable_srcs) do
          attacheable.on_attach(client, bufnr)
        end
      end
    }

    if langsrvr.ls.opts then
      opts = vim.tbl_deep_extend("force",  opts, langsrvr.ls.opts)
    end
    if langsrvr.ls.name and lspconfig[langsrvr.ls.name] then
      lspconfig[langsrvr.ls.name].setup(opts)
    end
    
  end
end

function service.setup_completion()
  service.completion_service.setup_completion()
end

function service.setup_diagnostics()
  local cfg = service.diagnostic_storage.get_cfg()
  vim.diagnostic.config(cfg)
  service.setup_signs(cfg.diagnostics.signs.value)
  -- Enable diagnostic on cursor NOTE: could be an user choose
  if not cfg.virtual_text then
    vim.cmd [[ autocmd CursorHold * lua vim.diagnostic.open_float() ]]
  end
end

function service.setup_signs(signs)
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name,
      { texthl = sign.name, text = sign.text, numhl = "" })
  end
end

function service.setup_syntax_builder()
  for _, langsrvr in ipairs(service.langsrvs_storage.get_all()) do
    if langsrvr.ls.lang then
      syntax_builder_service.add_lang(langsrvr.ls.lang)
    end
  end
  syntax_builder_service.load_builder()
end

function service.setup_before_buffer_write_actions()
  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
end

function service.setup_handlers()
  for _, h in ipairs(service.handlers_storage.get_all()) do vim.lsp.handlers[h.name] = h.cfg end
end

function service.setup_tests_runners()
  service.tests_runner_service.load_runners()
end

function service.setup()
  service.setup_handlers()
  service.setup_syntax_builder()
  service.setup_diagnostics()
  service.setup_langsrvs()
  service.setup_completion()
  service.setup_before_buffer_write_actions()
  service.setup_tests_runners()
end

return service
