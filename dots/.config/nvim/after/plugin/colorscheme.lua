--
-- local colorscheme = "kanagawa"
-- local colorscheme = function()
-- 	-- require("tokyonight").load()
-- 	require("kanagawa").load()
-- end
--
-- local colorscheme = "catppuccin-mocha"
-- local colorscheme = "monokai-pro"
-- local colorscheme = "kanagawa"

local colorscheme = "vitesse"
-- local colorscheme = function()
--   require("vitesse").load()
-- end
--
require("lazy.core.util").try(function()
	if type(colorscheme) == "function" then
		colorscheme()
	else
		vim.cmd.colorscheme(colorscheme)
	end
end, {

	msg = "Could not load your colorscheme",
	on_error = function(msg)
		--require("lazy.core.util").error(msg)
		vim.cmd.colorscheme("habamax")

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
	end,
})

local function redefSomeColors()
	-- vim.api.nvim_set_hl(0, "MatchParen", { bold = true, italic = true })
	vim.api.nvim_set_hl(0, "MatchParenCur", { bold = true, italic = true })
	-- vim.api.nvim_set_hl(0, "MatchWordCur", { bold = true, italic = true })
	vim.api.nvim_set_hl(0, "MatchWordCur", {
		italic = true,
	})
	vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#ff007c", bold = true })
	vim.api.nvim_set_hl(0, "LeapLabelSecondary", { fg = "#00dfff", bold = true })
	vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "grey" })

	-- Vitesse solutiona colors
	if vim.g.colors_name == "vitesse" then
		-- local vitesse_colors = require("vitesse.colors").colors
		-- local vitesse_themes = require("vitesse.colors").themes
		-- --
		-- -- -- vim.notify(vim.inspect(require("vitesse.colors").colors), "info", { title = "Vitesse" })
		-- -- -- vim.notify(vim.inspect(require("vitesse.colors").colors), "info", { title = "Vitesse" })
		-- --
		local colroSTL = vim.api.nvim_get_hl(0, { name = "StatusLine" })
		local colroFC = vim.api.nvim_get_hl(0, { name = "FoldColumn" })
		local colorNRML = vim.api.nvim_get_hl(0, { name = "Normal" })

		local colorAtext = vim.api.nvim_get_hl(0, { name = "@text" })
		local colorAmethod = vim.api.nvim_get_hl(0, { name = "@method" })
		local colorAfunction = vim.api.nvim_get_hl(0, { name = "@function" })
		local colorAconstructor = vim.api.nvim_get_hl(0, { name = "@constructor" })
		local colorAfield = vim.api.nvim_get_hl(0, { name = "@field" })
		local colorAvariable = vim.api.nvim_get_hl(0, { name = "@variable" })
		local colorAclass = vim.api.nvim_get_hl(0, { name = "@class" })
		local colorAinterface = vim.api.nvim_get_hl(0, { name = "@interface" })
		local colorAproperty = vim.api.nvim_get_hl(0, { name = "@property" })
		local colorAkeyword = vim.api.nvim_get_hl(0, { name = "@keyword" })
		local colorAtext_reference = vim.api.nvim_get_hl(0, { name = "@text.reference" })
		local colorAtype = vim.api.nvim_get_hl(0, { name = "@type" })
		local colorAconstant = vim.api.nvim_get_hl(0, { name = "@constant" })
		local colorAoperator = vim.api.nvim_get_hl(0, { name = "@operator" })
		local colorAtype = vim.api.nvim_get_hl(0, { name = "@type" })
		-- --
		-- -- vim.api.nvim_set_hl(0, "StatusLine", { fg = "#d4cfbf", bg = colroSTL.bg })
		vim.api.nvim_set_hl(0, "StatusLine", { fg = "#d4cfbf", bg = "#181818" })
		vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#292929", bg = colorNRML.bg })
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#343433", bg = colorNRML.bg })
		vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#c8c5b8", bg = "#1e1e1e" })

		-- Customization for Pmenu

		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#1e1e1e", fg = "NONE" })
		vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#1e1e1e" })

		-- vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
		-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
		-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
		-- vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })
		--
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#429988", bg = "NONE", bold = true })
		vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#429988", bg = "NONE", bold = true })

		vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = colorAtext.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = colorAmethod.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = colorAfunction.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = colorAconstructor.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = colorAfield.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = colorAvariable.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = colorAclass.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = colorAinterface.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = colorAproperty.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = colorAkeyword.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = colorAtext_reference.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = colorAtype.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = colorAconstant.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = colorAoperator.fg })
		vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = colorAtype.fg })

		--
		-- vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })
		--
		-- vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })
		--
		-- vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })
		--
		-- vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })
		--
		-- vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })
		--
		-- vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })
		--
		-- vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })
		--
		-- vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
		-- vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
		
	end
end

-- Colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
	once = true,
	callback = redefSomeColors,
})

redefSomeColors()
