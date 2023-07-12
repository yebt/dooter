vim.g.mapleader = " "
-- Loaders
require("config.options")
require("config.lazyinit")
require("config.autocmds")
-- require("config.keymaps")

-- Lazy loader
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "VeryLazy",
	callback = function() 
    require ("config.keymaps")
    require ("config.status")
	end,
})

-- Lazy loader post
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "VeryLazy",
	callback = function() 
	  vim.schedule(function()
		  vim.api.nvim_exec_autocmds("FileType", {})
		  -- vim.g.own
		  -- Var to trigger other plugins
		  vim.g.ownlazyload = true
	  end)
	end,
})

--
require("config.autocmdplugins")

--
require("config.lsp")

