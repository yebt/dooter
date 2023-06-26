return {
  -- Autopairs
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

  -- Mini comment
  {
    "echasnovski/mini.comment",
    version = "*",
    keys = {
      { "gc", mode = { "x", "n" } },
    },
    opts = {
      -- No need to copy this inside `setup()`. Will be used automatically.
      -- Options which control module behavior
      options = {
        -- Function to compute custom 'commentstring' (optional)
        -- custom_commentstring = nil,
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,

        -- Whether to ignore blank lines
        ignore_blank_line = true,

        -- Whether to recognize as comment only lines without indent
        start_of_line = false,

        -- Whether to ensure single space pad for comment parts
        pad_comment_parts = true,
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = "gc",

        -- Toggle comment on current line
        comment_line = "gcc",

        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        textobject = "gc",
      },

      -- Hook functions to be executed at certain stage of commenting
      --   hooks = {
      --     -- Before successful commenting. Does nothing by default.
      --     pre = function() end,
      --     -- After successful commenting. Does nothing by default.
      --     post = function() end,
      --   },
    },
  },

}
