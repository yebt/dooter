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
	spec = {
		--{ dir = "settings" },
		{ import = "plugins" },
	},
	defaults = {
		lazy = true,
	},
	dev = {
		-- path = "~/projects",
		-- path = vim.fn.stdpath("config") .. "/lua",
		path = vim.fn.stdpath("config") .. "/",
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

