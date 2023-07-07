local vim_service = {}

function vim_service.set_options(opts)
    for k, v in pairs(opts) do
        vim.opt[k] = v
    end
end

function vim_service.set_colorscheme(cfg)
    local ok, _ = pcall(vim.cmd, "colorscheme " .. cfg.name)
    vim.o.background = cfg.background -- or "light" for light mode
    if not ok then
        vim.notify("colorscheme " .. cfg.name .. " not found!")
        return
    end
end

function vim_service.def_key_fallback(mode)
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("\n", true, true, true), mode)
end

return vim_service
