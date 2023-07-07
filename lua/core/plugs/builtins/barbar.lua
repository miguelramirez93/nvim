local barbar = {
  name = "barbar",
  cfg = { 'romgrk/barbar.nvim' },
  def_opts = {},
}


function barbar.implementation()
  return require "barbar"
end

function barbar.go_to_next()
  vim.cmd [[BufferNext]]
end

function barbar.go_to_prev()
  vim.cmd [[BufferPrevious]]
end

return barbar
