local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify("wait while lazy is installed .... ")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    -- "--branch=stable", -- latest stable release
    lazypath,
  })
  vim.notify("Lazy installed ok uwu")
end

vim.opt.rtp:prepend(lazypath)

-- Lazy.vim
require("lazy").setup({
  defaults = {
    lazy = true,
  },
  spec = {
    --{ dir = "settings" },
    { import = "plugins" },
  },
  dev = {
    -- directory where you store your local plugin projects
    path = "~/.config/nvim/localplugins",
    --path = vim.fn.stdpath("config") .. "/",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  install = { colorscheme = { "habamax" } },
  ui = {
    size = { width = 0.9, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    border = "single",
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "tohtml",
        "gzip",
        "zipPlugin",
        -- "netrwPlugin",
        "tarPlugin",

        "editorconfig",
        "health",
        "man",
        --"matchit",
        --"matchparen",
        "nvim",
        "rplugin",
        "shada",
        "spellfile",
        "tutor",
      },
    },
  },
  readme = {
    enabled = false,
  },
})
