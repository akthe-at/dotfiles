return {
  { "folke/which-key.nvim", opts = {
    preset = "modern",
    notify = false,
  } },
  -- {
  --   dir = "C:/Users/ARK010/.plugins/venv-selector.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  --   dev = true,
  --   lazy = false,
  --   enabled = true,
  --   cmd = "VenvSelect",
  --   --  Call config for python files and load the cached venv automatically
  --   ft = "python",
  --   keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  --   config = function()
  --     local opts = {
  --       settings = {
  --         options = {
  --           picker = "fzf-lua",
  --           debug = true,
  --           notify_user_on_venv_activation = true,
  --         },
  --       },
  --     }
  --     require("venv-selector").setup(opts)
  --   end,
  -- },
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
