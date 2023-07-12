return {

	-- RUNNER
	{
		"CRAG666/code_runner.nvim",
		keys = {
			{ "<leader>r", ":RunFile<CR>", desc = "Run file" },
			{ "<F9>", ":RunFile<CR>", desc = "Run file" },
		},
		opts = {
			-- choose default mode (valid term, tab, float, toggle)
			mode = "term",
			-- Focus on runner window(only works on toggle, term and tab mode)
			focus = true,
			-- startinsert (see ':h inserting-ex')
			startinsert = false,
			insert_prefix = "",
			term = {
				--  Position to open the terminal, this option is ignored if mode ~= term
				position = "bot",
				-- window size, this option is ignored if mode == tab
				size = 12,
			},
			float = {
				close_key = "<ESC>",
				-- Window border (see ':h nvim_open_win')
				border = "none",

				-- Num from `0 - 1` for measurements
				height = 0.8,
				width = 0.8,
				x = 0.5,
				y = 0.5,

				-- Highlight group for floating window/border (see ':h winhl')
				border_hl = "FloatBorder",
				float_hl = "Normal",

				-- Transparency (see ':h winblend')
				blend = 0,
			},
			better_term = { -- Toggle mode replacement
				clean = false, -- Clean terminal before launch
				number = 10, -- Use nil for dynamic number and set init
				init = nil,
			},
			filetype_path = "",
			-- Execute before executing a file
			before_run_filetype = function()
				vim.cmd(":w")
			end,
			filetype = {
				javascript = "node",
				java = {
					"cd $dir &&",
					"javac $fileName &&",
					"java $fileNameWithoutExt",
				},
				c = {
					"cd $dir &&",
					"gcc $fileName",
					"-o $fileNameWithoutExt &&",
					"$dir/$fileNameWithoutExt",
				},
				cpp = {
					"cd $dir &&",
					"g++ $fileName",
					"-o $fileNameWithoutExt &&",
					"$dir/$fileNameWithoutExt",
				},
				python = "python -u",
				sh = "bash",
				rust = {
					"cd $dir &&",
					"rustc $fileName &&",
					"$dir/$fileNameWithoutExt",
				},
			},
			project_path = "",
			project = {},
			prefix = "",
		},
	},

	-- Tabularize
	{
		"godlygeek/tabular",
		cmd = "Tabularize",
	},

	-- Sessions
	-- {
	-- 	"Shatur/neovim-session-manager",
	-- 	-- event = "VimEnter",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	cmd = {
	-- 		"SessionManager",
	-- 	},
	-- 	config = function()
	-- 		local Path = require("plenary.path")
	-- 		local config = require("session_manager.config")
	-- 		require("session_manager").setup({
	-- 			sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
	-- 			session_filename_to_dir = session_filename_to_dir, -- Function that replaces symbols into separators and colons to transform filename into a session directory.
	-- 			dir_to_session_filename = dir_to_session_filename, -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
	-- 			autoload_mode = config.AutoloadMode.LastSession, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
	-- 			autosave_last_session = true, -- Automatically save last session on exit and on session switch.
	-- 			autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
	-- 			autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
	-- 			autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
	-- 				"gitcommit",
	-- 				"gitrebase",
	-- 				"neo-tree",
	-- 				"help",
	-- 				"checkhealth"
	-- 			},
	-- 			autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
	-- 			autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
	-- 			max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
	-- 		})
	-- 	end,
	-- },

	-- Session light
	{
		"stevearc/resession.nvim",
		keys = {
			{
				"<leader>ll",
				function()
					require("resession").load("last")
				end,
				silent = true,
			},
			{
				"<leader>ls",
				function()
					require("resession").save()
				end,
			},
			{
				"<leader>lr",
				function()
					require("resession").load()
				end,
			},
			-- { "<leader>lr", ":lua require('resession').load()<CR>" },
		},
		opts = {},
	},
}
