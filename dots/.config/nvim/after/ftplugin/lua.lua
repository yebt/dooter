local optl = vim.opt_local
-- optl.fp = "stylua" -- not range allow
-- vim.keymap.set("n", "<leader>f", function()
--   vim.cmd("silent write")
--   -- local output = vim.fn.system('ls ' .. vim.nf.expand("%"))
--   -- vim.notify(output)
--   --local output = vim.api.nvim_exec("!stylua %", true)
--   --vim.notify(output)
--   -- Ejecutar un comando de shell y manejar errores
--   local print = function(args)
--     vim.notify(vim.inspect(args))
--   end
--   local scs, opt, cd = pcall(vim.api.nvim_exec2, "!stylua %", true)
--   vim.notify(vim.inspect({ scs, opt, cd }))
--   -- print({ scs, opt, cd })
--   -- local command = "stylua " .. vim.fn.expand("%")
--   -- local handle_error = true
-- 
--   -- local success, output, code = pcall(vim.fn.system, command)
-- 
--   -- -- Verificar si se produjo un error
-- 
--   -- if not success then
--   --   print({ "Ocurrió un error al ejecutar el comando: ", output, code })
--   -- end
--   -- vim.cmd("silent e")
-- end, { desc = "format", silent = true })

optl.tabstop = 2
optl.shiftwidth = 2
optl.softtabstop = 2

---- GF
local fmt = string.format

-- Iterator that splits a string o a given delimiter
local function split(str, delim)
  delim = delim or "%s"
  return string.gmatch(str, fmt("[^%s]+", delim))
end

-- Find the proper directory separator depending
-- on lua installation or OS.
local function dir_separator()
  -- Look at package.config for directory separator string (it's the first line)
  if package.config then
    return string.match(package.config, "^[^\n]")
  elseif vim.fn.has("win32") == 1 then
    return "\\"
  else
    return "/"
  end
end

-- Search for lua traditional include paths.
-- This mimics how require internally works.
local function include_paths(fname, ext)
  ext = ext or "lua"
  local sep = dir_separator()
  local paths = string.gsub(package.path, "%?", fname)
  for path in split(paths, "%;") do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end
end

-- Search for nvim lua include paths
local function include_rtpaths(fname, ext)
  ext = ext or "lua"
  local sep = dir_separator()
  local rtpaths = vim.api.nvim_list_runtime_paths()
  local modfile, initfile = fmt("%s.%s", fname, ext), fmt("init.%s", ext)
  for _, path in ipairs(rtpaths) do
    -- Look on runtime path for 'lua/*.lua' files
    local path1 = table.concat({ path, ext, modfile }, sep)
    if vim.fn.filereadable(path1) == 1 then
      return path1
    end
    -- Look on runtime path for 'lua/*/init.lua' files
    local path2 = table.concat({ path, ext, fname, initfile }, sep)
    if vim.fn.filereadable(path2) == 1 then
      return path2
    end
  end
end

-- Global function that searches the path for the required file
function find_required_path(module)
  -- Look at package.config for directory separator string (it's the first line)
  local sep = string.match(package.config, "^[^\n]")
  -- Properly change '.' to separator (probably '/' on *nix and '\' on Windows)
  local fname = vim.fn.substitute(module, "\\.", sep, "g")
  local f
  ---- First search for lua modules
  f = include_paths(fname, "lua")
  if f then
    return f
  end
  -- This part is just for nvim modules
  f = include_rtpaths(fname, "lua")
  if f then
    return f
  end
  ---- Now search for Fennel modules
  f = include_paths(fname, "fnl")
  if f then
    return f
  end
  -- This part is just for nvim modules
  f = include_rtpaths(fname, "fnl")
  if f then
    return f
  end
end

-- Set options to open require with gf
vim.opt_local.include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
vim.opt_local.includeexpr = "v:lua.find_required_path(v:fname)"
