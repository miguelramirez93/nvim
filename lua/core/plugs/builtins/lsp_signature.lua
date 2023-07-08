local lsp_signature = {
  name = "lsp_signature",
  cfg = {
    "ray-x/lsp_signature.nvim",
  },
  def_opts = {
    hint_prefix = "",
    floating_window = true,
    hint_enable = true,
    fix_pos = false,
    floating_window_off_y = -0.5, 
  },
  opts = {},
}

function lsp_signature.on_attach(client, bufnr)
  local c_opts = lsp_signature.opts or {}
  local d_opts = lsp_signature.def_opts or {}
  local opts = vim.tbl_deep_extend("force", d_opts, c_opts)

  require "lsp_signature".on_attach(opts, bufnr)
end

return lsp_signature
