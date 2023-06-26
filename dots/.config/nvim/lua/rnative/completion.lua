local kinds = {
  Array = " ",
  Boolean = " ",
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Copilot = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = " ",
  Key = " ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Namespace = " ",
  Null = " ",
  Number = " ",
  Object = " ",
  Operator = " ",
  Package = " ",
  Property = " ",
  Reference = " ",
  Snippet = " ",
  String = " ",
  Struct = " ",
  Text = " ",
  TypeParameter = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}
-- function to add two numbers

return {
  -- Snippets
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
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },

  -- autoompletions engine
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = { "InsertEnter" },
    dependencies = {
      -- lsp
      "hrsh7th/cmp-nvim-lsp",
      --  completion
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- snippets
      "saadparwaiz1/cmp_luasnip",
      --
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      --
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      --
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   dependencies = "copilot.lua",
      --   opts = {},
      --   config = function(_, opts)
      --     local copilot_cmp = require("copilot_cmp")
      --     copilot_cmp.setup(opts)
      --     -- attach cmp source whenever copilot attaches
      --     -- fixes lazy-loading issues with the copilot cmp source
      --     vim.api.nvim_create_autocmd("LspAttach", {
      --       callback = function(args)
      --         local buffer = args.buf
      --         local client = vim.lsp.get_client_by_id(args.data.client_id)
      --         if client.name == "copilot" then
      --           copilot_cmp._on_insert_enter({})
      --         end
      --       end,
      --     })
      --   end,
      -- },
    },
    config = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local types = require("cmp.types")

      local select_opts = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({

        performance = {
          debounce = 60,
          throttle = 30,
          fetching_timeout = 100,
          confirm_resolve_timeout = 80,
          async_budget = 1,
          max_view_entries = 200,
        },

        -- preselect = types.cmp.PreselectMode.Item,

        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- local col = vim.fn.col(".") - 1
            if cmp.visible() then
              cmp.select_next_item(select_opts)
              -- elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
              --   fallback()
            elseif require("copilot.suggestion").is_visible() then
              require("copilot.suggestion").accept({})
            else
              -- cmp.complete()
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(select_opts)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        confirmation = {
          default_behavior = types.cmp.ConfirmBehavior.Insert,
          get_commit_characters = function(commit_characters)
            return commit_characters
          end,
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        completion = {
          -- completeopt = 'menu,menuone,noselect',
          completeopt = "menu,menuone,noinsert,noselect",
          -- autocomplete = {
          --   types.cmp.TriggerEvent.TextChanged,
          -- },
          -- keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
          -- keyword_length = 1,
        },

        matching = {
          disallow_fuzzy_matching = false,
          disallow_fullfuzzy_matching = false,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = false,
          disallow_prefix_unmatching = false,
        },

        sources = cmp.config.sources({
          --
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp_document_symbol" },

          -- LSPhrsh7th/cmp-nvim-lsp-document-symbol
          {
            name = "nvim_lsp",
            keyword_length = 1,
            option = {
              php = {
                keyword_pattern = [=[[\%(\$\k*\)\|\k\+]]=],
              },
            },
          },
          -- snipp
          { name = "luasnip", keyword_length = 2, option = { show_autosnippets = true } },
          -- buffer
          {
            name = "buffer",
            keyword_length = 3,
            option = {
              option = {
                -- ALL buffers
                get_bufnrs = function()
                  return vim.api.nvim_list_bufs()
                end,
                -- Visibles
                -- get_bufnrs = function()
                -- 	local bufs = {}
                -- 	for _, win in ipairs(vim.api.nvim_list_wins()) do
                -- 		bufs[vim.api.nvim_win_get_buf(win)] = true
                -- 	end
                -- 	return vim.tbl_keys(bufs)
                -- end,
              },
            },
          },
          { name = "path", option = { trailing_slash = true } },
          -- { name = "copilot", group_index = 2 },
        }),

        formatting = {
          -- fields = { "menu", "abbr", "kind" },
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = "(lsp)",
              luasnip = "⋗",
              buffer = "Ω",
              path = "",
            }
            if kinds[item.kind] then
              item.kind = kinds[item.kind] .. item.kind
            end
            if not item.menu then
              item.menu = menu_icon[entry.source.name]
            end

            -- return item
            return require("tailwindcss-colorizer-cmp").formatter(entry, item)
          end,
        },

        -- formatting = {
        --   format = function(_, item)
        --     local icons = require("lazyvim.config").icons.kinds
        --     if icons[item.kind] then
        --       item.kind = icons[item.kind] .. item.kind
        --     end
        --     return item
        --   end,
        -- },
        --
        -- sorting = {
        --   priority_weight = 2,
        --   comparators = {
        --     require("copilot_cmp.comparators").prioritize,

        --     -- Below is the default comparitor list and order for nvim-cmp
        --     cmp.config.compare.offset,
        --     -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        --     cmp.config.compare.exact,
        --     cmp.config.compare.score,
        --     cmp.config.compare.recently_used,
        --     cmp.config.compare.locality,
        --     cmp.config.compare.kind,
        --     cmp.config.compare.sort_text,
        --     cmp.config.compare.length,
        --     cmp.config.compare.order,
        --   },
        -- },

        -- experimental = {
        --   ghost_text = {
        --     hl_group = "CmpGhostText",
        --   },
        -- },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "bottom", -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = "node", -- Node.js version must be > 16.x
      server_opts_overrides = {},
    },
  },
}
