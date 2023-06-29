--

function _G.Lazyupdates()
  local ok, lst = pcall(require, "lazy.status")
  if not ok then
    return ""
  end
  if lst.has_updates() then
    return " " .. require("lazy.status").updates() .. " "
  end
  return ""
end

local function get_diag_text(d)
  local dtxt = d and d.text or ""
  return dtxt
end

function _G.Pdiagnostics()
  local d_str = ""
  local diagnostics = vim.diagnostic.get()
  if diagnostics and next(diagnostics) ~= nil then
    local error_icon = get_diag_text(vim.fn.sign_getdefined("DiagnosticSignError")[1])
    local warn_icon = get_diag_text(vim.fn.sign_getdefined("DiagnosticSignWarn")[1])
    local info_icon = get_diag_text(vim.fn.sign_getdefined("DiagnosticSignInfo")[1])
    local hint_icon = get_diag_text(vim.fn.sign_getdefined("DiagnosticSignHint")[1])

    local d_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local d_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local d_hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    local d_info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

    d_str = ""
      .. "<< "
      .. (d_errors > 0 and ("%4*" .. error_icon .. d_errors .. " ") or "")
      .. (d_warnings > 0 and ("%6*" .. warn_icon .. d_warnings .. " ") or "")
      .. (d_hints > 0 and ("%7*" .. hint_icon .. d_hints .. " ") or "")
      .. (d_info > 0 and ("%8*" .. info_icon .. d_info .. " ") or "")
      .. "%0*"
      .. ">>"
  end

  return d_str
end

function _G.append_v(v, chrl, chrr, vl)
  if v and v ~= "" then
    return chrl .. v .. chrr .. " "
  else
    return vl or ""
  end
end

function _G.copilotst()
  --  Copilot = "   ",
  local ok, cpltapi = pcall(require, "copilot.api")
  if not ok then
    return ""
  end
  local scolors = {
    [""] = "%2*",
    ["Normal"] = "%2*",
    ["Warning"] = "%3*",
    ["InProgress"] = "%4*",
  }
  local icon = "   "
  local status = require("copilot.api").status.data
  ----vim.notify(vim.inspect(status))
  return scolors[status.status] .. icon .. (status.message or "") .. "%0*"
end

--

local constant_hl = vim.api.nvim_get_hl(0, { name = "Constant" })
local error_hl = vim.api.nvim_get_hl(0, { name = "Error" })
local diagnosticwarn_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })
local diagnosticerror_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
local diagnostichint_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" })
local diagnosticinfo_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo" })

-- local diagnostic_hl = vim.api.nvim_get_hl(0, { name = "DiagnosticHint" })
local special_hl = vim.api.nvim_get_hl(0, { name = "Special" })
local statusline_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })

vim.api.nvim_set_hl(0, "User1", { bg = statusline_hl.bg, fg = constant_hl.fg })
vim.api.nvim_set_hl(0, "User5", { bg = statusline_hl.bg, fg = error_hl.fg, bold = true })
vim.api.nvim_set_hl(0, "User2", { fg = statusline_hl.bg, bg = special_hl.fg, bold = true })
vim.api.nvim_set_hl(0, "User3", { fg = statusline_hl.bg, bg = diagnosticerror_hl.fg, bold = true })
vim.api.nvim_set_hl(0, "User4", { bg = statusline_hl.bg, fg = diagnosticerror_hl.fg })

vim.api.nvim_set_hl(0, "User6", { bg = statusline_hl.bg, fg = diagnosticwarn_hl.fg })
vim.api.nvim_set_hl(0, "User7", { bg = statusline_hl.bg, fg = diagnostichint_hl.fg })
vim.api.nvim_set_hl(0, "User8", { bg = statusline_hl.bg, fg = diagnosticinfo_hl.fg })

--
local status_str = ""
  .. "%#Normal# %0*" -- xpadding
  -- .. "%#Constant#%{ get(b:,'gitsigns_head','')}%0*"
  .. "%1*%{ v:lua.append_v(get(b:,'gitsigns_head',''),'  [', ']')}%0*"
  -- .. "%<%f %h%m%r%=%-14.(%l,%c%V%) %P"
  .. "%<%f "
  .. "%h%m%r"
  .. " %{%v:lua.Pdiagnostics()%}"
  .. "%=" -- separator
  .. "%{ get(b:,'lsp_clients','')}"
  .. "%=" -- separator
  .. "%{%v:lua.copilotst()%}"
  .. "%5*%{v:lua.Lazyupdates()}%0*" -- startup time
  -- .. "%-14.(%l/%L:%c%V%)"
  -- .. "%-14.(%l/%L:%c%V%) %P"
  -- .. " %2l/%L:%c%V "
  .. " %2l/%L:%c "
  .. "%#Normal# %0*" -- xpadding

local winbar_str = ""
--
vim.opt.statusline = status_str
vim.opt.winbar = winbar_str