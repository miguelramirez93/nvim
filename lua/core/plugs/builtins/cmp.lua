local tablehlprs = require "shared.table_helpers"
local luasnip = require "core.lsp.completion.engines.luasnip"

local def_sources = {
  { name = 'nvim_lsp' },
  { name = "path" },
  { name = 'buffer' },
  luasnip,
  { name = 'nvim_lsp_signature_help' },

  --{ name = 'vsnip' }, -- For vsnip users.
  --{ name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
}

local cmp = {
  name = "cmp",
  cfg = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer', },
    { 'hrsh7th/cmp-path', },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp' },
    -- snippets
    { "L3MON4D3/LuaSnip", },
  },
}

function cmp.load(snippets_engines)
  local cmp_status_ok, client = pcall(require, "cmp")
  if not cmp_status_ok then return end

  local sources = tablehlprs.merge_arrays(snippets_engines, def_sources)

  client.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        for i, engine in ipairs(snippets_engines) do
          engine.expand(args)
        end
        luasnip.expand(args)
      end,
    },
    window = {
      completion = client.config.window.bordered(),
      documentation = client.config.window.bordered(),
    },
    mapping = client.mapping.preset.insert({
      ["<C-y>"] = client.config.disable,                                                                      -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<CR>'] = client.mapping.confirm({ select = false, behavior = client.ConfirmBehavior.Replace }),       -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = sources,
  })

  -- Set configuration for specific filetype.
  client.setup.filetype('gitcommit', {
    sources = client.config.sources({
      { name = 'git' },       -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  client.setup.cmdline({ '/', '?' }, {
    mapping = client.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  client.setup.cmdline(':', {
    mapping = client.mapping.preset.cmdline(),
    sources = client.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
end

function cmp.complete()
  require 'cmp'.complete()
end

function cmp.close_suggestions()
  require 'cmp'.abort()
end

function cmp.scroll_docs_up()
  require 'cmp'.scroll_docs(4)
end

function cmp.scroll_docs_down()
  require 'cmp'.scroll_docs(-4)
end

return cmp
