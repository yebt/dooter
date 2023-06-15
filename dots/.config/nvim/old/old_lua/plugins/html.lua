return {
  -- Expand html
  {
    "mattn/emmet-vim",
    --ft = filetypes,
    -- event = "VeryLazy",
    event = {
      "InsertEnter",
      "CursorMoved",
    },
    cmd = {
      "EmmetInstall",
    },
    keys = {
      --{ "<C-y>,", mode = { "i", "n", "x" } },
      --{ "<Tab>", 'v:lua.check_back_space() ? "<Tab>" : "<C-y>,"', mode = { "i" }, remap = true, expr = true },
    },
    config = function()
      vim.g.user_emmet_mode = "i"
      --	vim.g.user_emmet_leader_key = "<C-Z>"
    end,
  },

  -- Match aparent and show it on top
  {
    "andymass/vim-matchup",
    --event = "VeryLazy",
    config = function()
      -- vim.cmd([[hi MatchParen   guifg=None cterm=italic gui=italic ]])
      -- vim.g.matchup_matchparen_offscreen = { method = "popup" }
      -- vim.cmd([[hi MatchWord guifg=blue cterm=underline gui=underline ]])
      -- vim.cmd([[:hi MatchParenCur guifg=red gui=underline]])
      vim.cmd([[:hi MatchWordCur guifg=None gui=italic]])
      --vim.api.nvim_exec_autocmds("FileType", {})
    end,
  },
}
