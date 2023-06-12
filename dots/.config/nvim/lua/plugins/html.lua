return {
  ---- Match aparent and show it on top
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
