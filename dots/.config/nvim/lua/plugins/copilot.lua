return {
  -- copilot
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   opts = {
  --     suggestion = { enabled = false },
  --     panel = { enabled = false },
  --     filetypes = {
  --       markdown = true,
  --       help = true,
  --     },
  --   },
  -- },
  {
    "github/copilot.vim",
    cmd = "Copilot",
    build = ":Copilot setup",
    -- init = function()
    --   vim.cmd([[
    --     imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
    --     let g:copilot_no_tab_map = v:true
    --   ]])
    -- end,
  },
  -- completion test
  
}
