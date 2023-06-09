-- Vars
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command
local namespace = vim.api.nvim_create_namespace

-- Function

local function is_available(plugin)
	local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
	return lazy_config_avail and lazy_config.plugins[plugin] ~= nil
end

-- Is a valid buffer
local function is_valid(bufnr)
	if not bufnr or bufnr < 1 then
		return false
	end
	return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

-- Trigger an event

local function event(ev)
	vim.schedule(function()
		vim.api.nvim_exec_autocmds("User", { pattern = "" .. ev })
	end)
end

-- Autocmds

vim.on_key(function(char)
	if vim.fn.mode() == "n" then
		local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
		if vim.opt.hlsearch:get() ~= new_hlsearch then
			vim.opt.hlsearch = new_hlsearch
		end
	end
end, namespace("auto_hlsearch"))

-- Autocmds

--
-- local bufferline_group = augroup("bufferline", { clear = true })
-- autocmd({ "BufAdd", "BufEnter", "TabNewEntered" }, {
-- 	desc = "Update buffers when adding new buffers",
-- 	group = bufferline_group,
-- 	callback = function(args)
-- 		if not vim.t.bufs then
-- 			vim.t.bufs = {}
-- 		end
-- 		local bufs = vim.t.bufs
-- 		if not vim.tbl_contains(bufs, args.buf) then
-- 			table.insert(bufs, args.buf)
-- 			vim.t.bufs = bufs
-- 		end
-- 		-- vim.t.bufs = vim.tbl_filter(require("nu.utils.buffer").is_valid, vim.t.bufs)
-- 		vim.t.bufs = vim.tbl_filter(is_valid, vim.t.bufs)
-- 		event("BufsUpdated")
-- 	end,
-- })

--
autocmd("FileType", {
	desc = "Unlist quickfist buffers",
	group = augroup("unlist_quickfist", { clear = true }),
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Autoview
local view_group = augroup("_auto_view", { clear = true })
autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
	desc = "Save view with mkview for real files",
	group = view_group,
	callback = function(event)
		if vim.b[event.buf].view_activated then
			vim.cmd.mkview({ mods = { emsg_silent = true } })
		end
	end,
})
autocmd("BufWinEnter", {
	desc = "Try to load file view if available and enable view saving for real files",
	group = view_group,
	callback = function(event)
		if not vim.b[event.buf].view_activated then
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
			local buftype = vim.api.nvim_get_option_value("buftype", { buf = event.buf })
			local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
			if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
				vim.b[event.buf].view_activated = true
				vim.cmd.loadview({ mods = { emsg_silent = true } })
			end
		end
	end,
})

-- autoview is slow
-- Alternative if autoview is not active IDK
autocmd("BufReadPost", {
	group = augroup("_last_loc", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})


-- Fast quit of floats, fix (help, quickfix, dap, etc)
-- close some filetypes with <q>
autocmd("FileType", {
	group = augroup("close_with_q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"runner",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Resize on windows
autocmd({ "VimResized" }, {
	group = augroup("resize_splits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- HighLight Yanke Text
autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = augroup("highlightyank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})


-- Termianl managment
local c = augroup("TERMING", { clear = true })
autocmd({ "TermOpen" }, {
	pattern = { "*" },
	group = c,
	command = [[setlocal nonumber | setlocal norelativenumber | setlocal  signcolumn=no|startinsert]],
})
autocmd({ "BufEnter", "WinEnter" }, { pattern = { "term://*" }, group = c, command = [[startinsert]] })
autocmd({ "BufLeave" }, { pattern = { "term://*" }, group = c, command = [[stopinsert]] })


