return {
	-- Autopairs
	-- {
	-- 	"echasnovski/mini.pairs",
	-- 	-- event = "VeryLazy",
	-- 	event = "InsertEnter",
	-- },

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			local nau = require("nvim-autopairs")
			-- Add rules
			local Rule = require("nvim-autopairs.rule")
			local ts_conds = require("nvim-autopairs.ts-conds")

			nau.setup(opts)

			-- Rures
			nau.add_rules({
				Rule("/**", "*/", "php"),
				-- Vue rule to add space
				-- Typing {  when {| -> {{ }} in vue files
				Rule("{{", "  }", "vue"):set_end_pair_length(2):with_pair(ts_conds.is_ts_node("text")),

				-- Typing = when () -> () => {|}
				Rule("%(.*%)%s*%=$", "> {}", { "typescript", "typescriptreact", "javascript", "vue" })
					:use_regex(true)
					:set_end_pair_length(1),

				-- Typing n when the| -> then|end
				-- Rule("then", "end", "lua"):end_wise(function(opts)
				--   return string.match(opts.line, "^%s*if") ~= nil
				-- end),
			})
		end,
	},

	-- Comment sistem
	{
		"echasnovski/mini.comment",
		version = "*",
		keys = {
			{ "gc", mode = { "n", "x" }, desc = "Toggle comment" },
		},
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},
}
