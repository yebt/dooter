return {
	-- Kanagawa
	{
		"rebelot/kanagawa.nvim",
		opts = {
			compile = true, -- enable compiling the colorscheme
			undercurl = true, -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = false, -- do not set background color
			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
			terminalColors = true, -- define vim.g.terminal_color_{0,17}
			colors = { -- add/modify theme and palette colors

				palette = {},
				theme = {
					wave = {},
					lotus = {},
					dragon = {},
					all = {
						ui = {
							-- #Remove gutter background
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function(colors) -- add/modify highlights
				local theme = colors.theme

				return {
					-- Transparent Floating Windows
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },

					-- Save an hlgroup with dark background and dimmed foreground
					-- so that you can use it where your still want darker windows.
					-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					-- Popular plugins that open floats will link to NormalFloat by default;
					-- set their background accordingly if you wish to keep them dark and borderless
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

					-- Borderless Telescope
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

					-- Dark completion (popup) menu
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
				}
			end,
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "dragon", -- try "dragon" !
				--dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		},
	},

	-- Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			compile_path = vim.fn.stdpath("cache") .. "/catppuccin",

			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- disables setting the background color.
			show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {

			},
			custom_highlights = {},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				telescope = true,
				notify = false,
				mini = true,
				leap = true,
				illuminate = true,
				lsp_saga = true,
				mason = true,
				overseer = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
					inlay_hints = {
						background = true,
					},
				},
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		},
		-- config = function(_, opts)
		-- 	require("catppuccin").setup(opts)
		-- end,
	},

	-- Monokai
	{
		"loctvl842/monokai-pro.nvim",
		opts = {
			transparent_background = false,
			terminal_colors = true,
			devicons = true, -- highlight the icons of `nvim-web-devicons`
			styles = {
				comment = { italic = true },
				keyword = { italic = true }, -- any other keyword
				type = { italic = true }, -- (preferred) int, long, char, etc
				storageclass = { italic = true }, -- static, register, volatile, etc
				structure = { italic = true }, -- struct, union, enum, etc
				parameter = { italic = true }, -- parameter pass in function
				annotation = { italic = true },
				tag_attribute = { italic = true }, -- attribute of tag in reactjs
			},
			filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
			-- Enable this will disable filter option
			day_night = {
				enable = false, -- turn off by default
				day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
				night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
			},
			inc_search = "background", -- underline | background
			background_clear = {
				-- "float_win",
				"toggleterm",
				"telescope",
				"which-key",
				"renamer",
				"notify",
				-- "mason",
				-- "lazy",
				-- "nvim-tree",
				"neo-tree",
				-- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
			}, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
			plugins = {
				bufferline = {
					underline_selected = false,
					underline_visible = false,
				},
				indent_blankline = {
					context_highlight = "default", -- default | pro
					context_start_underline = false,
				},
			},
			---@param c Colorscheme
			override = function(c) end,
		},
	},

	-- Vitesse
	{
		-- "yebt/vitesse.nvim",
		-- url = "git@github.com:yebt/vitesse.nvim.git",
		"2nthony/vitesse.nvim",
		-- "2nthony/vitesse.nvim",
		dependencies = {
			"tjdevries/colorbuddy.nvim",
		},
		-- lazy = false,
		-- priority = 1000,
		--lazy= false,
		-- opts = {
		-- 	comment_italics = true,
		-- 	transparnet_background = false,
		-- 	transparent_float_background = false, -- aka pum(popup menu) background
		-- 	reverse_visual = true,
		-- 	dim_nc = false,
		-- 	cmp_cmdline_disable_search_highlight_group = false, -- disable search highlight group for cmp item
		-- 	-- if `transparent_float_background` false, make telescope border color same as float background
		-- 	telescope_border_follow_float_background = false,
		-- 	-- diagnostic virtual text background, like error lens
		-- 	diagnostic_virtual_text_background = true,
		-- },
		opts = {
			comment_italics = true,
			transparent_background = false,
			transparent_float_background = false, -- aka pum(popup menu) background
			reverse_visual = false,
			dim_nc = false,
			cmp_cmdline_disable_search_highlight_group = false, -- disable search highlight group for cmp item
			-- if `transparent_float_background` false, make telescope border color same as float background
			telescope_border_follow_float_background = true,
			-- diagnostic virtual text background, like error lens
			diagnostic_virtual_text_background = true,
		},
		--config = require("plugins.configs.vitesse"),

	},
}
