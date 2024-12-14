local Snacks = require("snacks")
return {
  -- {
  --   dir = "~/projects/venv-selector.nvim",
  --   branch = "local_regexp",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  --   dev = true,
  --   lazy = false,
  --   enabled = true,
  --   cmd = "VenvSelect",
  --   --  Call config for python files and load the cached venv automatically
  --   ft = "python",
  --   keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  --   config = function()
  --     require("venv-selector").setup({
  --       settings = {
  --         options = {
  --           debug = true,
  --           notify_user_on_venv_activation = true,
  --           picker = "fzf-lua",
  --           cached_venv_automatic_activation = false,
  --           enabled_cached_envs = false,
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        options = {
          debug = false,
          cached_venv_automatic_activation = false,
          enabled_cached_envs = false,
        },
      },
    },
  },
  { "folke/which-key.nvim", opts = {
    preset = "helix",
    notify = false,
  } },
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
        ---@diagnostic disable-next-line: undefined-doc-name
        ---@type lspconfig.options
        servers = {
          -- clangd = {},
          bashls = {},
          gopls = {
            settings = {
              gopls = {
                gofumpt = true,
                codelenses = {
                  gc_details = true,
                  generate = true,
                  regenerate_cgo = true,
                  run_govulncheck = true,
                  test = true,
                  tidy = true,
                  upgrade_dependency = true,
                  vendor = true,
                },
                hints = {
                  assignVariableTypes = false,
                  compositeLiteralFields = false,
                  compositeLiteralTypes = false,
                  constantValues = false,
                  functionTypeParameters = false,
                  parameterNames = false,
                  rangeVariableTypes = true,
                },
                analyses = {
                  fieldalignment = true,
                  nilness = true,
                  unusedparams = true,
                  unusedwrite = true,
                  useany = true,
                },
                usePlaceholders = false,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
              },
            },
          },
          r_language_server = {
            root_dir = function(fname)
              return require("lspconfig.util").root_pattern("DESCRIPTION", "NAMESPACE", ".Rbuildignore")(fname)
                or require("lspconfig.util").find_git_ancestor(fname)
                ---@diagnostic disable-next-line: undefined-field
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
                  diagnosticMode = "workspace",
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
          harper_ls = {
            enabled = false,
            filetypes = { "markdown", "quarto", "python", "qmd" },
            settings = {
              ["harper-ls"] = {
                userDictPath = "~/dict.txt",
                linters = {
                  spell_check = true,
                  spelled_numbers = false,
                  an_a = true,
                  sentence_capitalization = true,
                  unclosed_quotes = true,
                  wrong_quotes = false,
                  long_sentences = true,
                  repeated_words = true,
                  spaces = true,
                  matcher = true,
                  correct_number_suffix = true,
                  number_suffix_capitalization = true,
                  multiple_sequential_pronouns = true,
                  linking_verbs = false,
                  avoid_curses = true,
                },
              },
            },
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
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "c",
        "lua",
        "luadoc",
        -- "latex",
        "vim",
        "vimdoc",
        "bash",
        "html",
        "markdown",
        "nu",
        "htmldjango",
        "markdown_inline",
        "python",
        "go",
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
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
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
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      lazygit = {
        theme = {
          selectedLineBgColor = { bg = "CursorLine" },
        },
      },
      dashboard = {
        -- preset = {
        --   header = "",
        -- },
        sections = {
          { section = "header", padding = 1 },
          { section = "keys", title = "Keymaps", padding = 1, indent = 3 },
          { section = "recent_files", title = "Recent Files", indent = 3, padding = 1 },
          { section = "startup" },
          {
            pane = 2,
            {
              { section = "terminal", cmd = "echo ' '", padding = 0 },
              { section = "projects", icon = " ", title = "Projects", indent = 3, padding = 1 },
              {
                section = "terminal",
                icon = " ",
                title = "Git Status",
                enabled = vim.fn.isdirectory(".git") == 1,
                cmd = "hub diff --stat -B -M -C",
                height = 10,
                padding = 1,
                indent = 3,
              },
            },
          },
        },
      },
    },
  },
}
