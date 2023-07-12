--- Plugins
function is_available(plugin)
	local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
	return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

if is_available("resession.nvim") then
	local function get_session_name()
		local name = vim.fn.getcwd()
		local branch = vim.fn.system("git branch --show-current")
		if vim.v.shell_error == 0 then
			return name .. branch
		else
			return name
		end
	end
	-- vim.api.nvim_create_autocmd("VimEnter", {
	--   callback = function()
	--     -- Only load the session if nvim was started with no args
	--     if vim.fn.argc(-1) == 0 then
	--       resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
	--     end
	--   end,
	-- })
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			local resession = require("resession")
			local session_name = resession.get_current() 
			if not session_name then
			  session_name = vim.fn.getcwd()
			  -- take basedir as a session name
			  -- session_name = session_name:match("([^/]+)$")
			end
			resession.save(session_name, { notify = false })
			resession.save("last")
		end,
	})
end
