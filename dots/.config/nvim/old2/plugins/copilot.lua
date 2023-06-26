return {
  -- == COPILOT LIKE TABNINE
  -- -- copilot
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "InsertEnter",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = true,
  --       help = true,
  --       lua = true
  --     },
  --   },
  -- },
  -- -- copilot cmp source
  -- {
  --   "nvim-cmp",
  --   dependencies = {
  --     {
  --       "zbirenbaum/copilot-cmp",
  --       dependencies = "copilot.lua",
  --       opts = {},
  --       config = function(_, opts)
  --         local copilot_cmp = require("copilot_cmp")
  --         copilot_cmp.setup(opts)
  --         -- attach cmp source whenever copilot attaches
  --         -- fixes lazy-loading issues with the copilot cmp source
  --         function on_attach(on_attach)
  --           vim.api.nvim_create_autocmd("LspAttach", {
  --             callback = function(args)
  --               local buffer = args.buf
  --               local client = vim.lsp.get_client_by_id(args.data.client_id)
  --               on_attach(client, buffer)
  --             end,
  --           })
  --         end

  --         on_attach(function(client)
  --           if client.name == "copilot" then
  --             copilot_cmp._on_insert_enter({})
  --           end
  --         end)
  --       end,
  --     },
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local cmp = require("cmp")

  --     table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })

  --     opts.sorting = {
  --       priority_weight = 2,
  --       comparators = {
  --         require("copilot_cmp.comparators").prioritize,

  --         -- Below is the default comparitor list and order for nvim-cmp
  --         cmp.config.compare.offset,
  --         -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
  --         cmp.config.compare.exact,
  --         cmp.config.compare.score,
  --         cmp.config.compare.recently_used,
  --         cmp.config.compare.locality,
  --         cmp.config.compare.kind,
  --         cmp.config.compare.sort_text,
  --         cmp.config.compare.length,
  --         cmp.config.compare.order,
  --       },
  --     }
  --   end,
  -- },

  -- Copilot from vim
  {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = "Copilot",
    build = ":Copilot setup",
    init = function()
      vim.g.copilot_enabled = 1
      vim.g.copilot_filetypes = {
        markdown = true,
        help = true,
        lua = true,
      }
      vim.g.copilot_no_tab_map = true
      vim.cmd([[imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")]])
    end,
  },
}
