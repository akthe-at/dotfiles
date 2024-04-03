return {
  { "danymat/neogen", config = true },
  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 2, -- MiB (2 MiB is just over 2MB)
      features = {
        "indent_blankline",
        "lsp",
        "treesitter",
        "syntax",
        -- "matchparen", -- I'm not sure about this having a large impact on perf, and it stays disabled, so I'm going to comment it out
        "vimopts",
        "filetype",
        {
          name = "neoscroll",
          disable = function()
            vim.api.nvim_buf_set_var(0, "disable_neoscroll", true)
          end,
        },
      },
    },
  },
  {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown", "rmd", "qmd" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local custom = {
        codeblock_highlight = false,
        dash_string = "━",
      }
      local qmd = vim.tbl_deep_extend("force", custom, { treesitter_language = "markdown" })
      require("headlines").setup({
        markdown = custom,
        quarto = vim.tbl_deep_extend("force", require("headlines").config.markdown, qmd),
      })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>rf",
        function()
          require("refactoring").select_refactor({
            show_success_message = true,
          })
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "tokyonight",
      -- colorscheme = "kanagawa",
      -- colorscheme = "dracula",
      -- colorscheme = "rose-pine",
      -- colorscheme = "rose-pine-dawn",
      colorscheme = "eldritch",
      -- colorscheme = "catppuccin",
      -- colorscheme = "miss-dracula",
      -- colorscheme = "gruvbox",
    },
  },
  {
    "willothy/wezterm.nvim",
    config = true,
    cmd = "WeztermSpawn",
    event = { "LazyFile" },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      inlay_hints = {
        enabled = false,
      },
      codelens = {
        enabled = false,
      },
      servers = {
        clangd = {},
        gopls = {},
        bashls = {},
        r_language_server = {},
        pyright = {
          enabled = false,
        },
        basedpyright = {
          settings = {
            disableOrganizeImports = true,
            basedpyright = {
              analysis = {
                -- ignore = { "*" },
              },
              typeCheckingMode = "standard",
            },
          },
        },
        ruff_lsp = {},
        htmx = {},
        powershell_es = {},
        marksman = {},
        html = { filetypes = { "html", "htmldjango" } },
        rust_analyzer = {},
        tailwindcss = {
          filetypes_exclude = { "markdown" },
          filetypes_include = { "html", "htmldjango" },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      extensions_list = { "themes", "terms" },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
        },
      },
    },
  },
}
