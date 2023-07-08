local plugs_service            = require "core.plugs.service"
local lsp_service              = require "core.lsp.service"
local treesitter               = require "core.plugs.builtins.treesitter"
local telescope                = require "core.plugs.builtins.telescope"
local search_service           = require "core.search.service"
local nvimtree                 = require "core.plugs.builtins.nvimtree"
local explorer_service         = require "core.explorer.service"
local webdevicons              = require "core.plugs.builtins.nvim-web-dev-icons"
local folding_service          = require "core.lsp.folding.service"
local ufo                      = require "core.plugs.builtins.ufo"
local navic                    = require "core.plugs.builtins.navic"
local lsp_signature            = require "core.plugs.builtins.lsp_signature"
local codectx_service          = require "core.lsp.codectx.service"
local tabs_service             = require "core.tabs.service"
local barbar                   = require "core.plugs.builtins.barbar"
local gitsigns                 = require "core.plugs.builtins.gitsigns"
local version_ctrl_service     = require "core.versionctrl.service"
local lualine                  = require "core.plugs.builtins.lualine"
local symbols_outline          = require "core.plugs.builtins.symbols_outline"
local neotest                  = require "core.plugs.builtins.neotest"
local luasnip                  = require "core.lsp.completion.engines.luasnip"
local autopairs                = require "core.plugs.builtins.autopairs"

local client_lazy              = require "core.plugs.client_lazy"

local plugs_mem_storage        = require "core.plugs.storages.mem"
local lsp_plugs_mem_storage    = require "core.lsp.storages.plugs"
local lsp_langsvrs_mem_storage = require "core.lsp.storages.langsvrs"
local capabilities_mem_storage = require "core.lsp.storages.capabilities"
local diagnostic_mem_storage   = require "core.lsp.storages.diagnostics"
local lsphandlers_mem_storage  = require "core.lsp.storages.lsp_handlers"
local atteachable_mem_storage  = require "core.lsp.storages.attacheables"
local cmp                      = require "core.plugs.builtins.cmp"
local vsnip                    = require "core.lsp.completion.engines.vsnip"
local vim_service              = require "core.natives.vim_service"

local def_cfg                  = {
  plugs = {
    client = client_lazy,
    specs = {},
  },
  lsp = {
    lang_servers = {},
    handlers_cfg = {},
    global_capabilities = {},
    diagnostics_cfg = {},
    completion_cli = cmp,
    autopairs_cli = autopairs,
    syntax_cli = treesitter,
    snippets_engine = luasnip,
    folding_cli = ufo,
    codectx_cli = navic,
    fn_siganture_cli = lsp_signature,
    outline_sym_cli = symbols_outline,
    tests_runner_cli = neotest,
    test_runners = {},
  },
  search_cli = telescope,
  explorer_cli = nvimtree,
  icons_cli = webdevicons,
  tabs_cli = barbar,
  version_ctrl_cli = gitsigns,
  status_line_cli = lualine,
}

local pvim                     = {
  plugs = plugs_service,
  lsp = lsp_service
      .with_capabilities_storage(capabilities_mem_storage),
  search_service = search_service,
  explorer_service = explorer_service,
  icons_service = { client = {} },
  folding_service = folding_service,
  -- TODO: move to lsp service
  codectx_service = codectx_service,
  tabs_service = tabs_service,
  version_ctrl_service = version_ctrl_service,
}

function pvim.setup_plugs()
  pvim.plugs.add_installable_cfg(pvim.lsp)
  pvim.plugs.setup()
end

function pvim.setup_lsp()
  pvim.lsp.setup()
end

function pvim.setup(custom_cfg)
  local cfg = def_cfg

  if custom_cfg then
    cfg = vim.tbl_deep_extend("force", cfg, custom_cfg)
  end

  -- plus service setup

  for _, plug in ipairs(cfg.plugs.specs) do
    if plug.cfg then
      plugs_mem_storage.add(plug)
    else
      plugs_mem_storage.add({ cfg = plug })
    end
  end

  pvim.plugs.with_client(cfg.plugs.client)
  pvim.plugs.with_storage(plugs_mem_storage)

  --lsp service setup
  lsp_plugs_mem_storage.add(cfg.lsp.completion_cli)
  lsp_plugs_mem_storage.add(cfg.lsp.autopairs_cli)
  lsp_plugs_mem_storage.add(cfg.lsp.syntax_cli)
  pvim.lsp.with_syntax_client(cfg.lsp.syntax_cli)

  --lsp tests helper setup
  pvim.lsp.with_tests_runner_client(cfg.lsp.tests_runner_cli)
  lsp_plugs_mem_storage.add(cfg.lsp.tests_runner_cli)

  for _, runner in ipairs(cfg.lsp.test_runners) do
    lsp_plugs_mem_storage.add(runner)
    pvim.lsp.tests_runner_service.add_runner(runner)
  end

  lsp_plugs_mem_storage.add(cfg.lsp.snippets_engine)
  pvim.lsp.completion_service.snippets_engine = cfg.lsp.snippets_engine

  -- lsp codectx
  pvim.codectx_service.client = cfg.lsp.codectx_cli
  pvim.codectx_service.signature_cli = cfg.lsp.fn_siganture_cli
  pvim.codectx_service.outline_sym_cli = cfg.lsp.outline_sym_cli
  lsp_plugs_mem_storage.add(pvim.codectx_service.client)
  lsp_plugs_mem_storage.add(pvim.codectx_service.signature_cli)
  lsp_plugs_mem_storage.add(pvim.codectx_service.outline_sym_cli)

  table.insert(pvim.lsp.attacheable_srcs, pvim.codectx_service)

  -- lsp attacheables
  for _, attacheable in ipairs(atteachable_mem_storage.get_all()) do
    table.insert(pvim.lsp.attacheable_srcs, attacheable)
  end

  pvim.lsp.with_plugs_storage(lsp_plugs_mem_storage)
  pvim.lsp.with_completion_client(cfg.lsp.completion_cli)
  pvim.lsp.with_autopairs_client(cfg.lsp.autopairs_cli)

  if cfg.lsp.diagnostics_cfg then
    diagnostic_mem_storage.diagnostic_cfg = vim.tbl_deep_extend("force", cfg.lsp.diagnostics_cfg,
      diagnostic_mem_storage.diagnostic_cfg)
  end

  pvim.lsp.with_diagnostic_storage(diagnostic_mem_storage)

  for _, h in ipairs(cfg.lsp.handlers_cfg) do
    lsphandlers_mem_storage.add(h)
  end
  pvim.lsp.with_handlers_storage(lsphandlers_mem_storage)

  for _, lang_srvr in ipairs(cfg.lsp.lang_servers) do
    lsp_plugs_mem_storage.add(lang_srvr)
    lsp_langsvrs_mem_storage.add(lang_srvr)
    if lang_srvr.ls.tests_runners then
      for _, runner in ipairs(lang_srvr.ls.tests_runners) do
        lsp_plugs_mem_storage.add(runner)
        pvim.lsp.tests_runner_service.add_runner(runner)
      end
    end
  end

  pvim.lsp.with_langsrvs_storage(lsp_langsvrs_mem_storage)

  -- folding
  pvim.folding_service.client = cfg.lsp.folding_cli
  pvim.plugs.add_plug_cfg(pvim.folding_service.client)
  -- search
  pvim.search_service.client = cfg.search_cli
  pvim.plugs.add_plug_cfg(pvim.search_service.client)

  -- explorer
  pvim.explorer_service.client = cfg.explorer_cli
  pvim.plugs.add_plug_cfg(pvim.explorer_service.client)

  -- icons
  pvim.icons_service.client = cfg.icons_cli
  pvim.plugs.add_plug_cfg(pvim.icons_service.client)

  -- tabs
  if cfg.tabs_cli then
    pvim.tabs_service.client = cfg.tabs_cli
    pvim.plugs.add_plug_cfg(pvim.tabs_service.client)
  end

  -- version control
  if cfg.version_ctrl_cli then
    pvim.version_ctrl_service.client = cfg.version_ctrl_cli
    pvim.plugs.add_plug_cfg(pvim.version_ctrl_service.client)
  end

  -- statusline
  if cfg.status_line_cli then
    pvim.plugs.add_plug_cfg(cfg.status_line_cli)
  end

  -- setup pvim
  pvim.setup_plugs()
  pvim.setup_lsp()
  pvim.set_commands()
end

function pvim.set_options(opts)
  vim_service.set_options(opts)
end

function pvim.set_colorscheme(cfg)
  vim_service.set_colorscheme(cfg)
end

function pvim.set_commands()
  vim.api.nvim_create_user_command('PvimTestCurrentFile', function()
    pvim.lsp.tests_runner_service.summary_open()
    pvim.lsp.tests_runner_service.run_current_file()
  end, {})
  vim.api.nvim_create_user_command('PvimTestAll', function()
    pvim.lsp.tests_runner_service.summary_open()
    pvim.lsp.tests_runner_service.run_current_root()
  end, {})
  vim.api.nvim_create_user_command('PvimTestFunc', function()
    pvim.lsp.tests_runner_service.run_nearest()
  end, {})
  vim.api.nvim_create_user_command('PvimTestFuncDebug', function()
    pvim.lsp.tests_runner_service.run_nearest_debug()
  end, {})
  vim.api.nvim_create_user_command('PvimTestStop', function()
    pvim.lsp.tests_runner_service.summary_open()
    pvim.lsp.tests_runner_service.run_nearest_debug()
  end, {})
  vim.api.nvim_create_user_command('PvimTestSummary', function()
    pvim.lsp.tests_runner_service.summary_toggle()
  end, {})
  vim.api.nvim_create_user_command('PvimTestPrevFailed', function()
    pvim.lsp.tests_runner_service.go_to_prev_failed()
  end, {})
  vim.api.nvim_create_user_command('PvimTestNextFailed', function()
    pvim.lsp.tests_runner_service.go_to_next_failed()
  end, {})
  vim.api.nvim_create_user_command('PvimTestCurrResult', function()
    pvim.lsp.tests_runner_service.current_test_result()
  end, {})
  --codectx
  vim.api.nvim_create_user_command('PvimOutLineToggle', function()
    pvim.codectx_service.toggle_outline_sym()
  end, {})
end

return pvim
