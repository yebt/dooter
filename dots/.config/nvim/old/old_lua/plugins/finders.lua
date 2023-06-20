return {
  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
    -- commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now

    keys = {
      { "<leader>tf", ":Telescope find_files<CR>", silent = true, desc = "Telescope Find File" },
      { "<leader>td", ":Telescope fd<CR>", silent = true, desc = "Telescope FD" },
      { "<leader>tb", ":Telescope buffers<CR>", silent = true, desc = "Telescope Buffers" },
      { "<leader>to", ":Telescope oldfiles<CR>", silent = true, desc = "Telescope Old Files" },
      { "<leader>to", ":Telescope oldfiles<CR>", silent = true, desc = "Telescope Old Files" },
      { "<leader>tr", ":Telescope resume<CR>", silent = true, desc = "Telescope Resume" },
      { "<leader>tl", ":Telescope live_grep<CR>", silent = true, desc = "Telescope Live Grep" },
      -- { "<C-p>", ":Telescope find_files theme=<cr>", silent = true, desc = "Telescope fast ff"},
      {
        "<C-p>",
        ':Telescope find_files theme=dropdown layout_config={height=12,preview_cutoff=120,anchor="N"}<cr>',
        silent = true,
        desc = "Telescope fast ff",
      },
      { "<leader>tt", ":Telescope file_browser<CR>", silent = true, desc = "Telescope file browser" },
      {
        "<leader>tT",
        ":Telescope file_browser path=%:p:h select_buffer=true <CR>",
        silent = true,
        desc = "Telescope file browser",
      },
      {
        "<C-s>",
        mode = "i",
        function()
          vim.ui.select({ "emoji", "kaomoji", "gitmoji", "math", "latex" }, {
            prompt = "Select source",
            telescope = require("telescope.themes").get_cursor(),
          }, function(selected)
            -- print("complex")
            if selected then
              require("telescope.builtin").symbols(require("telescope.themes").get_cursor({ sources = { selected } }))
            end
          end)
        end,
        silent = true,
        desc = "Telescope Symbols select",
      },
    },
    config = function(_, opts)
      local fb_actions = require("telescope._extensions.file_browser.actions")
      require("telescope").setup({
        defaults = {
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          pickers = {
            find_files = {
              -- dropdown
              -- ivy
              -- cursor
              -- theme = "dropdown",
            },
            symbols = {
              theme = "dropdown",
            },
          },
          mappings = {
            i = {
              ["<C-j>"] = "cycle_history_next",
              ["<C-k>"] = "cycle_history_prev",
              -- ["<C-n>"] = actions.move_selection_next,
              -- ["<C-p>"] = actions.move_selection_previous,
              ["<C-n>"] = "move_selection_next",
              ["<C-p>"] = "move_selection_previous",
              ["<esc>"] = "close",
              --["<M-q>"] = "close",
              ["<C-h>"] = "which_key",
            },
            n = {
              ["q"] = "close",
              ["<esc>"] = "close",
            },
          },
        },

        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          file_browser = {
            -- theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            auto_depth = true,
            select_buffer = true,
            --display_stat = { date = true, size = true, mode = true },
            --display_stat = { mode = true },
            git_status = false,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
                ["<C-a>"] = fb_actions.create,
                ["<C-A>"] = fb_actions.create_from_prompt,
                ["<C-f>"] = fb_actions.toggle_browser,
                ["<C-d>"] = fb_actions.remove,
              },
              ["n"] = {
                ["<esc>"] = nil,
                ["c"] = fb_actions.create,
                ["C"] = fb_actions.create_from_prompt,
                ["r"] = fb_actions.rename,
                ["m"] = fb_actions.move,
                ["y"] = fb_actions.copy,
                ["d"] = fb_actions.remove,
                ["o"] = fb_actions.open,
                ["g"] = fb_actions.goto_parent_dir,
                ["e"] = fb_actions.goto_home_dir,
                ["w"] = fb_actions.goto_cwd,
                ["t"] = fb_actions.change_cwd,
                ["f"] = fb_actions.toggle_browser,
                ["h"] = fb_actions.toggle_hidden,
                ["s"] = fb_actions.toggle_all,
                -- your custom normal mode mappings
              },
            },
          },
        },
      })

      -- extensinos load
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },
}
