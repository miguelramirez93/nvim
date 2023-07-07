local signs              = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn",  text = "" },
  { name = "DiagnosticSignHint",  text = "" },
  { name = "DiagnosticSignInfo",  text = "" }
}

local diagnostic_storage = {
  diagnostic_cfg = {
    virtual_text = true,
    diagnostics = { signs = { active = true, value = signs } },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      format = function(d)
        local code = d.code or (d.user_data and d.user_data.lsp.code)
        if code then
          return string.format("%s [%s]", d.message, code):gsub("1. ", "")
        end
        return d.message
      end
    },
    document_highlight = true,
    code_lens_refresh = true
  }
}

function diagnostic_storage.get_cfg()
  local cfg = diagnostic_storage.diagnostic_cfg
  return cfg
end

return diagnostic_storage
