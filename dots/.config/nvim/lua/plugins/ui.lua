return {

	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	-- Satelite
	{
		"lewis6991/satellite.nvim",
		cmd = { "SatelliteDisable", "SatelliteEnable", "SatelliteRefresh" },
		-- event = "VeryLazy",
		-- lazy=false,
		opts = {
			current_only = false,
			winblend = 50,
			zindex = 40,
			excluded_filetypes = {},
			width = 2,
			handlers = {
				cursor = {
					enable = true,
					-- Supports any number of symbols
					symbols = { "⎺", "⎻", "⎼", "⎽" },
					-- symbols = { '⎻', '⎼' }
					-- Highlights:
					-- - SatelliteCursor (default links to NonText
				},
				search = {
					enable = true,
					-- Highlights:
					-- - SatelliteSearch (default links to Search)
					-- - SatelliteSearchCurrent (default links to SearchCurrent)
				},
				diagnostic = {
					enable = true,
					signs = { "-", "=", "≡" },
					min_severity = vim.diagnostic.severity.HINT,
					-- Highlights:
					-- - SatelliteDiagnosticError (default links to DiagnosticError)
					-- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
					-- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
					-- - SatelliteDiagnosticHint (default links to DiagnosticHint)
				},
				gitsigns = {
					enable = true,
					signs = { -- can only be a single character (multibyte is okay)
						add = "│",
						change = "│",
						delete = "-",
					},
					-- Highlights:
					-- SatelliteGitSignsAdd (default links to GitSignsAdd)
					-- SatelliteGitSignsChange (default links to GitSignsChange)
					-- SatelliteGitSignsDelete (default links to GitSignsDelete)
				},
				marks = {
					enable = true,
					show_builtins = false, -- shows the builtin marks like [ ] < >
					key = "m",
					-- Highlights:
					-- SatelliteMark (default links to Normal)
				},
				quickfix = {
					signs = { "-", "=", "≡" },
					-- Highlights:
					-- SatelliteQuickfix (default links to WarningMsg)
				},
			},
		},
	},

	--
	-- {
	--   "petertriho/nvim-scrollbar",
	--   event = "VeryLazy",
	--   opts = {
	--     show = true,
	--     show_in_active_only = false,
	--     set_highlights = true,
	--     folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
	--     max_lines = false, -- disables if no. of lines in buffer exceeds this
	--     hide_if_all_visible = false, -- Hides everything if all lines are visible
	--     throttle_ms = 100,
	--     handle = {
	--       text = " ",
	--       blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
	--       color = nil,
	--       color_nr = nil, -- cterm
	--       highlight = "CursorColumn",
	--       hide_if_all_visible = true, -- Hides handle if all lines are visible
	--     },
	--     marks = {
	--       Cursor = {
	--         text = "•",
	--         priority = 0,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "Normal",
	--       },
	--       Search = {
	--         text = { "-", "=" },
	--         priority = 1,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "Search",
	--       },
	--       Error = {
	--         text = { "-", "=" },
	--         priority = 2,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "DiagnosticVirtualTextError",
	--       },
	--       Warn = {
	--         text = { "-", "=" },
	--         priority = 3,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "DiagnosticVirtualTextWarn",
	--       },
	--       Info = {
	--         text = { "-", "=" },
	--         priority = 4,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "DiagnosticVirtualTextInfo",
	--       },
	--       Hint = {
	--         text = { "-", "=" },
	--         priority = 5,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "DiagnosticVirtualTextHint",
	--       },
	--       Misc = {
	--         text = { "-", "=" },
	--         priority = 6,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "Normal",
	--       },
	--       GitAdd = {
	--         text = "┆",
	--         priority = 7,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "GitSignsAdd",
	--       },
	--       GitChange = {
	--         text = "┆",
	--         priority = 7,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "GitSignsChange",
	--       },
	--       GitDelete = {
	--         text = "▁",
	--         priority = 7,
	--         gui = nil,
	--         color = nil,
	--         cterm = nil,
	--         color_nr = nil, -- cterm
	--         highlight = "GitSignsDelete",
	--       },
	--     },
	--     excluded_buftypes = {
	--       "terminal",
	--     },
	--     excluded_filetypes = {
	--       "cmp_docs",
	--       "cmp_menu",
	--       "noice",
	--       "prompt",
	--       "TelescopePrompt",
	--     },
	--     autocmd = {
	--       render = {
	--         "BufWinEnter",
	--         "TabEnter",
	--         "TermEnter",
	--         "WinEnter",
	--         "CmdwinLeave",
	--         "TextChanged",
	--         "VimResized",
	--         "WinScrolled",
	--       },
	--       clear = {
	--         "BufWinLeave",
	--         "TabLeave",
	--         "TermLeave",
	--         "WinLeave",
	--       },
	--     },
	--     handlers = {
	--       cursor = true,
	--       diagnostic = true,
	--       gitsigns = true, -- Requires gitsigns
	--       handle = true,
	--       search = true, -- Requires hlslens
	--       ale = false, -- Requires ALE
	--     },
	--   },
	-- },

	-- Status COl
	{
		"luukvbaal/statuscol.nvim",
		event = "User PostVeryLazy",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				-- configuration goes here, for example:
				-- relculright = true,
				segments = {
					-- FOLD
					{
						text = { builtin.foldfunc },
						click = "v:lua.ScFa",
					},
					-- Diagnostics
					{
						sign = { name = { "Diagnostic" }, maxwidth = 1, colwidth = 1, auto = true },
						click = "v:lua.ScSa",
					},
					-- GIT SIGNS
					{
						sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true, wrap = true },
						click = "v:lua.ScSa",
					},
					-- NUMS
					{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			})
		end,
	},

	--
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	event = "User PostVeryLazy",
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	opts = {
	-- 		options = {
	-- 			icons_enabled = true,
	-- 			theme = "auto",
	-- 			component_separators = { left = "", right = "" },
	-- 			section_separators = { left = "", right = "" },
	-- 			disabled_filetypes = {
	-- 				statusline = {},
	-- 				winbar = {},
	-- 			},
	-- 			ignore_focus = {},
	-- 			always_divide_middle = true,
	-- 			globalstatus = true,
	-- 			refresh = {
	-- 				statusline = 1000,
	-- 				tabline = 1000,
	-- 				winbar = 1000,
	-- 			},
	-- 		},
	--
	-- 		sections = {
	-- 			lualine_a = {},
	-- 			lualine_b = { "branch" },
	-- 			lualine_c = { { "filename", path = 1 }, "%=", "diagnostics"},
	-- 			lualine_x = { "filetype" },
	-- 			lualine_y = { "progress" },
	-- 			lualine_z = {
	-- 				"location",
	-- 				{
	-- 					"mode",
	-- 					fmt = function(str)
	-- 						return str:sub(1, 1)
	-- 					end,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
}
