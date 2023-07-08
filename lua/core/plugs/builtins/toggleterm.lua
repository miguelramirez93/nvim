local toggleterm = {
  name     = "toggleterm",
  cfg      = {
    { 'akinsho/toggleterm.nvim', version = "*", config = true },
  },
  def_opts = {},
}

function toggleterm.implementation()
  function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  end

  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  return require("toggleterm")
end

function toggleterm.open_vertical()
  vim.cmd [[ ToggleTerm size=80 direction=vertical ]]
end

function toggleterm.open_horizontal()
  vim.cmd [[ ToggleTerm size=10 direction=horizontal ]]
end

function toggleterm.open_float()
  vim.cmd [[ ToggleTerm direction=float ]]
end

return toggleterm
