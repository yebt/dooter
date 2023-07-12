local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.notify("Installing lazy plugin manager...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
	vim.notify("Installed")
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
	defaults = {
		lazy = true, -- should plugins be lazy-loaded?
		version = nil,
	},
	-- spec = nil, ---@type LazySpec
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
	dev = {
		-- directory where you store your local plugin projects
		path = "~/projects",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = {}, -- For example {"folke"}
		fallback = false, -- Fallback to git when local plugin doesn't exist
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "habamax" },
	},
	ui = {
		-- a number <1 is a percentage., >1 is a fixed size
		size = { width = 0.8, height = 0.8 },
		wrap = true, -- wrap the lines in the ui
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "none",
		title = nil, ---@type string only works when border is not "none"
		title_pos = "center", ---@type "center" | "left" | "right"
		icons = {
			cmd = " ",
			config = "",
			event = "",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "󰒲 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			source = " ",
			start = "",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
		-- leave nil, to automatically select a browser depending on your OS.
		-- If you want to use a specific browser, you can define it here
		browser = nil, ---@type string?
		throttle = 20, -- how frequently should the ui process render events
		custom_keys = {
			-- you can define custom key maps here.
			-- To disable one of the defaults, set it to false

			-- open lazygit log
			["<localleader>l"] = function(plugin)
				require("lazy.util").float_term({ "lazygit", "log" }, {
					cwd = plugin.dir,
				})
			end,

			-- open a terminal for the plugin dir
			["<localleader>t"] = function(plugin)
				require("lazy.util").float_term(nil, {
					cwd = plugin.dir,
				})
			end,
		},
	},
	diff = {
		-- diff command <d> can be one of:
		-- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
		--   so you can have a different command for diff <d>
		-- * git: will run git diff and open a buffer with filetype git
		-- * terminal_git: will open a pseudo terminal with git diff
		-- * diffview.nvim: will open Diffview to show the diff
		cmd = "git",
	},
	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = false,
		notify = true, -- get a notification when changes are found
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			---@type string[]
			paths = {}, -- add any custom paths here that you want to includes in the rtp
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				"tohtml",
				"gzip",
				"zipPlugin",
				--"netrwPlugin",
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
})


--
vim.keymap.set("n", "<C-l>", ":Lazy <CR>", { silent = true })
-- vim.keymap.set("n", "<leader>l", ":Lazy profile<CR>", { silent = true })
