return {
  -- schemastore
  {
    "b0o/SchemaStore.nvim",
  },
  -- LSP CONFIG
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
      },
      --
      "jose-elias-alvarez/typescript.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      local lspconfig = require("lspconfig")
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
      lsp_defaults.capabilities.textDocument.completion.completionItem.snippetSupport = true

      lsp_defaults.capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      --
      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = "",
        })
      end

      -- sign({ name = "DiagnosticSignError", text = "✘" })
      -- sign({ name = "DiagnosticSignWarn", text = "▲" })
      -- sign({ name = "DiagnosticSignHint", text = "⚑" })
      -- sign({ name = "DiagnosticSignInfo", text = "" })

      -- sign({ name = "DiagnosticSignError", text = " " })
      -- sign({ name = "DiagnosticSignWarn", text = " " })
      -- sign({ name = "DiagnosticSignHint", text = " " })
      -- sign({ name = "DiagnosticSignInfo", text = " " })

      -- sign({ name = "DiagnosticSignError", text = "󰅙 " })
      -- sign({ name = "DiagnosticSignWarn", text = " " })
      -- sign({ name = "DiagnosticSignHint", text = " " })
      -- sign({ name = "DiagnosticSignInfo", text = " " })

      sign({ name = "DiagnosticSignError", text = "E" })
      sign({ name = "DiagnosticSignWarn", text = "W" })
      sign({ name = "DiagnosticSignHint", text = "?" })
      sign({ name = "DiagnosticSignInfo", text = "i" })

      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        update_in_insert = true,
        -- float = {
        --   border = "rounded",
        --   source = "always",
        -- },
      })

      local handlers = {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({})
        end,
        -- Next, you can provide targeted overrides for specific servers.
        -- ["rust_analyzer"] = function()
        --   require("rust-tools").setup({})
        -- end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,

        ["jsonls"] = function()
          --Enable (broadcasting) snippet capability for completion
          lspconfig.jsonls.setup({
            -- capabilities = capabilities,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
            -- commands = {
            --   Formatss = {
            --     function()
            --       vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
            --     end,
            --   },
            -- },
            -- settings = {
            --   json = {
            --     schemas = require("schemastore").json.schemas(),
            --     validate = { enable = true },
            --   },
            -- },
          })
        end,
        ["yamlls"] = function()
          lspconfig.yamlls.setup({
            settings = {
              yaml = {
                schemaStore = {
                  enable = false,
                },
                schemas = require("schemastore").yaml.schemas(),
              },
            },
          })
        end,
      }

      require("mason-lspconfig").setup_handlers(handlers)

      -- lspconfig.lua_ls.setup({})

      --
      --
      --
      require("fidget").setup({
        single_file_support = true,
        flags = {
          debounce_text_changes = 150,
        },
      })
    end,
  },
  -- MASON
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        -- "flake8",
      },

      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  -- MASON LSPCONFIG
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "rust_analyzer" },

      -- See `:h mason-lspconfig.setup_handlers()`
      ---@type table<string, fun(server_name: string)>?
      handlers = nil,
    },
  },
  -- NULL-LS
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
    -- opts = function()
    --   local nls = require("null-ls")
    --   return {
    --     root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
    --     sources = {
    --       nls.builtins.formatting.fish_indent,
    --       nls.builtins.diagnostics.fish,
    --       nls.builtins.formatting.stylua,
    --       nls.builtins.formatting.shfmt,
    --       -- nls.builtins.diagnostics.flake8,
    --       nls.builtins.formatting.autopep8,
    --       nls.builtins.diagnostics.flake8,
    --     },
    --   }
    -- end,
    config = function()
      require("mason").setup()
      require("mason-null-ls").setup({
        ensure_installed = {
          -- Opt to list sources here, when available in mason.
        },
        automatic_installation = false,
        handlers = {},
      })
      require("null-ls").setup({
        sources = {
          -- Anything not supported by mason.
        },
      })
    end,
  },
  --
  { "j-hui/fidget.nvim", tag = "legacy" },

  --
  -- references
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  -- trouble
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    opts = {
      use_diagnostic_signs = true,
    },
  },
  -- lsp saga
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      ui = {
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = "single",
        winblend = 0,
        expand = "›",
        collapse = "",
        code_action = "",
        incoming = " ",
        outgoing = " ",
        hover = " ",
        -- kind = {},
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      },
    },
  },
}
