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

	-- indent scope
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		-- event = { "BufReadPre", "BufNewFile" },
		event = "VeryLazy",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function()
			local mini_is = require("mini.indentscope")
			mini_is.setup({
				-- options go here
				draw = {
					delay = 100,
					animation = mini_is.gen_animation.none(),
				},
				options = {
					-- Type of scope's border: which line(s) with smaller indent to
					-- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
					border = "both",

					-- Whether to use cursor column when computing reference indent.
					-- Useful to see incremental scopes with horizontal cursor movements.
					indent_at_cursor = true,

					-- Whether to first check input line to be a border of adjacent scope.
					-- Use it if you want to place cursor on function header to get scope of
					-- its body.
					try_as_border = false,
				},

				-- Which character to use for drawing scope indicator
				-- symbol = "▏",
				symbol = "│",
			})
		end,
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		-- event = { "BufReadPost", "BufNewFile" },
		event = "VeryLazy",
		opts = {
			-- char = "▏",
			char = "│",
			filetype_exclude = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			show_trailing_blankline_indent = false,
			show_current_context = false,
		},
	},

	-- notifications

	-- {
	-- 	"vigoux/notifier.nvim",
	-- 	-- event = "VeryLazy",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("notifier").setup({
	-- 			-- You configuration here
	-- 			ignore_messages = {}, -- Ignore message from LSP servers with this name
	-- 			status_width = something, -- COmputed using 'columns' and 'textwidth'
	-- 			components = { -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
	-- 				"nvim", -- Nvim notifications (vim.notify and such)
	-- 				"lsp", -- LSP status updates
	-- 			},
	-- 			notify = {
	-- 				clear_time = 5000, -- Time in milliseconds before removing a vim.notify notification, 0 to make them sticky
	-- 				min_level = vim.log.levels.TRACE, -- Minimum log level to print the notification
	-- 			},
	-- 			component_name_recall = false, -- Whether to prefix the title of the notification by the component name
	-- 			zindex = 50, -- The zindex to use for the floating window. Note that changing this value may cause visual bugs with other windows overlapping the notifier window.
	-- 		})
	-- 	end,
	-- },

	-- noice
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- 	config = function()
	-- 		require("noice").setup({
	-- 			cmdline = {
	-- 				enabled = false,
	-- 				    view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
	-- 			},
	-- 			messages = {
	-- 				enabled = true, -- enables the Noice messages UI
	-- 				view = "mini", -- default view for messages
	-- 				view_error = "mini", -- view for errors
	-- 				view_warn = "mini", -- view for warnings
	-- 				view_history = "messages", -- view for :messages
	-- 				view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
	-- 			},
	-- 			popupmenu = {
	-- 				enabled = false, -- enables the Noice popupmenu UI
	-- 				---@type 'nui'|'cmp'
	-- 				backend = "nui", -- backend to use to show regular cmdline completions
	-- 				---@type NoicePopupmenuItemKind|false
	-- 				-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
	-- 				kind_icons = {}, -- set to `false` to disable icons
	-- 			},
	-- 			-- default options for require('noice').redirect
	-- 			-- see the section on Command Redirection
	-- 			---@type NoiceRouteConfig
	-- 			redirect = {
	-- 				view = "popup",
	-- 				filter = { event = "msg_show" },
	-- 			},
	-- 			notify = {
	-- 				-- Noice can be used as `vim.notify` so you can route any notification like other messages
	-- 				-- Notification messages have their level and other properties set.
	-- 				-- event is always "notify" and kind can be any log level as a string
	-- 				-- The default routes will forward notifications to nvim-notify
	-- 				-- Benefit of using Noice for this is the routing and consistent history view
	-- 				enabled = true,
	-- 				view = "mini",
	-- 			},
	-- 			lsp = {
	-- 				progress = {
	-- 					enabled = true,
	-- 					-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
	-- 					-- See the section on formatting for more details on how to customize.
	-- 					--- @type NoiceFormat|string
	-- 					format = "lsp_progress",
	-- 					--- @type NoiceFormat|string
	-- 					format_done = "lsp_progress_done",
	-- 					throttle = 1000 / 30, -- frequency to update lsp progress message
	-- 					view = "mini",
	-- 				},
	-- 				override = {
	-- 					-- override the default lsp markdown formatter with Noice
	-- 					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 					-- override the lsp markdown formatter with Noice
	-- 					["vim.lsp.util.stylize_markdown"] = true,
	-- 					-- override cmp documentation with Noice (needs the other options to work)
	-- 					["cmp.entry.get_documentation"] = true,
	-- 				},
	-- 				hover = {
	-- 					enabled = true,
	-- 					silent = false, -- set to true to not show a message if hover is not available
	-- 					view = nil, -- when nil, use defaults from documentation
	-- 					---@type NoiceViewOptions
	-- 					opts = {}, -- merged with defaults from documentation
	-- 				},
	-- 				signature = {
	-- 					enabled = true,
	-- 					auto_open = {
	-- 						enabled = true,
	-- 						trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
	-- 						luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
	-- 						throttle = 50, -- Debounce lsp signature help request by 50ms
	-- 					},
	-- 					view = nil, -- when nil, use defaults from documentation
	-- 					---@type NoiceViewOptions
	-- 					opts = {}, -- merged with defaults from documentation
	-- 				},
	-- 				message = {
	-- 					-- Messages shown by lsp servers
	-- 					enabled = true,
	-- 					view = "mini",
	-- 					opts = {},
	-- 				},
	-- 				-- defaults for hover and signature help
	-- 				documentation = {
	-- 					view = "hover",
	-- 					---@type NoiceViewOptions
	-- 					opts = {
	-- 						lang = "markdown",
	-- 						replace = true,
	-- 						render = "plain",
	-- 						format = { "{message}" },
	-- 						win_options = { concealcursor = "n", conceallevel = 3 },
	-- 					},
	-- 				},
	-- 			},
	-- 			markdown = {
	-- 				hover = {
	-- 					["|(%S-)|"] = vim.cmd.help, -- vim help links
	-- 					["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
	-- 				},
	-- 				highlights = {
	-- 					["|%S-|"] = "@text.reference",
	-- 					["@%S+"] = "@parameter",
	-- 					["^%s*(Parameters:)"] = "@text.title",
	-- 					["^%s*(Return:)"] = "@text.title",
	-- 					["^%s*(See also:)"] = "@text.title",
	-- 					["{%S-}"] = "@parameter",
	-- 				},
	-- 			},
	-- 			presets = {
	-- 				-- you can enable a preset by setting it to true, or a table that will override the preset config
	-- 				-- you can also add custom presets that you can enable/disable with enabled=true
	-- 				bottom_search = false, -- use a classic bottom cmdline for search
	-- 				command_palette = false, -- position the cmdline and popupmenu together
	-- 				long_message_to_split = false, -- long messages will be sent to a split
	-- 				inc_rename = true, -- enables an input dialog for inc-rename.nvim
	-- 				lsp_doc_border = true, -- add a border to hover docs and signature help
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
