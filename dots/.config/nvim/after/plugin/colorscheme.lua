local pref_colorscheme = "catppuccin"
--local pref_colorscheme = "habamax"
local default_colorscheme = "habamax"

if not pcall(vim.cmd.colorscheme, pref_colorscheme) then
  vim.cmd.colorscheme(default_colorscheme)

  vim.api.nvim_set_hl(0, "FloatBorder", {
    fg = vim.api.nvim_get_hl_by_name("NormalFloat", true).background,
    bg = vim.api.nvim_get_hl_by_name("NormalFloat", true).background,
  })

  -- Make the cursor line background invisible
  -- vim.api.nvim_set_hl(0, "CursorLineBg", {
  --   fg = vim.api.nvim_get_hl_by_name("CursorLine", true).background,
  --   bg = vim.api.nvim_get_hl_by_name("CursorLine", true).background,
  -- })

  -- vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#30323E" })

  vim.api.nvim_set_hl(0, "StatusLineNonText", {
    fg = vim.api.nvim_get_hl_by_name("NonText", true).foreground,
    bg = vim.api.nvim_get_hl_by_name("StatusLine", true).background,
  })
  vim.api.nvim_set_hl(0, "ColorColumn", {
    bg = "#2E2926",
  })
  vim.api.nvim_set_hl(0, "MatchWordCur", {
    italic = true,
  })
  -- vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#2F313C" })
  --highlights. |hl-LspReferenceText| |hl-LspReferenceRead| |hl-LspReferenceWrite|
  -- FileType verylazy event
end

local function redefSomeColors()

    vim.api.nvim_set_hl(0, "MatchParen", { bold = true, italic = true })

    vim.api.nvim_set_hl(0, "MatchWordCur", {
      italic = true,
    })
    vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#ff007c", bold = true })
    vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "#00dfff", bold = true })
    vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "grey" })

end
-- Colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  once = true,
  callback = redefSomeColors,
})

redefSomeColors()

