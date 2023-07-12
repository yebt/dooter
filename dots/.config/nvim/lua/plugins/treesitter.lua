return {
	-- treesitter engine
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		--event = { "BufReadPost", "BufNewFile" },
		event = "VeryLazy",
		cmd = { "TSUpdateSync" },
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		--lazy = false,
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- disable rtp plugin, as we only need its queries for mini.ai
					-- In case other textobject modules are enabled, we will load them
					-- once nvim-treesitter is loaded
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					load_textobjects = true
				end,
			},

			-- {
			-- 	"theHamsta/nvim-treesitter-pairs",
			-- },
		},
		opts = {
			highlight = { enable = true },
			-- indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
				filetypes = {
					"html",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"tsx",
					"jsx",
					"rescript",
					"xml",
					"php",
					"markdown",
					"astro",
					"glimmer",
					"handlebars",
					"hbs",
					skip_tags = {
						"area",
						"base",
						"br",
						"col",
						"command",
						"embed",
						"hr",
						"img",
						"slot",
						"input",
						"keygen",
						"link",
						"meta",
						"param",
						"source",
						"track",
						"wbr",
						"menuitem",
					},
				},
			},

			-- Pairs resolver
			-- pairs = {
			-- 	enable = true,
			-- 	disable = {},
			-- 	highlight_pair_events = {}, -- e.g. {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
			-- 	highlight_self = false, -- whether to highlight also the part of the pair under cursor (or only the partner)
			-- 	goto_right_end = false, -- whether to go to the end of the right partner or the beginning
			-- 	fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
			-- 	keymaps = {
			-- 		goto_partner = "%",
			-- 		delete_balanced = "X",
			-- 	},
			-- 	delete_balanced = {
			-- 		only_on_first_char = false, -- whether to trigger balanced delete when on first character of a pair
			-- 		fallback_cmd_normal = nil, -- fallback command when no pair found, can be nil
			-- 		longest_partner = false, -- whether to delete the longest or the shortest pair when multiple found.
			-- 		-- E.g. whether to delete the angle bracket or whole tag in  <pair> </pair>
			-- 	},
			-- },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- Rainbow brakets
	-- {
	-- 	url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
	-- 	event = "VeryLazy",
	-- },

	-- Ts autotag
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
	},

	-- comment strign
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},

	-- Pairs resolver
	{
		"andymass/vim-matchup",
		event = "VeryLazy",
		init = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			--vim.g.matchup_transmute_enabled = 1
			vim.g.matchup_matchparen_deferred = 1 -- improve the perfomance
		end,
	},
}
