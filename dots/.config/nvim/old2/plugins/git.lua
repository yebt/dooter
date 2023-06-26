return {

  -- Magit in noevim
  {
    "TimUntersberger/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = "Neogit",
  },
  --    -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- signs = {
      --   add = { text = "▎" },
      --   change = { text = "▎" },
      --   delete = { text = "" },
      --   topdelete = { text = "" },
      --   changedelete = { text = "▎" },
      --   untracked = { text = "▎" },
      -- },
    },
  },
  --
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "G",
      "Gedit",
      "Gsplit",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gwrite",
      "Ggrep",
      "Glgrep",
      "GMove",
      "GDelete",
      "GRename",
      "GRemove",
      "GBrowse",
    },
  },
}
