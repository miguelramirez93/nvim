local nvimtree = {
  name = "nvimtree",
  cfg = {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  opts = {},
  def_opts = {
    view = {adaptive_size = true},
    auto_reload_on_write = true,
    git = {enable = true, ignore = false, timeout = 400},
    update_focused_file = {
      enable = true,
      update_cwd = false,
      ignore_list = {}
    },
    actions = {
        open_file = {
            quit_on_open = true,
            resize_window = false,
            window_picker = {
                enable = false,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = {
                        "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame",
                        "lazy"
                    },
                    buftype = {"nofile", "terminal", "help"}
                }
            }
        }
    },
    renderer = {
        indent_markers = {
            enable = true,
            icons = {corner = "└ ", edge = "│ ", none = "  "}
        }
    },
    diagnostics = {
        enable = true,
        icons = {hint = "", info = "", warning = "", error = ""}
    },
    on_attach = function (bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
          return {
              desc = 'nvim-tree: ' .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true
          }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Parent'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Vertical Split'))
    end,
  }
}

function nvimtree.implementation()
  return require("nvim-tree")
end

function nvimtree.toggle()
   local api = require "nvim-tree.api"
   api.tree.toggle()
end

function nvimtree.split_open_vertical()
   local api = require "nvim-tree.api"
   api.node.open.vertical()
end

function nvimtree.close_parent_dir()
   local api = require "nvim-tree.api"
   api.node.navigate.parent_close()
end

return nvimtree
