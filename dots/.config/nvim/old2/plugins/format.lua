return {
  {
    "mhartington/formatter.nvim",
    keys = {
      { "<leader>f", ":FormatWrite<CR>", silent = true },
    },
    cmd = {
      "Format",
      "FormatWrite",
    },
    config = function()
      -- Utilities for creating configurations
      local util = require("formatter.util")

      require("formatter").setup({
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.DEBUG,
        -- All formatter configurations are opt-in
        filetype = {
          -- Formatter configurations for filetype "lua" go here
          -- and will be executed in order
          lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- -- You can also define your own configuration
            -- function()
            --   -- Supports conditional formatting
            --   if util.get_current_buffer_file_name() == "special.lua" then
            --     return nil
            --   end

            --   -- Full specification of configurations is down below and in Vim help
            --   -- files
            --   return {
            --     exe = "stylua",
            --     args = {
            --       "--search-parent-directories",
            --       "--stdin-filepath",
            --       util.escape_path(util.get_current_buffer_file_path()),
            --       "--",
            --       "-",
            --     },
            --     stdin = true,
            --   }
            -- end,
          },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })

      -- AUTOCOMADN
      local formatnvim_group = vim.api.nvim_create_augroup("formattercall", { clear = true })
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "FormatterPre",
        desc = "Format info ",
        group = formatnvim_group,
        callback = function()
          vim.notify("Formatting ...")
        end,
      })
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "FormatterPost",
        desc = "Format info ",
        group = formatnvim_group,
        callback = function()
          vim.notify("Format ok")
        end,
      })
    end,
  },
}
