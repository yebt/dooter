local M = {}

M.runners = {
  -- primer nivel contiene el filetype que dispara las posibles opciones
  php = {
    -- Lista de posibles opciones o configuraciones, donde el tag permite distinguir entr
    -- el tipo de proyecto, este podria ser como node, laravel, ["laravel 7"], etc
    tag = {
      structs = {
        -- No es obligatorio, en caso de no existir significa que es un single file
        -- listado de archivos que deben de existir para que se acepte esta configuración
        -- del runer
        -- si están bajo la misma lista, deben existir todos para que se acepte la configuración
        -- { "package.json" } -- solo necesita que exista este archivo en el root para aceptar
        -- { "composer.json", "artisan" } -- necesita que existan ambos
        -- { "composer.json", "artisan" }, { "composer.json" } -- puede existir cualquiera de los 2 conjuntos para cimplir
        -- { "src/", "app/env/" }, -- aqui require que existan esas 2 carpetas
      },
      --- peude ser una lista o una función que retorna una lsita
      -- en caso de ser una función, se ejecuta para calcular los cmds a usar
      cmds = {
        -- No es opcional
        -- lista de comandos en struing que se pueden seleccionar al
        -- momento de querer correr el proyecto o ejecutar el archivo
      },
      execs = {
        -- son comandos adicionales que se pueden consultar para ejecutar acciones adicionales
        {
          instuctions = { "" }, -- instruncciones a ejecutar
          t = "", -- cmd | nvim
          -- si es cmd, abre una terminal flotante para ejecutar el parametro instuctions
          -- si es nvim los ejecuta en nvim como si se ejecutara un registro gravado o macro
        },
      },
    },
  },
}

--- does a path exist?.
-- @string P A file path
-- @return the file path if it exists, nil otherwise
function path_exists(P)
  -- local stat = vim.loop.fs_stat(path)
  -- return stat and stat.type ~= nil
  return vim.fn.glob(path) ~= ""
end

-- Función para obtener la configuración de ejecución
function M.get_run_config()
  -- Primero, verificamos la variable global
  local global_run_config = vim.g.runner_config

  if global_run_config ~= nil then
    return global_run_config
  end

  -- Luego, verificamos la variable del buffer
  local buffer_run_config = vim.b.runner_config

  if buffer_run_config ~= nil then
    return buffer_run_config
  end

  -- Si no hay configuración almacenada, determinamos la correcta basándonos en M.runners
  --
  local filetype = vim.bo.filetype
  -- puede que no halla abierto ningun archivo aún
  if filetype then
    local run_configs = M.runners[filetype]
    if run_configs then
      -- dinamic searched files
      local dinamyc_sf = {}
      -- como un filetype puede tener asociado multiples config
      -- buscar
      for tag, single_config in pairs(run_configs) do
        -- search on struct
        -- como struct puede ser varios, buscar cual struct encuentra primero
        for _, single_struct in pairs(single_config.structs) do
          -- search files
          local ok_config = true
          for _, single_file in pairs(single_struct) do
            if not dinamyc_sf[single_file] and not path_exists(single_file) then
              ok_config = false
              break
            end
            dinamyc_sf[single_file] = true
          end
          -- Ok all files exist set config
          if ok_config then
            single_config.tag = tag -- use tag to show
            vim.g.runner_config = single_config
            return single_config
          end
        end
      end
    end
  else
    -- en caso de que no exista archivo abierto, buscar en todo
    -- se ignoran los que no poseen el atributo struct, porque
    -- como no tenemos un archivo en que basarnos, no es posible asumir
    -- las configuraciones pensadas para singlefiles
  end

  return nil
  ----

  -- local filetype = M.detect_filetype()

  -- if M.runners[filetype] ~= nil then
  --   local run_config = M.runners[filetype]

  --   -- Verificamos si la estructura de directorios coincide
  --   for _, struct in ipairs(run_config.struct) do
  --     local handle = io.popen("ls")
  --     local result = handle:read("*a")
  --     handle:close()

  --     -- Verificamos si todos los archivos/carpetas de la estructura existen
  --     local struct_exists = true
  --     for _, file_or_folder in ipairs(struct) do
  --       if not string.match(result, file_or_folder) then
  --         struct_exists = false
  --         break
  --       end
  --     end

  --     if struct_exists then
  --       -- Almacenamos la configuración en la variable global
  --       vim.g.runner_config = run_config
  --       return run_config
  --     end
  --   end
  -- end
end

return M
