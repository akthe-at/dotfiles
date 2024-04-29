return {
  {
    "numToStr/Comment.nvim",
    event = "LazyFile",
    version = nil,
    branch = "master",
    opts = {},
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
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    opts = {
      format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- custom script for using stylr on R files
        rpretty = {
          inherit = false,
          stdin = false,
          command = "StyleScript",
          args = { "$FILENAME" },
        },
        sql_formatter = {
          prepend_args = { "-c", vim.fn.expand("~/.config/sql_formatter.json") },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        htmldjango = { "djlint" },
        javascript = { "prettier" },
        r = { "rpretty" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        ["*"] = { "injected" },
      },
    },
  },
  {
    -- doing it like this because I don't like copilot being in my cmp menu, I would rather have it show up as just ghost text that I can tab accept, or shift tab to bypass and add a real tab to the document.
    "github/copilot.vim",
    event = "LazyFile",
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
        keys = function()
          return {}
        end,
      },
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "ray-x/cmp-treesitter",
      "kdheepak/cmp-latex-symbols",
      "jmbuhr/otter.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "R-nvim/cmp-r",
      "luckasRanarison/tailwind-tools.nvim",
    },
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }
      opts.sources = {
        -- { name = "copilot" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp" },
        { name = "otter" },
        { name = "luasnip", keyworld_length = 2 },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
        { name = "spell" },
        { name = "pandoc_references" },
        { name = "treesitter" },
        { name = "calc" },
        { name = "emoji" },
        { name = "latex_symbols" },
      }
      opts.view = { entries = { follow_cursor = true } }
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.config.disable,
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      })
      table.insert(opts.snippet, { name = "luasnip" })
      opts.formatting = {
        format = lspkind.cmp_format({
          before = require("tailwind-tools.cmp").lspkind_format,
          with_text = true,
          menu = {
            -- copilot = "[Copilot]",
            nvim_lsp = "[LSP]",
            otter = "[Otter]",
            luasnip = "[LuaSnip]",
            cmp_r = "[R]",
            path = "[Path]",
            spell = "[Spell]",
            pandoc_references = "[Pandoc]",
            treesitter = "[Treesitter]",
            calc = "[Calc]",
            emoji = "[Emoji]",
            latex_symbols = "[Latex]",
            buffer = "[Buffer]",
          },
        }),
      }
      opts.experimental = {
        ghost_text = true,
      }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      -- Event to trigger linters
      linters_by_ft = {
        -- python = { },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
      },
      -- LazyVim extension to easily override linter options
      -- or add custom linters.
      ---@type table<string,table>
      linters = {
        -- -- Example of using selene only when a selene.toml file is present
        -- selene = {
        --   -- `condition` is another LazyVim extension that allows you to
        --   -- dynamically enable/disable linters based on the context.
        --   condition = function(ctx)
        --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
  },
  {
    "mbbill/undotree",
    event = "LazyFile",
    config = function()
      -- Save undo history
      --Undo tree
      vim.g.undotree_DiffCommand = "FC"
      vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)
    end,
  },
}
