--
local userlspconfiggroup = vim.api.nvim_create_augroup("UserLspConfig", {})
--
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Opend diagnostics in a floating window" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
-- vim.keymap.set('n', '<leader>E', vim.diagnostic.setloclist, {desc = "Set diagnostics to loclist"})
vim.keymap.set("n", "<leader>E", ":TroubleToggle document_diagnostics<CR>", { desc = "Set diagnostics to loclist" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = userlspconfiggroup,
  callback = function(ev)
    --local client = ev.data.client_id
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.supports_method("textDocument/formatting") then
      -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = ev.buf })
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = augroup,
      --   buffer = ev.buf,
      --   callback = function()
      --     lsp_formatting(ev.buf)
      --   end,
      -- })
    end

    -- Enable completion triggered by <c-x><c-o>
    -- vim.notify(vim.inspect(ev), "info", { title = "LspAttach" })

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show hover" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to implementation" })
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Show signature help" })
    vim.keymap.set(
      "n",
      "<leader>Wa",
      vim.lsp.buf.add_workspace_folder,
      { buffer = ev.buf, desc = "Add workspace folder" }
    )
    vim.keymap.set(
      "n",
      "<leader>Wr",
      vim.lsp.buf.remove_workspace_folder,
      { buffer = ev.buf, desc = "Remove workspace folder" }
    )
    vim.keymap.set("n", "<leader>Wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = ev.buf, desc = "List workspace folders" })
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Go to type definition" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
    -- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
    vim.keymap.set({ "n", "v" }, "<leader>ca", ":Lspsaga code_action<CR>", { buffer = ev.buf, desc = "Code action" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Go to references" })

    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({
        filter = function(clientl)
          -- apply whatever logic you want (in this example, we'll only use null-ls)
          return clientl.name == "null-ls"
        end,
        bufnr = ev.buf,
        async = true,
      })
    end, { buffer = ev.buf, desc = "Format" })

    if client.supports_method("textDocument/codeLens") then
      vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter" }, {
        desc = "Refresh codelens",
        group = userlspconfiggroup,
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
      vim.keymap.set("n", "<leader>lL", vim.lsp.codelens.run, { buffer = ev.buf, desc = "Run codelens" })
      vim.keymap.set("n", "<leader>ll", vim.lsp.codelens.refresh, { buffer = ev.buf, desc = "Refresh codelens" })
    end
    if client.supports_method("workspace/symbol") then
      vim.keymap.set("n", "<leader>lS", vim.lsp.buf.document_symbol, { buffer = ev.buf, desc = "Document symbols" })
    end
  end,
})
