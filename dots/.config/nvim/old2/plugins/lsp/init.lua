return {
  -- schemastore
  {
    "b0o/SchemaStore.nvim",
  },
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = { "lua_ls", "rust_analyzer" },
        },
      },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
      })
      -- local signs = { Error = "󰅙 ", Warn = " ", Hint = " ", Info = "󰋼 " }
      local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- local icons = {
      --   Class = " ",
      --   Color = " ",
      --   Constant = " ",
      --   Constructor = " ",
      --   Enum = "了 ",
      --   EnumMember = " ",
      --   Field = " ",
      --   File = " ",
      --   Folder = " ",
      --   Function = " ",
      --   Interface = "ﰮ ",
      --   Keyword = " ",
      --   Method = "ƒ ",
      --   Module = " ",
      --   Property = " ",
      --   Snippet = "﬌ ",
      --   Struct = " ",
      --   Text = " ",
      --   Unit = " ",
      --   Value = " ",
      --   Variable = " ",
      -- }

      -- local kinds = vim.lsp.protocol.CompletionItemKind
      -- for i, kind in ipairs(kinds) do
      --   kinds[i] = icons[kind] or kind
      -- end

      -- local capabilities = vim.tbl_deep_extend(
      --   "force",
      --   {},
      --   vim.lsp.protocol.make_client_capabilities(),
      --   require("cmp_nvim_lsp").default_capabilities()
      -- )
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true


      local lspconfig = require("lspconfig")
      require("plugins.lsp.keys")
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        -- Next, you can provide targeted overrides for specific servers.
        -- ["rust_analyzer"] = function()
        --   require("rust-tools").setup({})
        -- end,
        ["tailwindcss"] = function()
          lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            filetypes = {
              "aspnetcorerazor",
              "astro",
              "astro-markdown",
              "blade",
              "clojure",
              "django-html",
              "htmldjango",
              "edge",
              "eelixir",
              "elixir",
              "ejs",
              "erb",
              "eruby",
              "gohtml",
              "haml",
              "handlebars",
              "hbs",
              "html",
              "html-eex",
              "heex",
              "jade",
              "leaf",
              "liquid",
              -- "markdown",
              "mdx",
              "mustache",
              "njk",
              "nunjucks",
              "php",
              "razor",
              "slim",
              "twig",
              "css",
              "less",
              "postcss",
              "sass",
              "scss",
              "stylus",
              "sugarss",
              "javascript",
              "javascriptreact",
              "reason",
              "rescript",
              "typescript",
              "typescriptreact",
              "vue",
              "svelte",
            },
            settings = {
              tailwindCSS = {
                classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
                lint = {
                  cssConflict = "warning",
                  invalidApply = "error",
                  invalidConfigPath = "error",
                  invalidScreen = "error",
                  invalidTailwindDirective = "error",
                  invalidVariant = "error",
                  recommendedVariantOrder = "warning",
                },
                validate = true,
              },
            },
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                completion = {
                  callSnippet = "Replace",
                },
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
        ["jsonls"] = function()
          --Enable (broadcasting) snippet capability for completion
          capabilities.textDocument.completion.completionItem.snippetSupport = true
          lspconfig.jsonls.setup({
            capabilities = capabilities,
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
            capabilities = capabilities,
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

        ["emmet_ls"] = function()
          lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            init_options = {
              html = {
                options = {
                  -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                  ["bem.enabled"] = true,
                },
              },
            },
            settings = {
              emmet = {
                config = {
                  options = {
                    outputStyle = "expanded",
                  },
                },
              },
            },
          })
        end,
      })

      -- local configs = require'lspconfig.configs'
      -- if not configs.ls_emmet then
      --   configs.ls_emmet = {
      --     default_config = {
      --       cmd = { "ls_emmet", "--stdio" },
      --       filetypes = {
      --         "html",
      --         "css",
      --         "scss",
      --         "javascriptreact",
      --         "typescriptreact",
      --         "haml",
      --         "xml",
      --         "xsl",
      --         "pug",
      --         "slim",
      --         "sass",
      --         "stylus",
      --         "less",
      --         "sss",
      --         "hbs",
      --         "handlebars",
      --       },
      --       root_dir = function(fname)
      --         return vim.loop.cwd()
      --       end,
      --       settings = {},
      --     },
      --   }
      -- end

      -- lspconfig.ls_emmet.setup({ capabilities = capabilities })

      -- Status
      require("fidget").setup({})
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.prettier,
          -- nls.builtins.diagnostics.flake8,
        },
      }
    end,
  },

  -- cmdline tools and lsp servers
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
        "stylua",
        "shfmt",
        -- "flake8",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- Fidget
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    opts = {
      text = {
        spinner = "dots", -- animation shown when tasks are ongoing
        done = "0K", -- character shown when all tasks are complete
        commenced = "Started", -- message shown when task starts
        completed = "Completed", -- message shown when task completes
      },
    },
  },
  -- Trouble
  {
    "folke/trouble.nvim",
    cmd = {
      "Trouble",
      "TroubleClose",
      "TroubleRefresh",
      "TroubleToggle",
    },
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
      code_action = {
        num_shortcut = true,
        show_server_name = false,
        extend_gitsigns = true,
        keys = {
          -- string | table type
          quit = { "q", "<esc>", "<C-c>" },
          exec = "<CR>",
        },
      },
      ui = {
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = "single",
        winblend = 0,
        expand = "",
        collapse = "",
        code_action = "",
        incoming = " ",
        outgoing = " ",
        hover = " ",
        kind = {},
      },
    },
  },

  -- sisgnature Help
  {
    "ray-x/lsp_signature.nvim",
    -- enabled = false,
    event = "LspAttach",
    opts = {
      debug = false, -- set to true to enable debug logging
      log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
      -- default is  ~/.cache/nvim/lsp_signature.log
      verbose = false, -- show debug line number

      bind = true, -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 5, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default

      max_height = 12, -- max height of signature floating_window
      max_width = 80, -- max_width of signature floating_window
      noice = false, -- set to true if you using noice to render markdown
      wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap

      floating_window_off_x = 1, -- adjust float windows x position.
      -- can be either a number or function
      floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
      -- can be either number or function, see examples

      close_timeout = 4000, -- close floating window after ms when laster parameter is entered
      fix_pos = true, -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
      hint_scheme = "String",
      hint_inline = function()
        return false
      end, -- should the hint be inline(nvim 0.10 only)?  default false
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      handler_opts = {
        -- border = "rounded", -- double, rounded, single, shadow, none, or a table of borders
        border = "shadow", -- double, rounded, single, shadow, none, or a table of borders
      },

      always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

      auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
      extra_trigger_chars = { "(", "," }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

      padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

      transparency = nil, -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 36, -- if you using shadow as border use this set the opacity
      shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
      toggle_key_flip_floatwin_setting = false, -- true: toggle float setting after toggle key pressed

      select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
      move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
    },
  },

  -- illuminate
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      -- delay: delay in milliseconds
      delay = 100,
      -- filetype_overrides: filetype specific overrides.
      -- The keys are strings to represent the filetype while the values are tables that
      -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
      filetype_overrides = {},
      -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "Telescope",
        "neo-tree",
      },
      -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
      filetypes_allowlist = {},
      -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
      -- See `:help mode()` for possible values
      modes_denylist = {},
      -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
      -- See `:help mode()` for possible values
      modes_allowlist = {},
      -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
      -- Only applies to the 'regex' provider
      -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
      providers_regex_syntax_denylist = {},
      -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
      -- Only applies to the 'regex' provider
      -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
      providers_regex_syntax_allowlist = {},
      -- under_cursor: whether or not to illuminate under the cursor
      under_cursor = true,
      -- large_file_cutoff: number of lines at which to use large_file_config
      -- The `under_cursor` option is disabled when this cutoff is hit
      large_file_cutoff = nil,
      -- large_file_config: config to use for large files (based on large_file_cutoff).
      -- Supports the same keys passed to .configure
      -- If nil, vim-illuminate will be disabled for large files.
      large_file_overrides = nil,
      -- min_count_to_highlight: minimum number of matches required to perform highlighting
      min_count_to_highlight = 1,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },
}
