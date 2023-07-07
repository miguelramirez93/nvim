local client_lazy = {}
local default_opts = {
    defaults = {
        lazy = false, -- should plugins be lazy-loaded?
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
      },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true, -- get a notification when new updates are found
        frequency = 21600, -- check for updates every hour
      },
}
function client_lazy.setup()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git", "clone", "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git", "--branch=stable",
            lazypath
        })
    end
    vim.opt.rtp:prepend(lazypath)
end

function client_lazy.install(cfgs) require("lazy").setup(cfgs, default_opts) end

return client_lazy
