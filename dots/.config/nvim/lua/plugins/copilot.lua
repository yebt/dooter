return {
  -- copilot
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
  {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = "Copilot",
    build = ":Copilot setup"
  }
}

