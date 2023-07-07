local gitsigns = {
    name = "gitsigns",
    cfg = {'lewis6991/gitsigns.nvim', 'tpope/vim-fugitive'},
    def_opts = {},
}

function gitsigns.implementation()
    return require('gitsigns')
end

function gitsigns.get_buffer_diffs()
    vim.cmd [[ Gitsigns diffthis ]]
end

function gitsigns.blame_curr_line()
    vim.cmd [[ Gitsigns toggle_current_line_blame ]]
end

return gitsigns