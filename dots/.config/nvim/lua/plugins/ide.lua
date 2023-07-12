return {
	-- file explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{
				"\\",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {

			popup_border_style = "single",
			enable_git_status = true,
			enable_diagnostics = false,
			-- sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			sources = { "filesystem" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
			filesystem = {
				filtered_items = {
					visible = true,
					--hide_hidden = false
				},
				follow_current_file = true,
				use_libuv_file_watcher = true,
				group_empty_dirs = true,
				window = {
					mappings = {
						["i"] = "run_command",
						["O"] = "system_open",
					},
				},
				commands = {
					run_command = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.api.nvim_input(": " .. path .. "<Home>")
					end,
					system_open = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						-- Linux: open file in default application
						vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
					end,
				},
			},
			window = {
				position = "left",
				width = 30,
				mappings = {
					-- deactive
					["<space>"] = "none",
					["a"] = "none",
					["A"] = "none",
					--
					["-"] = "navigate_up",
					["D"] = "delete",
					["d"] = {
						"add_directory",
						config = {
							show_path = "relative", -- "none", "relative", "absolute"
						},
					},
					["%"] = {
						"add",
						-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
						-- some commands may take optional config options, see `:h neo-tree-mappings` for details
						config = {
							show_path = "relative", -- "none", "relative", "absolute"
						},
					},
					["h"] = function(state)
						local node = state.tree:get_node()
						if node.type == "directory" and node:is_expanded() then
							require("neo-tree.sources.filesystem").toggle_directory(state, node)
						else
							require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
						end
					end,
					["l"] = function(state)
						local node = state.tree:get_node()
						if node.type == "directory" then
							if not node:is_expanded() then
								require("neo-tree.sources.filesystem").toggle_directory(state, node)
							elseif node:has_children() then
								require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
							end
						end
					end,
				},
			},
			default_component_configs = {
				indent = {
					indent_size = 2,
					padding = 1, -- extra padding on left hand side
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},

				icon = {
					-- folder_closed = "",
					-- folder_open = "",
					-- folder_empty = "󰍴",

					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
					-- then these will never be used.
					default = "*",
					highlight = "NeoTreeFileIcon",
				},

				modified = {
					symbol = "*",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = true,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "M", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "D", -- this can only be used in the git_status source
						renamed = "R", -- this can only be used in the git_status source
						-- Status type
						untracked = "?",
						ignored = "I",
						unstaged = "U",
						staged = "S",
						conflict = "C",
					},
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(file_path)
						--auto close
						require("neo-tree.sources.manager").close_all()
					end,
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
	},

  -- {
  --   "SidOfc/carbon.nvim",
  -- },


	-- Todo Coments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		-- event = { "BufReadPost", "BufNewFile" },
		event = "VeryLazy",
		config = true,
	},

	-- which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = true, -- adds help for operators like d, y, ...
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
			-- add operators that will trigger motion and text object completion
			-- to enable all native operators, set the preset / operators plugin above
			operators = { gc = "Comments" },
			key_labels = {
				-- override the label used to display some keys. It doesn't effect WK in any other way.
				-- For example:
				-- ["<space>"] = "SPC",
				-- ["<cr>"] = "RET",
				-- ["<tab>"] = "TAB",
			},
			motions = {
				count = true,
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = " ", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group
			},
			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},
			window = {
				border = "none", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
				padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
				zindex = 1000, -- positive value to position WhichKey above other floating windows.
			},
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},
			ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
			show_help = true, -- show a help message in the command line for using WhichKey
			show_keys = true, -- show the currently pressed key and its label as a message in the command line
			triggers = "auto", -- automatically setup triggers
			-- triggers = {"<leader>"} -- or specifiy a list manually
			-- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
			triggers_nowait = {
				-- marks
				"`",
				"'",
				"g`",
				"g'",
				-- registers
				'"',
				"<c-r>",
				-- spelling
				"z=",
			},
			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				-- this is mostly relevant for keymaps that start with a native binding
				i = { "j", "k" },
				v = { "j", "k" },
			},
			-- disable the WhichKey popup for certain buf types and file types.
			-- Disabled by default for Telescope
			disable = {
				buftypes = {},
				filetypes = {},
			},
		},
	},

	-- Folding

	{
		"kevinhwang91/nvim-ufo",
		-- event = "BufRead",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		-- init = function()
		--   vim.o.foldcolumn = "1" -- '0' is not bad
		--   vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		--   vim.o.foldlevelstart = 99
		--   vim.o.foldenable = true
		-- end,
		keys = {
			{ "zR", ":lua require('ufo').openAllFolds ()<CR>" },
			{ "zM", ":lua require('ufo').closeAllFolds() <CR>" },
		},
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { "lsp", "indent" }
				-- return { "treesitter", "indent" }
			end,

			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		},
	},
}
