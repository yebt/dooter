return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "\\",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree",
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
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<space>"] = "none",
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
        },
      },
      default_component_configs = {
        indent = {
          -- indent_size = 2,
          -- padding = 1, -- extra padding on left hand side
          with_expanders = false, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },

        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰍴",

          -- folder_closed = "",
          -- folder_open = "",
          -- folder_empty = "",
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

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    keys = {
      {
        "<leader>T",
        ":Telescope<CR>",
      },
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files({
            prompt_prefix = " ",
            prompt_title = "",
            -- selection_caret = "* ",
            multi_icon = "-",
            attach_mappings = function(_, map)
              map("i", "<ESC>", require("telescope.actions").close)
              return true
            end,
            results_title = false,
            sorting_strategy = "ascending",
            layout_strategy = "center",
            layout_config = {
              -- preview_cutoff = 1, -- Preview should always show (unless previewer = false)
              width = 0.5,
              height = 12,
              -- preview_cutoff = 120,
              anchor = "N",
            },
            border = true,
            borderchars = {
              prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
              results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
              preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
          })
        end,
        silent = true,
        desc = "Telescope fast ff",
      },
    },
  },
  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
}
