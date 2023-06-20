return {
  -- comments
  -- {
  --   "terrortylor/nvim-comment",
  --   keys = {
  --     { "gc", mode = { "x", "n" } },
  --   },
  --   opts = {
  --     -- Linters prefer comment and line to have a space in between markers
  --     marker_padding = true,
  --     -- should comment out empty or whitespace only lines
  --     comment_empty = true,
  --     -- trim empty comment whitespace
  --     comment_empty_trim_whitespace = true,
  --     -- Should key mappings be created
  --     create_mappings = true,
  --     -- Normal mode mapping left hand side
  --     line_mapping = "gcc",
  --     -- Visual/Operator mapping left hand side
  --     operator_mapping = "gc",
  --     -- text object mapping, comment chunk,,
  --     comment_chunk_text_object = "ic",
  --     -- Hook function to call before commenting takes place
  --     hook = function()
  --       require("ts_context_commentstring.internal").update_commentstring()
  --     end,
  --   },
  --   config = function(_,opts)
  --     require('nvim_comment').setup {opts}
  --   end
  -- },
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

  -- Autopairs
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    version = false,
    opts = {},
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   opts = {},
  -- },

  -- Lua snips
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    -- keys = {
    --   {
    --     "<tab>",
    --     function()
    --       return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
    --     end,
    --     expr = true, silent = true, mode = "i",
    --   },
    --   { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
    --   { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    -- },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        -- formatting = {
        --   format = function(_, item)
        --     local icons = require("lazyvim.config").icons.kinds
        --     if icons[item.kind] then
        --       item.kind = icons[item.kind] .. item.kind
        --     end
        --     return item
        --   end,
        -- },
        -- experimental = {
        --   ghost_text = {
        --     hl_group = "CmpGhostText",
        --   },
        -- },
      }
    end,
  },
}
