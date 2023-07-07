local devicons = {
  name = "web-dev-icons",
  cfg = {
    "nvim-tree/nvim-web-devicons",
  },
}

function devicons.setup()
  require'nvim-web-devicons'.setup()
end



return devicons
