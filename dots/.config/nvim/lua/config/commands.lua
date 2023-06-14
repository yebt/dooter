-- nvim_create_user_command('SayHello', 'echo "Hello world!"', {'bang': v:true})
local ncsc = vim.api.nvim_create_user_command

-- ncsc("AddSchemas", function()
--   local capabilities_s = require("cmp_nvim_lsp").default_capabilities()
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--   capabilities_s.textDocument.completion.completionItem.snippetSupport = true
--
--   require("lspconfig").jsonls.setup({
--     capabilities = capabilities_s,
--     settings = {
--       json = {
--         schemas = require("schemastore").json.schemas(),
--         validate = { enable = true },
--       },
--     },
--   })
--
--   -- require("lspconfig").jsonls.setup({
--   --   settings = {
--   --     json = {
--   --       schemas = require("schemastore").json.schemas(),
--   --       validate = { enable = true },
--   --     },
--   --   },
--   -- })
-- end, {})

---------------------------------------------
-- Runner
---------------------------------------------

--
local function create_floating_window()
  local buf = vim.api.nvim_create_buf(false, true)
  local porcent_h = 60
  local porcent_w = 60
  -- Obtener las dimensiones de la ventana actual
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  -- Calcular el tamaño de la ventana flotante
  local win_height = math.ceil(height * porcent_h / 100 - 4)
  local win_width = math.ceil(width * porcent_w / 100)
  -- Calcular la posición de inicio de la ventana
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  -- Configurar las opciones de la ventana
  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = "single",
    title = "RUNN",
    focusable = true,
  }
  -- Crear la ventana con el buffer adjunto
  local win = vim.api.nvim_open_win(buf, true, opts)

  return buf, win
end

-- Crear una terminal flotante y enviar un comando
local function create_floating_terminal(command)
  local buf = vim.api.nvim_create_buf(false, true)
  local porcent_h = 70
  local porcent_w = 80
  -- get the current window dimensions
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  -- calculate our floating window size
  local win_height = math.ceil(height * porcent_h / 100 - 4)
  local win_width = math.ceil(width * porcent_w / 100)
  -- and its starting position
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  -- set some options
  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = "single",
    title = "RUNN",
    focusable = true,
  }
  -- and finally create it with buffer attached
  local win = vim.api.nvim_open_win(buf, true, opts)
  -- vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal")
  -- vim.api.nvim_win_set_option(win, "winblend", 0)
  -- vim.api.nvim_win_set_option(win, "winhighlight", "Normal:Normal")

  local term_job_id = vim.fn.termopen(command, {
    on_exit = function(a, code)
      -- vim.api.nvim_win_close(win, true)
      -- vim.api.nvim_buf_delete(buf, {force = true})
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
  -- -- --
  -- vim.api.nvim_set_current_win(win)
  -- vim.cmd("startinsert")
  vim.keymap.set("t", "<M-c>", function()
    vim.fn.jobstop(term_job_id)
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, {force = true})
  end, {})
  -- vim.cmd("terminal " .. command)

  -- return term_job_id
end

-- Uso de ejemplo
-- local command = "ls"
-- local term_job_id = create_floating_terminal(command)

-- Configured runners
local configured_runners = {
  python = "python " .. vim.fn.expand("%"),
  lua = {
    "ls",
    -- "exa",
  },
}
-- local default runner
vim.b.def_runner = nil
-- Selector
local function openSelector(select_opts, callback)
  vim.ui.select(select_opts, {
    prompt = "Select a runner",
    format_item = function(item)
      return "Run: " .. item
    end,
  }, callback)
end
-- run runner
local function runRunner()
  local ft = vim.bo.filetype
  local cmmd = vim.b.def_runner or configured_runners[ft]
  if cmmd then
    if type(cmmd) == "table" and #cmmd > 1 then
      -- cmmd:append("Set default")
      openSelector(cmmd, function(choice)
        if choice then
          -- vim.cmd(":!" .. choice)
          create_floating_window(choice)
          -- create_floating_terminal(choice)
        end
      end)
    else
      create_floating_terminal(cmmd)
    end
  else
    vim.notify("No runner configured to: " .. ft, vim.log.levels.WARN)
  end
end

--
ncsc("Run", function()
  runRunner()
end, {})
ncsc("Run", function()
  runRunner()
end, {})

vim.keymap.set("n", "<F12>", ":Run<CR>", { silent = true })
