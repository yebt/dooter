-- Functions
local async_formatting = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	vim.lsp.buf_request(
		bufnr,
		"textDocument/formatting",
		vim.lsp.util.make_formatting_params({}),
		function(err, res, ctx)
			if err then
				local err_msg = type(err) == "string" and err or err.message
				-- you can modify the log message / level (or ignore it completely)
				vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
				return
			end

			-- don't apply results if buffer is unloaded or has been modified
			if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
				return
			end

			if res then
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("silent noautocmd update")
				end)
			end
		end
	)
end

-- local null_ls = require("null-ls")
--
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
-- null_ls.setup({
--     -- add your sources / config options here
--     sources = ...,
--     debug = false,
--     on_attach = function(client, bufnr)
--         if client.supports_method("textDocument/formatting") then
--             vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--             vim.api.nvim_create_autocmd("BufWritePost", {
--                 group = augroup,
--                 buffer = bufnr,
--                 callback = function()
--                     async_formatting(bufnr)
--                 end,
--             })
--         end
--     end,
-- })

-- LSP configuration
-- update on insert the ts autotag
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity_limit = "Warning",
	},
	update_in_insert = true,
})

--
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		--
		-- -- vim.notify(vim.inspect(ev), vim.log.levels.INFO)
		--
		-- -- local client_id = ev.data.client_id
		-- -- local client = vim.lsp.get_client_by_id(client_id)
		-- local bufnr = ev.buf
		-- local client = vim.lsp.get_client_by_id(ev.data.client_id)
		--
		-- -- Formatting
		-- if client.supports_method("textDocument/formatting") then
		-- 	vim.keymap.set('n', '<leader>f', function()
		-- 	  -- vim.lsp.buf.format { async = true }
		--       async_formatting()
		-- 	end, { buffer = bufnr, desc = "Format with LSP" })
		-- 	-- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		-- 	-- vim.api.nvim_create_autocmd("BufWritePost", {
		-- 	-- 	group = augroup,
		-- 	-- 	buffer = bufnr,
		-- 	-- 	callback = function()
		-- 	-- 		async_formatting(bufnr)
		-- 	-- 	end,
		-- 	-- })
		-- end
		--
		-- -- Hover
		-- if client.server_capabilities.hoverProvider then
		-- 	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr  })
		-- end

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		-- local opts = { buffer = ev.buf }
		-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		-- vim.keymap.set('n', '<leader>Wa', vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set('n', '<leader>Wr', vim.lsp.buf.remove_workspace_folder, opts)
		-- vim.keymap.set('n', '<leader>Wl', function()
		--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, opts)
		-- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		-- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		-- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	end,
})
