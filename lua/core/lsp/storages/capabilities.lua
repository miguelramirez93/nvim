local capabilities_storage =  {}

function capabilities_storage.get_default()
    local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if not status_ok then return end
    -- TODO: move this to a better location, this is using cmp third party 
    return cmp_nvim_lsp.default_capabilities()
end

return capabilities_storage