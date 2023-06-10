local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
--
-- local statusline_str = ""
-- statusline_str = statusline_str .. "%#Normal# "
-- --statusline_str = statusline_str .. "%0* %n"
-- --statusline_str = statusline_str .. "%0* %{toupper(g:currentmode[mode()])}"
-- statusline_str = statusline_str .. "%0* %{toupper(mode())} "
-- --statusline_str = statusline_str .. "%1* %<%F%m%r%h%w "
-- statusline_str = statusline_str .. "%1* %<%f %M%R%w "
-- statusline_str = statusline_str .. "%3*│"
-- statusline_str = statusline_str .. "%2* %Y"
-- statusline_str = statusline_str .. "%3*│"
-- --statusline_str = statusline_str .. "%2* %{''.(&fenc!=''?&fenc:&enc).''}"
-- --statusline_str = statusline_str .. " (%{&ff})"
-- statusline_str = statusline_str .. "%="
-- --statusline_str = statusline_str .. "%2* col: %02v"
-- statusline_str = statusline_str .. "%2* %{g:lstartuptime}"
-- statusline_str = statusline_str .. "%3*│"
-- --statusline_str = statusline_str .. "%1* ln: %02l/%L (%3p%%)"
-- statusline_str = statusline_str .. "%1* %2l/%L:%v "
-- statusline_str = statusline_str .. "%#Normal# "
--
--vim.opt.statusline = "%<%f %h%m%r%=%-14.(%l,%c%V%) %P L:%{g:lstartuptime}"

-- local statusline_str = ""
function _G.append_v(v, chrl, chrr, vl)
  if v and v ~= "" then
    return chrl .. v .. chrr .. " "
  else
    return vl or ""
  end
end

local mode_names = {
  n = "N",
  no = "NO",
  nov = "NOV",
  noV = "N?",
  ["no\22"] = "N?",
  niI = "Ni",
  niR = "Nr",
  niV = "Nv",
  nt = "Nt",
  v = "V",
  vs = "vs",
  V = "VL",
  Vs = "VLs",
  ["\22"] = "VB",
  ["\22s"] = "VBS",
  s = "S",
  S = "S_",
  ["\19"] = "^S",
  i = "I",
  ic = "Ic",
  ix = "Ix",
  R = "R",
  Rc = "Rc",
  Rx = "Rx",
  Rv = "Rv",
  Rvc = "Rv",
  Rvx = "Rv",
  c = "C",
  cv = "Ex",
  r = "...",
  rm = "M",
  ["r?"] = "?",
  ["!"] = "!",
  t = "T",
}
-- Mode
function _G.getMode()
  return "" .. mode_names[vim.fn.mode(1)] .. ""
end

function _G.lazyupdates()
  local ok, lst = pcall(require, "lazy.status")
  if not ok then
    return ""
  end
  if lst.has_updates() then
    return " " .. require("lazy.status").updates() .. " "
  end
  return ""
end

-- Show diagnostic if exist
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
      .. (d_errors > 0 and ("%#DiagnosticError#" .. error_icon .. d_errors .. " ") or "")
      .. (d_warnings > 0 and ("%#DiagnosticWarn#" .. warn_icon .. d_warnings .. " ") or "")
      .. (d_hints > 0 and ("%#DiagnosticHint#" .. hint_icon .. d_hints .. " ") or "")
      .. (d_info > 0 and ("%#DiagnosticInfo#" .. info_icon .. d_info .. " ") or "")
  end

  return d_str
end

local winbar_str = ""
  .. "%="
  .. "%{%v:lua.Pdiagnostics()%}"
  -- .. "%{ v:lua.append_v(get(b:,'gitsigns_head',''),'  󰘬 ', '')}"
  --  󰘬 
  .. "%#Constant#%{ v:lua.append_v(get(b:,'gitsigns_head',''),'   ', '')}"

local statusline_str = ""
  .. "%#Normal# %0*"
  -- .. "%{get(b:,'gitsigns_status','')}"
  --
  -- .. " %<%f %M%R%w "
  -- .. " %<%{expand('%:~:.')} %M%R%w "
  .. " %<%{expand('%:~:.')!=#''?expand('%:~:.'):'[No Name]'} %M%R%w "
  .. " %Y "
  .. "%="
  .. "%{ get(b:,'lsp_clients','')}"
  .. "%<%="
  -- .. "%{get(g:,'lstartuptime','')}" -- startup time
  .. "%#Error#%{v:lua.lazyupdates()}%0*" -- startup time
  --.. "%#Special#%{get(g:,'lazyupdates','')}" -- lazy updates
  .. " %2l/%L:%v "
  -- .. "%1* %{toupper(mode())} "
  -- .. "%1* %2{toupper(g:currentmode[mode()])} "
  .. " %2{v:lua.getMode()} "
  .. "%#Normal# %0*"

-- -- statusline_str = statusline_str .. "%#Normal# "
-- -- --statusline_str = statusline_str .. "%0* %{toupper(g:currentmode[mode()])}"
-- -- --statusline_str = statusline_str .. "%1* %<%F%m%r%h%w "
-- -- --statusline_str = statusline_str .. "%1* %<%F%m%r%h%w "
-- -- statusline_str = statusline_str .. "%1* %<%f %M%R%w "
-- statusline_str  = statusline_str .. ""
-- statusline_str = statusline_str .. " %<%f %M%R%w "
-- -- statusline_str = statusline_str .. "%3*│"
-- -- statusline_str = statusline_str .. "%2* %Y"
-- -- statusline_str = statusline_str .. "%3*│"
-- -- --statusline_str = statusline_str .. "%2* %{''.(&fenc!=''?&fenc:&enc).''}"
-- -- --statusline_str = statusline_str .. " (%{&ff})"
-- statusline_str = statusline_str .. "%="
-- -- --statusline_str = statusline_str .. "%2* col: %02v"
-- -- statusline_str = statusline_str .. "%2* %{g:lstartuptime}"
-- -- statusline_str = statusline_str .. "%3*│"
-- -- --statusline_str = statusline_str .. "%1* ln: %02l/%L (%3p%%)"
-- -- statusline_str = statusline_str .. "%1* %2l/%L:%v "
-- statusline_str = statusline_str .. " %2l/%L:%v "
-- -- statusline_str = statusline_str .. "%0* %{toupper(mode())} "
-- statusline_str = statusline_str .. " %{toupper(mode())} "
-- -- statusline_str = statusline_str .. "%#Normal# "

vim.opt.statusline = statusline_str
vim.opt.winbar = winbar_str

-- Event of status

-- colorscheme
-- local function setColors()
-- 	vim.cmd([[
--     " au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
--     " au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
--     " hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
--
--     " hi User1  guibg=#4e4e4e guifg=#adadad
--     " hi User2  guibg=#303030 guifg=#adadad
--     " hi User3  guibg=#303030 guifg=#303030
--     " hi User4  guibg=#4e4e4e guifg=#4e4e4e
--     ]])
-- end

--
-- require("lualine").setup({
--  sections = {
--     lualine_x = {
--       {
--         require("lazy.status").updates,
--         cond = require("lazy.status").has_updates,
--         color = { fg = "#ff9e64" },
--       },
--     },
--   },
-- })
