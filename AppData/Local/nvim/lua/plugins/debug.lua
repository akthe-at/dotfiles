return {
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
  -- stylua: ignore
  keys = {
    { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
    { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
  },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
      local dap = require("dap")
      dap.adapters.python = function(cb, config)
        if config.request == "attach" then
          ---@diagnostic disable-next-line: undefined-field
          local port = (config.connect or config).port
          ---@diagnostic disable-next-line: undefined-field
          local host = (config.connect or config).host or "127.0.0.1"
          cb({
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
              source_filetype = "python",
            },
          })
        else
          cb({
            type = "executable",
            command = "C:\\Users\\ARK010\\AppData\\Local\\Programs\\Python\\Python312\\pythonw.exe",
            args = { "-m", "debugpy.adapter" },
            options = {
              source_filetype = "python",
            },
          })
        end
      end
      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = "launch",
          name = "Launch file",

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
          justMyCode = false,
          program = "${file}", -- This configuration will launch the current file if used.
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/Scripts/pythonw.exe") == 1 then
              return cwd .. "/venv/Scripts/pythonw.exe"
            elseif vim.fn.executable(cwd .. "/.venv/Scripts/pythonw.exe") == 1 then
              return cwd .. "/.venv/Scripts/pythonw.exe"
            else
              return "C:\\Users\\ARK010\\.virtualenvs\\debugpy\\Scripts\\pythonw.exe"
            end
          end,
        },
      }
    end,
  },
}
