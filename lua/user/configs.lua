return {
  options = {
    backup = false,            -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 1,             -- more space in the neovim command line for displaying messages
    --completeopt = {"menuone", "noselect"},
    conceallevel = 0,          -- so that `` is visible in markdown files
    fileencoding = "utf-8",    -- the encoding written to a file
    foldmethod = "manual",     -- folding, set to "expr" for treesitter based folding
    foldexpr = "",             -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    hidden = true,             -- required to keep multiple buffers and open multiple buffers
    ignorecase = true,         -- ignore case in search patterns
    mouse = "a",               -- allow the mouse to be used in neovim
    pumheight = 10,            -- pop up menu height
    showmode = false,          -- we don't need to see things like -- INSERT -- anymore
    showtabline = 0,           -- always show tabs
    smartcase = true,          -- smart case
    smartindent = true,        -- make indenting smarter again
    splitbelow = true,         -- force all horizontal splits to go below current window
    splitright = true,         -- force all vertical splits to go to the right of current window
    swapfile = false,          -- creates a swapfile
    termguicolors = true,      -- set term gui colors (most terminals support this)
    timeoutlen = 1000,         -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true,              -- set the title of window to the value of the titlestring
    -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
    undofile = true,           -- enable persistent undo
    updatetime = 100,          -- faster completion
    writebackup = false,       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true,          -- convert tabs to spaces
    shiftwidth = 2,            -- the number of spaces inserted for each indentation
    tabstop = 2,               -- insert 2 spaces for a tab
    cursorline = true,         -- highlight the current line
    number = true,             -- set numbered lines
    numberwidth = 2,           -- set number column width to 2 {default 4}
    signcolumn = "yes",        -- always show the sign column, otherwise it would shift the text each time
    wrap = false,              -- display lines as one long line
    scrolloff = 8,             -- minimal number of screen lines to keep above and below the cursor.
    sidescrolloff = 8,         -- minimal number of screen lines to keep left and right of the cursor.
    showcmd = false,
    ruler = false,
    laststatus = 3,
  },
  colorscheme = {
    name = "catppuccin-frappe",
    background = "dark",
  },
  plugin_specs = {
    { 'navarasu/onedark.nvim', lazy = false },
    {
      cfg = { 'catppuccin/nvim', lazy = false, priority = 1000 },
      --[[ setup = function ()
        require("catppuccin").setup({
          term_colors = true,
          transparent_background = false,
          styles = {
            comments = {},
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
          },
          color_overrides = {
            mocha = {
              base = "#000000",
              mantle = "#000000",
              crust = "#000000",
            },
          },
        })
      end ]]
    },
    {
      cfg = { 'rcarriga/nvim-notify' },
      setup = function()
        require("notify").setup({})
        vim.notify = require("notify")
      end,
    },
    {
      cfg = { 'mvllow/modes.nvim' },
      setup = function()
        require('modes').setup()
      end
    },
  },
  setup_keymap = function(pvim)
    -- completion
    vim.keymap.set('i', '<C-Space>', pvim.lsp.completion_service.complete, { silent = true })
    vim.keymap.set('i', '<C-e>', pvim.lsp.completion_service.close_suggestions, { silent = true })
    vim.keymap.set('i', '<C-j>', pvim.lsp.completion_service.scroll_docs_up, { silent = true })
    vim.keymap.set('i', '<C-k>', pvim.lsp.completion_service.scroll_docs_down, { silent = true })

    -- tabs
    vim.keymap.set('n', '<C-t>', ":tabnew<CR>", { silent = true })
    vim.keymap.set("n", "gt", pvim.tabs_service.go_to_next, { silent = true })

    -- text helpers
    vim.keymap.set('n', '<', "<gv", { silent = true })
    vim.keymap.set('v', '>', ">gv", { silent = true })


    -- lsp
    vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { silent = true })
    vim.keymap.set('n', 'gv', ":vsplit | lua vim.lsp.buf.definition()<CR>", { silent = true })
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename, { silent = true })
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename, { silent = true })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true })
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { silent = true })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })

    -- search
    vim.keymap.set("n", "<C-S-f>", pvim.search_service.search_term, { silent = true })
    vim.keymap.set("n", "<C-p>", pvim.search_service.find_files, { silent = true })
    vim.keymap.set("n", "<C-S-b>", pvim.search_service.search_open_buffer, { silent = true })


    -- explorer
    vim.keymap.set("n", "<C-b>", pvim.explorer_service.toggle, { silent = true })

    -- save buffers
    vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = false })
    vim.keymap.set("n", "<C-S-s>", ":wa<CR>", { silent = false })

    -- vcs
    vim.keymap.set("n", "gb", pvim.version_ctrl_service.blame_curr_line, { silent = false })
    vim.keymap.set("n", "bd", pvim.version_ctrl_service.get_buffer_diffs, { silent = false })

    -- terminal
    vim.keymap.set("n", "<C-j>", pvim.terminal_service.open_horizontal, { silent = false })
    vim.keymap.set("n", "<C-j>h", pvim.terminal_service.open_vertical, { silent = false })
    vim.keymap.set("n", "<C-j>f", pvim.terminal_service.open_float, { silent = false })

    --vim.fn.feedkeys(vim.api.nvim_replace_termcodes("\n", true, true, true), "n")
  end
}
