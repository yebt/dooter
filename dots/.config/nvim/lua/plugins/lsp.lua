return {

	--
	-- LSP settings
	{
		"neovim/nvim-lspconfig",
		-- event = { "BufReadPre", "BufNewFile" },
		-- event = "VeryLazy",
		event = "User PostVeryLazy",

		dependencies = {
			-- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", opts = {} }, -- this couse that lua server be slow
			{
				"b0o/schemastore.nvim",
			},
		},

		config = function()
			require("mason").setup()

			local msnlsp = require("mason-lspconfig")
			msnlsp.setup()
			-- default sercver configs
			local default_config = {}
			-- build capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.completion.completionItem.preselectSupport = true
			capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
			capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
			capabilities.textDocument.completion.completionItem.deprecatedSupport = true
			capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
			capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
			capabilities.textDocument.completion.completionItem.resolveSupport =
				{ properties = { "documentation", "detail", "additionalTextEdits" } }
			capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

			default_config.capabilities = capabilities

			-- handlers

			-- LSP server configs
			msnlsp.setup_handlers({
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup(default_config)
				end,

				["lua_ls"] = function()
					-- extend default config
					default_config.settings = {
						Lua = {
							-- runtime = {
							-- 	-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							-- 	-- version = 'LuaJIT',
							-- },
							-- diagnostics = {
							-- 	-- Get the language server to recognize the `vim` global
							-- 	globals = { "vim" },
							-- },
							-- workspace = {
							-- 	checkThirdParty = false,
							-- 	-- Make the server aware of Neovim runtime files
							-- 	-- library = vim.api.nvim_get_runtime_file("", true),
							-- },
							-- -- Do not send telemetry data containing a randomized but unique identifier
							-- telemetry = {
							-- 	enable = false,
							-- },
						},
						-- Lua = {
						-- diagnostics = {
						-- 	globals = { "vim" },
						-- },
						-- workspace = {
						-- 	checkThirdParty = false,
						-- },
						-- completion = {
						-- 	callSnippet = "Replace",
						-- },
						-- },
					}
					-- setup server
					require("lspconfig")["lua_ls"].setup(default_config)
				end,

				["jsonls"] = function()
					-- extend default config
					default_config.settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					}
					-- setup server
					require("lspconfig")["jsonls"].setup(default_config)
				end,

				["yamlls"] = function()
					-- extend default config
					default_config.settings = {
						yaml = {
							schemaStore = {
								-- You must disable built-in schemaStore support if you want to use
								-- this plugin and its advanced options like `ignore`.
								enable = false,
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					}
					-- setup server
					require("lspconfig")["yaml"].setup(default_config)
				end,
			})

			-- linters and formatters
			local null_ls = require("null-ls")

			require("mason-null-ls").setup({
				ensure_installed = {
					-- Opt to list sources here, when available in mason.
					"stylua",
					"jq",
				},
				automatic_installation = false,
				handlers = {
					stylua = function(source_name, methods)
						null_ls.register(
							-- Anything not supported by mason.
							null_ls.builtins.formatting.stylua.with({
								-- from_stderr = true,
								ignore_stderr = false, -- show error
							})
						)
					end,
				},
			})

			null_ls.setup({
				debug = true,
				-- fallback_severity = vim.diagnostic.severity.INFO,
				sources = {
					-- Anything not supported by mason.
					null_ls.builtins.formatting.stylua.with({
						-- from_stderr = true,
						ignore_stderr = false, -- show error
					}),
				},
			})

			-- show status
			local fidget = require("fidget")
			fidget.setup()
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

	-- Linters and Formatters starter
	{
		"jose-elias-alvarez/null-ls.nvim",
	},

	-- bridge with mason & null-ls
	{
		"jay-babu/mason-null-ls.nvim",
	},

	-- formatter new
	-- {
	-- 	"nvimdev/guard.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		local ft = require("guard.filetype")
	-- 		local diag_fmt = require("guard.lint").diag_fmt
	--
	-- 		-- use stylua to format lua files and no linter
	--
	-- 		-- Lua
	-- 		ft("lua"):fmt("stylua")
	--
	-- 		--  Markdown format and linter
	-- 		ft("markdown"):fmt("prettier")
	-- 		:lint({
	-- 			cmd = "markdownlint",
	-- 			args = { "--stdin" },
	-- 			stdin = true,
	-- 			output_fmt = function(result, buf)
	-- 			  vim.notify(vim.inspect(result))
	-- 				local output = vim.split(result, "\n")
	-- 				local patterns = {
	-- 					"E%d+",
	-- 					"W%d+",
	-- 					"C%d+",
	-- 				}
	-- 				local diags = {}
	-- 				for _, line in ipairs(output) do
	-- 					for i, pattern in ipairs(patterns) do
	-- 						if line:find(pattern) then
	-- 							local pos = line:match("py:(%d+:%d+)")
	-- 							local lnum, col = unpack(vim.split(pos, ":"))
	-- 							local mes = line:match("%d:%s(.*)")
	-- 							diags[#diags + 1] = diag_fmt(buf, tonumber(lnum), tonumber(col), mes, i, "pylint")
	-- 						end
	-- 					end
	-- 				end
	--
	-- 				return diags
	-- 			end,
	-- 		})
	--
	-- 		ft('python'):lint('pylint')
	--
	--
	-- 		require("guard").setup({
	-- 			-- the only option for the setup function
	-- 			fmt_on_save = false,
	-- 		})
	-- 	end,
	-- },

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

	-- Status
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		opts = {
			text = {
				spinner = "dots", -- animation shown when tasks are ongoing
				done = "0k", -- character shown when all tasks are complete
				commenced = "Started", -- message shown when task starts
				completed = "Completed", -- message shown when task completes
			},
			-- align = {
			-- 	bottom = false, -- align fidgets along bottom edge of buffer
			-- 	right = true, -- align fidgets along right edge of buffer
			-- },
			window = {
				relative = "win", -- where to anchor, either "win" or "editor"
				blend = 0, -- &winblend for the window
				zindex = nil, -- the zindex value for the window
				border = "single", -- style of border for the fidget window
			},
			sources = { -- Sources to configure
				["null-ls"] = { -- Name of source
					ignore = true, -- Ignore notifications from this source
				},
			},
		},
	},

	-- diagnostic list
	{
		"folke/trouble.nvim",
		cmd = {
			"Trouble",
			"TroubleClose",
			"TroubleToggle",
			"TroubleRefresh",
		},
		opts = {
			{
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 10, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				icons = true, -- use devicons for filenames
				mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
				severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
				fold_open = "", -- icon used for open folds
				fold_closed = "", -- icon used for closed folds
				group = true, -- group results by file
				padding = true, -- add an extra new line on top of the list
				cycle_results = true, -- cycle item list when reaching beginning or end of list
				action_keys = { -- key mappings for actions in the trouble list
					-- map to {} to remove a mapping, for example:
					-- close = {},
					close = "q", -- close the list
					cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r", -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = { "o" }, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
					toggle_preview = "P", -- toggle auto_preview
					hover = "K", -- opens a small popup with the full multiline message
					preview = "p", -- preview the diagnostic location
					close_folds = { "zM", "zm" }, -- close all folds
					open_folds = { "zR", "zr" }, -- open all folds
					toggle_fold = { "zA", "za" }, -- toggle fold of current file
					previous = "k", -- previous item
					next = "j", -- next item
				},
				indent_lines = true, -- add an indent guide below the fold icons
				auto_open = false, -- automatically open the list when you have diagnostics
				auto_close = false, -- automatically close the list when you have no diagnostics
				auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false, -- automatically fold a file trouble list at creation
				auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
				signs = {
					-- icons / text used for a diagnostic
					error = "󰅙",
					warning = "",
					hint = "",
					information = "󰋼",
					other = "",
				},
				use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
			},
		},
	},

	-- Lens
	{
		"VidocqH/lsp-lens.nvim",
		cmd = {
			"LspLensOn",
			"LspLensOff",
			"LspLensToggle",
		},
		opts = {
			enable = true,
			include_declaration = false, -- Reference include declaration
			sections = { -- Enable / Disable specific request
				definition = false,
				references = true,
				implementation = true,
			},
			ignore_filetype = {
				"prisma",
			},
		},
	},

	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		keys = {
			{ "<C-j>", "<cmd>Lspsaga term_toggle<CR>", mode = { "t", "n" }, silent = true, desc = "Toggle term" },
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
		opts = {
			-- symbol_in_winbar = {
			-- 	enable = false,
			-- },
			diagnostic = {
				-- max_height = 0.8,
				keys = {
					quit = { "q", "<ESC>" },
				},
			},
			rename = {
				-- enable = true,
				keymaps = {
					quit = "<ESC>",
					-- exec = "<CR>",
				},
			},
			lightbulb = {
				sign = false,
			},
		},
		config = function(_, opts)
			require("lspsaga").setup(opts)
			vim.g.lspsagaloaded = true
		end,
	},

	--
}
