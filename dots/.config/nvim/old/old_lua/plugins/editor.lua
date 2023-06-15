local Util = require("util")

return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "\\",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        "Explroter NeoTree (cwd)",
      },
      -- {
      --   "<leader>fe",
      --   function()
      --     require("neo-tree.command").execute({ toggle = true, dir = Util.get_root() })
      --   end,
      --   desc = "Explorer NeoTree (root dir)",
      -- },
      -- {
      --   "<leader>fE",
      --   function()
      --     require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      --   end,
      --   desc = "Explorer NeoTree (cwd)",
      -- },
      -- { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      -- { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
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
      sources = { "filesystem", "git_status" },
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
        },
      },
      default_component_configs = {
        indent = {
          indent_size = 1,
          padding = 1, -- extra padding on left hand side
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

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
    opts = {
      live_update = true,
      --line_sep_start = "┌-----------------------------------------",
      line_sep_start = "┌─────────────────────────────────────────",
      --result_padding = "¦  ",
      result_padding = " ├─ ",
      --line_sep = "└-----------------------------------------",
      line_sep = "└─────────────────────────────────────────",
    },
  },

  -- Motions
  {
    "ggandor/flit.nvim",
    keys = {
      { "T", mode = { "n", "x", "o" } },
      { "t", mode = { "n", "x", "o" } },
      { "F", mode = { "n", "x", "o" } },
      { "f", mode = { "n", "x", "o" } },
      { ";", mode = { "n", "x", "o" } },
      { ",", mode = { "n", "x", "o" } },
    },
    -- keys = function()
    --   ---@type LazyKeys[]
    --   local ret = {}
    --   for _, key in ipairs({ "f", "F", "t", "T" }) do
    --     ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
    --   end
    --   return ret
    -- end,
    opts = { labeled_modes = "nx" },
  },

  -- Lesap
  {
    "ggandor/leap.nvim",
    keys = {
      {
        "<leader><leader>s",
        ":lua require('leap').leap ({ target_windows = {  vim.fn.win_getid() } })<CR>",
       mode = { "n", "x" },
      },
    },
    opts = {
      -- highlight_unlabeled_phase_one_targets = true,
      -- max_highlighted_traversal_targets = 10,
      -- case_sensitive = false,
      -- equivalence_classes = { " \t\r\n" },
      -- substitute_chars = {},
      --  -- safe_labels = { "s", "f", "n", "u", "t" },
      --  safe_labels = { "s", "f", "n", "u", "t", "/", "S", "F", "N", "L", "H", "M", "U", "G", "T", "?", "Z" },
      -- -- labels = { "s", "f", "n", "j", "k" },
      -- -- stylua: ignore
      -- labels = {
      --  "s", "f", "n", "j", "k", "l", "h", "o", "d", "w", "e", "m", "b", "u", "y", "v", "r", "g", "t", "c", "x", "/", "z", "S", "F", "N", "J", "K", "L", "H", "O", "D", "W", "E", "M", "B", "U", "Y", "V", "R", "G", "T", "C", "X", "?", "Z",
      -- },
      special_keys = {
        repeat_search = "<enter>",
        next_phase_one_target = "<enter>",
        next_target = { "<enter>", ";" },
        prev_target = { "<tab>" },
        next_group = "<space>",
        prev_group = "<tab>",
        multi_accept = "<enter>",
        multi_revert = "<backspace>",
      },
    },
  },
}
