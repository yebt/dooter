return { -- table of filetypes
	-- filetype def
	javascript = { -- table of tags
		-- tag def
		node = { -- table with options
			-- struct option
			structs = { -- table with set of files
				-- set of files
				{ -- table with files
					"package.json", --
					-- "node_modules",
				},
				{ -- table with files
					"package.j", --
					"node_modules",
				},
			},
			-- table | function -> return a table
			cmds = function()
				local scripts = {}

				-- Abre el archivo package.json y lee su contenido
				local file = io.open("package.json", "r")
				if file then
					local content = file:read("*all")
					file:close()

					-- Parsea el contenido del archivo JSON en una tabla
					-- local package = json.decode(content)
					local package = vim.json.decode(content)

					-- Si la clave scripts existe, la copia en la variable scripts
					if package.scripts then
						scripts = package.scripts
					end
				end

				return scripts
			end,
			ovcmds = true, -- recall the function to get cmds,
			execs = {
				-- {
				--   instructions = { "" },
				--   -- c, n, i
				--   t = "",
				-- },
			},
		},
	},

	python = {
		default = {
			cmds = {
				run = "python %",
			},
		},
	},
}
