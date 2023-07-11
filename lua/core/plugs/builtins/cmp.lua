local tablehlprs = require "shared.table_helpers"

local def_sources = {
  { name = 'nvim_lsp' },
  { name = "path" },
  { name = 'buffer' },
  --{ name = 'nvim_lsp_signature_help' },

  --{ name = 'vsnip' }, -- For vsnip users.
  --{ name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
}

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

local cmp = {
  name = "cmp",
  cfg = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer', },
    { 'hrsh7th/cmp-path', },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp' },
    --{ "hrsh7th/cmp-nvim-lsp-signature-help" },
  },
}

function cmp.load(snippets_engine, autopairs_cli)
  local cmp_status_ok, client = pcall(require, "cmp")
  if not cmp_status_ok then return end
  
  local sources = tablehlprs.merge_arrays({snippets_engine}, def_sources)

  if snippets_engine.preload then
    snippets_engine.preload()
  end

  client.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        snippets_engine.expand(args)
      end,
    },
    window = {
      completion = client.config.window.bordered(),
      documentation = client.config.window.bordered(),
    },
    mapping = client.mapping.preset.insert({
      ["<C-y>"] = client.config.disable,                                                                      -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<CR>'] = client.mapping.confirm({ select = false, behavior = client.ConfirmBehavior.Replace }),       -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = client.mapping(function(fallback)
        if client.visible() then
          client.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
        -- they way you will only jump inside the snippet region
        elseif snippets_engine.visible() then
          snippets_engine.select_next_item()
        elseif has_words_before() then
          client.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
  
      ["<S-Tab>"] = client.mapping(function(fallback)
        if client.visible() then
          client.select_prev_item()
        elseif snippets_engine.prev_item_selectable() then
          snippets_engine.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    formatting = {
      fields = {"kind", "abbr", "menu"},
      format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]"
          })[entry.source.name]
          return vim_item
      end
  },
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

  if autopairs_cli then 
    client.event:on(
    'confirm_done',
    autopairs_cli.on_confirm_done()
    )
  end
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
