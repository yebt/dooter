return {

	-- LSP settings
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			-- { "folke/neodev.nvim", opts = {} }, -- this couse that lua server be slow
		},

		config = function()
			require("mason").setup()

			local msnlsp = require("mason-lspconfig")
			msnlsp.setup()
			-- default sercver configs
			local default_config = {}
			--
			msnlsp.setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup(default_config)
				end,

				["lua_ls"] = function()
					-- extend default config
					default_config.settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							-- workspace = {
							-- 	checkThirdParty = false,
							-- },
							-- completion = {
							-- 	callSnippet = "Replace",
							-- },
						},
					}
					-- setup server
					require("lspconfig")["lua_ls"].setup(default_config)
				end,
			})
		end,
	},

	-- Packager
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		cmd = {
			"Mason",
			"MasonUpdate",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- Bridge Mason & LSP config
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls" },
			automatic_installation = false,
		},
	},

	-- Linters and Formatters
	{
	  "jose-elias-alvarez/null-ls.nvim"
	}

	-- -- Linting
	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	-- event = "BufWritePost",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("lint").linters_by_ft = {
	-- 			python = { "flake8" },
	-- 			json ={"jsonlint"}
	-- 		}
	-- 		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	-- 			callback = function()
	-- 				require("lint").try_lint()
	-- 			end,
	-- 		})
	--      require("lint").try_lint()
	-- 	end,
	-- },
	--
	-- -- Formatter
	-- {
	-- 	"mhartington/formatter.nvim",
	-- 	cmd = {
	-- 		"Format",
	-- 		"FormatWrite",
	-- 		"FormatLock",
	-- 		"FormatWriteLock",
	-- 	},
	-- 	keys = {
	-- 		{ "<C-f>", "<cmd>Format<CR>" },
	-- 	},
	-- 	config = function()
	-- 		require("formatter").setup({
	-- 			logging = true,
	-- 			log_level = vim.log.levels.DEBUG,
	-- 			filetype = {
	-- 				lua = {
	-- 					require("formatter.filetypes.lua").stylua,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
