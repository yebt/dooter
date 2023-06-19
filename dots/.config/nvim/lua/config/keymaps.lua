local map = vim.keymap.set

-- Special  manage keys better init
map("n", "0", function()
  local col = vim.fn.col(".")
  local line = vim.api.nvim_get_current_line()
  local nonBlankColumn = vim.fn.match(line, "\\S") + 1
  if col == nonBlankColumn then
    action = "g0"
  else
    action = "^"
  end
  return action
end, { silent = true, expr = true })

-- Regular usage
map("n", "<leader>q", ":q<CR>", { silent = true })
map("n", "<leader>w", ":w<CR>", { silent = true })

map({ "x", "i", "n" }, "<C-c>", "<ESC>", { silent = true })

-- Motions
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Move cursor down" })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Move cursor up" })

-- Splits
map("n", "<M-Bar>", ":vsplit<cr>", { silent = true })
map("n", "<M-->", ":split<cr>", { silent = true })

map("n", "<M-h>", "<C-w>h", {silent = true})
map("n", "<M-l>", "<C-w>l", {silent = true})
map("n", "<M-k>", "<C-w>k", {silent = true})
map("n", "<M-j>", "<C-w>j", {silent = true})
-- map("n", "<M-Right>", ":vert resize +2<CR>", {silent = true})
-- map("n", "<M-Left>", ":vert resize -2<CR>", {silent = true})
-- map("n", "<M-Up>", ":resize +2<CR>", {silent = true})
-- map("n", "<M-Down>", ":resize -2<CR>", {silent = true})

-- Terminal
map("t", "<ESC>", "<C-\\><C-n>", {silent = true})

-- Buffers
-- map("n", "]b", ":bn<cr>", { silent = true, desc = "Go to next buffer" })
-- map("n", "[b", ":bp<cr>", { silent = true, desc = "Go to previus buffer" })
map("n", "<M-d>", ":bn<cr>", { silent = true, desc = "Go to next buffer" })
map("n", "<M-a>", ":bp<cr>", { silent = true, desc = "Go to prev buffer" })
map("n", "<M-s>", ":b#<cr>", { silent = true, desc = "Go to # buffer" })

local function brem()
  -- if there are less than 2
  if vim.fn.winnr("$") < 2 then
    vim.cmd("bw")
    return
  end
  -- there are at least 2 windows
  -- if there are less that 2 bufers
  if vim.fn.bufnr("$") < 2 then
    vim.cmd("enew")
  end
  vim.cmd("bn |  bw #")
end
-- map("n", "<M-c>", brem, {silent = true})
map("n", "<M-c>", brem, { silent = true, desc = "Delete buffer" })

-- actions
map("n", "<leader>a", "ggVG", { silent = true, desc = "select all content" })
map("x", "<leader>p", '"_dP', { silent = true, desc = "Paste without losee content" })
map("x", "<leader>y", '"+y', { silent = true, desc = "Copy con clipboard" })

map("x", "<", "<gv", { silent = true, desc = "Indent -" })
map("x", ">", ">gv", { silent = true, desc = "Indebt +" })
map("x", "<tab>", "<gv", { silent = true, desc = "Indent +" })
map("x", "<s-tab>", ">gv", { silent = true, desc = "Indent -" })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection up" })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection down" })
map(
  "n",
  "<leader>sw",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "remplace cursor word, in all document" }
)

-- surround
map("x", "<C-s>", function()
	local char_code = vim.fn.getchar()
	local char = vim.fn.nr2char(char_code)
	if char == "\x03" or char == "\x1b" then
		return
	end
	local surrounds = {
		["("] = ")",
		["["] = "]",
		["{"] = "}",
		["<"] = ">",
		-- ' " ` = are the same
	}
	local pair_char = surrounds[char] or char
	return "c" .. char .. '<C-r><C-o>"' .. pair_char .. "<ESC><Left>vi" .. char
end, { silent = true, expr = true, desc = "Add surround" })

-- Explorer
-- map("n", "<leader>E", ":Ex<CR>", {silent = true})
-- map("n", "<leader>V", ":Vex<CR>", {silent = true})
map("n", "\\", ":Lex %:p:h <CR>", {silent = true})
--map("n", "\\", ":Vex<CR>", {silent = true})


