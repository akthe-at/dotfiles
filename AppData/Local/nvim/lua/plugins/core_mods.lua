local lsp = vim.g.lazyvim_python_lsp or "pyright"
return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    requires = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        picker = "fzf-lua",
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "tokyonight",
      -- colorscheme = "dracula",
      -- colorscheme = "rose-pine-dawn",
      colorscheme = "rose-pine-moon",
      -- colorscheme = "rose-pine",
      -- colorscheme = "miasma",
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
    opts = {
      ---@type lspconfig.options
      inlay_hints = {
        enabled = false,
      },
      codelens = {
        enabled = false,
      },
      servers = {
        -- clangd = {},
        -- gopls = {},
        bashls = {},
        r_language_server = {},
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
        powershell_es = {},
        ruff = {},
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
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "LazyFile", "VeryLazy" },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          -- When in diff mode, we want to use the default
          -- vim text objects c & C instead of the treesitter ones.
          local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
          local configs = require("nvim-treesitter.configs")
          for name, fn in pairs(move) do
            if name:find("goto") == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                  for key, query in pairs(config or {}) do
                    if q == query and key:find("[%]%[][cC]") then
                      vim.cmd("normal! " .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
        end,
      },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
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
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
