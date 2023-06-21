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
      show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.5, -- percentage of the shade to apply to the inactive window
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
      color_overrides = {
        mocha = {
          -- base = "#23272e",
          -- crust = "#1e2227",

          -- rosewater = "#f5e0dc",
          -- flamingo = "#f2cdcd",
          -- pink = "#f5c2e7",
          -- mauve = "#cba6f7",
          -- red = "#f38ba8",
          -- maroon = "#eba0ac",
          -- peach = "#fab387",
          -- yellow = "#f9e2af",
          -- green = "#a6e3a1",
          -- teal = "#94e2d5",
          -- sky = "#89dceb",
          -- sapphire = "#74c7ec",
          -- blue = "#89b4fa",
          -- lavender = "#b4befe",
          -- text = "#cdd6f4",
          -- subtext1 = "#bac2de",
          -- subtext0 = "#a6adc8",
          -- overlay2 = "#9399b2",
          -- overlay1 = "#7f849c",
          -- overlay0 = "#6c7086",
          -- surface2 = "#585b70",
          -- surface1 = "#45475a",
          -- surface0 = "#313244",
          -- base = "#1e1e2e",
          -- mantle = "#181825",
          -- crust = "#11111b",

        },
      },
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
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
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
