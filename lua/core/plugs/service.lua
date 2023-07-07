local helpers = require "core.plugs.helpers"

local service = { client = {}, storage = {}, snippets_cfg = {} }

function service.with_client(client)
  service.client = client
  return service
end

function service.with_storage(storage)
  service.storage = storage
  return service
end

function service.add_plug_cfg(plug_cfg)
  service.storage.add(plug_cfg)
end

function service.add_installable_cfg(installable)
  if helpers.is_installable(installable) then
    local plugs_cfg = installable.get_plugs()
    for i, cfg in ipairs(plugs_cfg) do
      service.storage.add(cfg)
    end
  end
end

function service.setup()
  service.client.setup()
  service.install_plugs()
  service.setup_plugs()
end

function service.install_plugs()
  local cfgs = {}
  for _, plug_cfg in ipairs(service.storage.get_all()) do
    if plug_cfg.cfg then
      for _, cfg in ipairs(plug_cfg.cfg) do
        table.insert(cfgs, cfg)
      end
    end
  end
  service.client.install(cfgs)
end

function service.setup_plugs()
  for _, plug_cfg in ipairs(service.storage.get_all()) do
    if plug_cfg.implementation then
      local c_opts = plug_cfg.opts or {}
      local d_opts = plug_cfg.def_opts or {}
      local opts = vim.tbl_deep_extend("force",d_opts, c_opts)
      plug_cfg.implementation().setup(opts)
    elseif plug_cfg.setup then
      plug_cfg.setup()
    end
  end
end

return service
