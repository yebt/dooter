local opt = vim.opt
----
opt.compatible = false
-- wrap
-- opt.wrap = false
opt.showbreak = "↳"
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "min:40,shift:0,sbr"
opt.copyindent = true
opt.preserveindent = true
-- indent
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
-- cursor
opt.cursorline = true
--opt.guicursor = "a:block"
--
opt.concealcursor = "nc"
opt.conceallevel = 2
--
opt.nu = true
opt.rnu = true
--
opt.cmdheight = 2
--opt.cmdheight = 1
--opt.cmdheight = 0
--
opt.confirm = true
--
opt.clipboard = "unnamed"
--
opt.backspace = "indent,eol,start,nostop"
--
opt.viewoptions = "folds,cursor"
-- opt.viewoptions = "folds"
--
--
opt.foldenable = true
-- opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "1"
opt.foldmethod = "indent"
--
opt.signcolumn = "auto"
--
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
-- /home/eb/Desktop/
opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
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
opt.incsearch = true
--
opt.showmode = false
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
--
vim.opt.termguicolors = true
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
opt.fillchars:append({
	diff = "╱",
	-- 
	-- 
	-- foldclose = "",
	-- foldopen = "",
	-- foldsep = "│"
	-- foldsep = "▏"
	-- diff = "",
})
-- internal, filler, closeoff
opt.diffopt = {
	"filler", -- sync text content
	-- "horizontal", -- use horizontal views -
	"closeoff", -- off diff on just 1 window
	--"followwrap",
	-- "internal",
	"linematch:60", --
	--  myers      the default algorithm
	-- minimal    spend extra time to generate the
	-- smallest possible diff
	-- patience   patience diff algorithm
	-- histogram  histogram diff algorithm
	-- "algorithm:histogram"
}
--
-- show break on numberline
opt.cpoptions:append("n")
-- a -> sortmessages, c -> no show completion message
opt.shortmess:append({
	a = true, -- all of the above abbreviations
	c = true, -- don't give |ins-completion-menu| messages; for example, "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found", "Back at original", etc.
	I = true, -- don't give the intro message when starting Vim, see :intro
})
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

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
