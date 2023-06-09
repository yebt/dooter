local opt = vim.opt
opt.fillchars = {
	stl = " ", -- ' ' or '^'	statusline of the current window
	stlnc = "=", -- ' ' or '='	statusline of the non-current windows
	-- wbr		= '', -- ' '		window bar
	horiz = "─", -- '─' or '-'	horizontal separators |:split|
	horizup = "┴", -- '┴' or '-'	upwards facing horizontal separator
	horizdown = "┬", -- '┬' or '-'	downwards facing horizontal separator
	vert = "│", -- '│' or '|'	vertical separators |:vsplit|
	vertleft = "┤", -- '┤' or '|'	left facing vertical separator
	vertright = "├", -- '├' or '|'	right facing vertical separator
	verthoriz = "┼", -- '┼' or '+'	overlapping vertical and horizontal
	--       	      -- 		separator
	fold = " ", -- '·' or '-'	filling 'foldtext'
	-- foldopen = "", -- '-'		mark the beginning of a fold
	-- foldclose = "", -- '+'		show a closed fold
	foldsep = "│", -- '│' or '|'      open fold middle marker
	diff = "-", -- '-'		deleted lines of the 'diff' option
	msgsep = " ", -- ' '		message separator 'display'
	--eob		= '', -- '~'		empty lines at the end of a buffer
	-- lastline	= '' -- '@'		'display' contains lastline/truncate
}

opt.compatible = false
--
opt.wrap = true
opt.showbreak = "↳"
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "min:40,shift:0,sbr"
opt.copyindent = true
opt.preserveindent = true
--
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
--
opt.cursorline = true
--opt.guicursor = "a:block"
--
opt.concealcursor = "nc"
opt.conceallevel = 1
--
opt.nu = true
opt.rnu = true
--
--opt.cmdheight = 1
--opt.cmdheight = 0
--
opt.confirm = true
--
opt.clipboard = "unnamed"
--
opt.viewoptions = "folds,cursor"
-- {
--   folds = true,
--   cursor = true,
-- }
--
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "1"
opt.foldmethod = "indent"
--
opt.signcolumn = "auto"
--
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
--
opt.completeopt = {
	"menu",
	"menuone",
	-- "noselect",
	-- "noinsert",
}
opt.pumheight = 10
--
opt.scrolloff = 1
opt.sidescrolloff = 4
--
opt.inccommand = "split"
opt.ignorecase = true
opt.infercase = true
opt.smartcase = true
--
opt.showmode = false
--
-- opt.termguicolors = true
opt.background = "dark"
--
-- opt.showtabline = 2
opt.laststatus = 3
--
-- opt.icon = true
-- opt.title = true
--
-- opt.timeout = true -- def on
opt.timeout = true
opt.timeoutlen = 500 -- 1000
opt.updatetime = 300 -- 4000
--
opt.virtualedit = "block"
--
opt.undofile = true
opt.backup = true
-- not use
opt.backupdir:remove(".")
-- opt.backupdir = {
--   "$XDG_STATE_HOME/nvim/backup//",
-- }
--
-- opt.listchars = "tab:⇀  ,trail:·,precedes:«,extends:»,space:⋅,conceal:%,nbsp:+,eol:↴"
opt.listchars = {
	tab = "▸ ",
	trail = "·",
	precedes = "«",
	extends = "»",
	space = "⋅",
	--concea
	nbsp = "+",
	eol = "↴",
}
--
-- show break on numberline
opt.cpoptions:append("n")
-- a -> sortmessages, c -> no show completion message
opt.shortmess:append({a=true, c=true})
--
opt.spelllang = "es,en"
vim.g.spellfile_URL = "https://ftp.nluug.nl/vim/runtime/spell"
-- vim.g.loaded_spellfile_plugin = 1
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_ruby_provider = 0
--
opt.sessionoptions = "buffers,curdir,winsize"

vim.g.netrw_banner = 0
--vim.g.netrw_list_hide = ",^\\.\\.\\=/\\=$"
vim.g.netrw_use_errorwindow = 0 -- show like echo
vim.g.netrw_winsize = 30
vim.g.netrw_keepdir = 0

-- vim.g.netrw_browse_split = 4
-- vim.g.netrw_retmap = 1
-- vim.g.netrw_silent = 1
-- vim.g.netrw_special_syntax = 1
-- vim.g.netrw_altv = 1
-- vim.g.netrw_fastbrowse = 2

