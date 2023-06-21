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
    opts = {},

    config = function(opts)
      local util = require("luasnip.util.util")
      local node_util = require("luasnip.nodes.util")
      local types = require("luasnip.util.types")

      local ls = require("luasnip")
      ls.setup({

        -- history = true,
        -- delete_check_events = "TextChanged",

        parser_nested_assembler = function(_, snippet)
          local select = function(snip, no_move)
            snip.parent:enter_node(snip.indx)
            -- upon deletion, extmarks of inner nodes should shift to end of
            -- placeholder-text.
            for _, node in ipairs(snip.nodes) do
              node:set_mark_rgrav(true, true)
            end

            -- SELECT all text inside the snippet.
            if not no_move then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
              node_util.select_node(snip)
            end
          end
          function snippet:jump_into(dir, no_move)
            if self.active then
              -- inside snippet, but not selected.
              if dir == 1 then
                self:input_leave()
                return self.next:jump_into(dir, no_move)
              else
                select(self, no_move)
                return self
              end
            else
              -- jumping in from outside snippet.
              self:input_enter()
              if dir == 1 then
                select(self, no_move)
                return self
              else
                return self.inner_last:jump_into(dir, no_move)
              end
            end
          end
          -- this is called only if the snippet is currently selected.
          function snippet:jump_from(dir, no_move)
            if dir == 1 then
              return self.inner_first:jump_into(dir, no_move)
            else
              self:input_leave()
              return self.prev:jump_into(dir, no_move)
            end
          end
          return snippet
        end,
      })

      ls.config.setup({

        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "#", "Numbier" } },
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { "¡", "Constant" } },
            },
          },
        },
      })
    end,
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
    -- event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   dependencies = "copilot.lua",
      --   opts = {},
      --   config = function(_, opts)
      --     local copilot_cmp = require("copilot_cmp")
      --     function on_attach(on_attach)
      --       vim.api.nvim_create_autocmd("LspAttach", {
      --         callback = function(args)
      --           local buffer = args.buf
      --           local client = vim.lsp.get_client_by_id(args.data.client_id)
      --           on_attach(client, buffer)
      --         end,
      --       })
      --     end
      --     copilot_cmp.setup(opts)
      --     -- attach cmp source whenever copilot attaches
      --     -- fixes lazy-loading issues with the copilot cmp source
      --     on_attach(function(client)
      --       if client.name == "copilot" then
      --         copilot_cmp._on_insert_enter({})
      --       end
      --     end)
      --   end,
      -- },
    },
    opts = function()
      local kinds = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = "c ",
        Copilot = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
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

      local get_icon = require("nvim-web-devicons").get_icon
      local types = require("cmp.types")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
          autocomplete = {
            types.cmp.TriggerEvent.TextChanged,
          },
          keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
          -- keyword_length = 3,
        },
        performance = {
          debounce = 60,
          throttle = 30,
          -- fetching_timeout = 500,
          fetching_timeout = 100,
          async_budget = 1,
          max_view_entries = 200,
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        confirm = {
          -- default_behavior = cmp.ConfirmBehavior.Insert,
          behavior = cmp.ConfirmBehavior.Replace,
        },
        preselect = types.cmp.PreselectMode.Item, --

        matching = {
          disallow_fuzzy_matching = false,
          disallow_fullfuzzy_matching = false,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = false,
          disallow_prefix_unmatching = false,
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
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
              -- elseif has_words_before() then
              --   cmp.complete()
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            option = {
              php = {
                keyword_pattern = [=[[\%(\$\k*\)\|\k\+]]=],
              },
            },
          },
          -- { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp_document_symbol" },
        }, {
          {
            name = "luasnip",
          },
          {
            name = "buffer",
            -- visible
            -- option = {
            --   get_bufnrs = function()
            --     local bufs = {}
            --     for _, win in ipairs(vim.api.nvim_list_wins()) do
            --       bufs[vim.api.nvim_win_get_buf(win)] = true
            --     end
            --     return vim.tbl_keys(bufs)
            --   end,
            -- },
            -- all buffers
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
              keyword_length = 3,
            },
          },
          {
            name = "path",
            option = {
              -- Options go into this table
              trailing_slash = true,
            },
          },
          -- { name = "copilot", group_index = 2 },
        }),
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

        -- formatting = {
        --   format = function(_, item)
        --     local ik = kinds[item.kind]
        --     if ik  then
        --       item.kind = ik .. item.kind
        --     end
        --     return item
        --   end,
        -- },

        -- experimental = {
        --   ghost_text = {
        --     hl_group = "CmpGhostText",
        --   },
        -- },

        -- formatting = {
        --   fields = { "kind", "abbr", "menu" },
        --   format = function(entry, vim_item)
        --     local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        --     local strings = vim.split(kind.kind, "%s", { trimempty = true })
        --     kind.kind = " " .. (strings[1] or "") .. " "
        --     kind.menu = "    (" .. (strings[2] or "") .. ")"

        --     return kind
        --   end,
        -- },

        -- formatting = {
        --   format = function(_, vim_item)
        --     vim_item.kind = (kinds[vim_item.kind] or "") .. vim_item.kind
        --     return vim_item
        --   end,
        -- },

        -- formatting = {
        --   -- fields = { "kind", "abbr" },
        --   fields = { "kind", "abbr", "menu" },
        --   format = function(_, vim_item)
        --     vim_item.kind = kinds[vim_item.kind] or ""
        --     return vim_item
        --   end,
        -- },

        --
        formatting = {
          -- fields = { "kind", "abbr" },
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            --
            if vim.tbl_contains({ "path" }, entry.source.name) then
              local icon, hl_group = get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            vim_item.kind = kinds[vim_item.kind] or ""
            return vim_item
          end,
        },

        --
      }
    end,
  },
}
