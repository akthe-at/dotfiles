return {
  -- {
  --   dir = "C:/Users/ARK010/.plugins/venv-selector.nvim",
  --   branch = "regexp",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  --   dev = true,
  --   lazy = false,
  --   enabled = true,
  --   cmd = "VenvSelect",
  --   --  Call config for python files and load the cached venv automatically
  --   -- ft = "python",
  --   keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  --   opts = {
  --     settings = {
  --       debug = true,
  --       notify_user_on_venv_activation = true,
  --       -- picker = "fzf-lua",
  --     },
  --   },
  -- },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a list of adapter names,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          python = ".venv/Scripts/python",
        },
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          if LazyVim.has("trouble.nvim") then
            require("trouble").open({ mode = "quickfix", focus = false })
          else
            vim.cmd("copen")
          end
        end,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if LazyVim.has("trouble.nvim") then
        opts.consumers = opts.consumers or {}
        -- Refresh and auto close trouble after running tests
        ---@type neotest.Consumer
        opts.consumers.trouble = function(client)
          client.listeners.results = function(adapter_id, results, partial)
            if partial then
              return
            end
            local tree = assert(client:get_position(nil, { adapter = adapter_id }))

            local failed = 0
            for pos_id, result in pairs(results) do
              if result.status == "failed" and tree:get_key(pos_id) then
                failed = failed + 1
              end
            end
            vim.schedule(function()
              local trouble = require("trouble")
              if trouble.is_open() then
                trouble.refresh()
                if failed == 0 then
                  trouble.close()
                end
              end
            end)
            return {}
          end
        end
      end

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)
                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  -- stylua: ignore
  keys = {
    {"<leader>t", "", desc = "+test"},
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
  },
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        options = {
          debug = false,
        },
      },
    },
  },
  { "folke/which-key.nvim", opts = {
    preset = "modern",
    notify = false,
  } },
  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "bamboo",
      -- colorscheme = "tokyonight",
      -- colorscheme = "tokyonight-day",
      -- colorscheme = "dracula",
      -- colorscheme = "rose-pine-dawn",
      colorscheme = "rose-pine-moon",
      -- colorscheme = "flow",
      -- colorscheme = "rose-pine",
      -- colorscheme = "bluloco",
      -- colorscheme = "everforest",
      -- colorscheme = "cyberdream",
      -- colorscheme = "night-owl",
      -- colorscheme = "arctic",
      -- colorscheme = "gruvbox-material",
      -- colorscheme = "eldritch",
      -- colorscheme = "kanagawa",
      -- colorscheme = "catppuccin",
      -- colorscheme = "miss-dracula",
      -- colorscheme = "gruvbox",
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = function()
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
        inlay_hints = {
          enabled = true,
          exclude = {},
        },
        codelens = {
          enabled = false,
        },
        document_highlight = {
          enabled = true,
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        format = {
          formatting_options = nil,
          timous_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          -- clangd = {},
          -- gopls = {},
          bashls = {},
          r_language_server = {
            root_dir = function(fname)
              return require("lspconfig.util").root_pattern("DESCRIPTION", "NAMESPACE", ".Rbuildignore")(fname)
                or require("lspconfig.util").find_git_ancestor(fname)
                or vim.loop.os_homedir()
            end,
          },
          pylance = {
            enabled = false,
            settings = {
              python = {
                pythonPath = vim.fn.expand("~/.virtualenvs/neovim/Scripts/python"),
                analysis = {
                  diagnosticMode = "workspace",
                  typeCheckingMode = "basic",
                  completeFunctionParens = true,
                  autoFormatStrings = true,
                  inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                    callArgumentNames = true,
                    pytestParameters = true,
                  },
                },
              },
            },
          },
          basedpyright = {
            enabled = true,
            settings = {
              disableOrganizeImports = true,
              basedpyright = {
                analysis = {
                  -- ignore = { "*" },
                  typeCheckingMode = "standard",
                  diagnosticMode = "openFilesOnly",
                  useLibraryCodeForTypes = true,
                },
              },
            },
          },
          pyright = { enabled = false },
          powershell_es = {},
          ruff = { enabled = true },
          marksman = {},
          html = { filetypes = { "html", "htmldjango" } },
          -- rust_analyzer = {},
          tailwindcss = {
            filetypes_exclude = { "markdown", "md" },
            filetypes_include = { "html", "htmldjango" },
          },
          lua_ls = {
            settings = {
              Lua = {
                codeLens = {
                  true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
                workspace = {
                  checkThirdParty = false,
                },
                diagnostics = { disable = { "missing-fields" } },
              },
            },
          },
          djlsp = {
            cmd = { "djlsp" },
            filetypes = { "html", "htmldjango" },
            settings = {
              djlsp = {},
            },
          },
        },
        setup = {},
      }
      return ret
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "c",
        "lua",
        "luadoc",
        "latex",
        "vim",
        "vimdoc",
        "bash",
        "html",
        "markdown",
        "htmldjango",
        "markdown_inline",
        "python",
        "r",
        "rnoweb",
        "css",
        "sql",
        "query",
        "regex",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
  },
}
