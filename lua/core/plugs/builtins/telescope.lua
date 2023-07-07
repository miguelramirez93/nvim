local telescope = {
  name = "nvimtree",
  cfg = {
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      'LukasPietzschmann/telescope-tabs',
    },
  }
}

function telescope.setup()
  require('telescope').setup()
  require 'telescope-tabs'.setup {}
end

function telescope.find_files()
  local builtin = require('telescope.builtin')
  builtin.find_files()
end

function telescope.search_term()
  local builtin = require('telescope.builtin')
  builtin.live_grep()
end

function telescope.search_open_buffer()
  local builtin = require('telescope.builtin')
  builtin.buffers()
end

return telescope
