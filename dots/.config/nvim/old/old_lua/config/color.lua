-- Colorscheme
-- local pref_colorscheme = "kanagawa"
-- local pref_colorscheme = "kanagawa-dragon"
--local pref_colorscheme = "monokai-pro"
--local pref_colorscheme = "onedark"
-- local pref_colorscheme = "habamax"
-- local pref_colorscheme = ""
--local pref_colorscheme = "habamax"
local pref_colorscheme = "monokai-pro"
--local pref_colorscheme = "habamax"
local default_colorscheme = "habamax"
if not pcall(vim.cmd.colorscheme, pref_colorscheme) then
	vim.cmd.colorscheme(default_colorscheme)
end

vim.api.nvim_create_autocmd("ColorScheme", {
	once = true,
	callback = function()
		----
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
			 italic = true
		})
		-- vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#2F313C" })
		--highlights. |hl-LspReferenceText| |hl-LspReferenceRead| |hl-LspReferenceWrite|
		-- FileType verylazy event
	end,
})
