return {

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- priority = 1000,
    -- lazy = false,
    opts = {
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        aerial = true,
        alpha = true,
        barbar = true,
        leap = true,
        lsp_saga = true,
        markdown = true,
        mason = true,
        neotree = true,
        neogit = true,
        noice = true,
        cmp = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        notify = true,
        semantic_tokens = true,
        treesitter = true,
        overseer = true,
        symbols_outline = true,
        telescope = true,
        lsp_trouble = true,
        illuminate = true,
        which_key = true,
      },
    },
  },
  --[[
  require("lspsaga").setup {
    ui = {
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    },
  }
  --]]

}
