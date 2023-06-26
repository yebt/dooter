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
    -- opts
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
