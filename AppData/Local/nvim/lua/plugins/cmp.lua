return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          event = "InsertEnter",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
        keys = function()
          return {}
        end,
      },
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
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "otter" },
        { name = "luasnip", keyworld_length = 2 },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
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
            luasnip = "[LuaSnip]",
            path = "[Path]",
            buffer = "[Buffer]",
            cmp_r = "[R]",
            otter = "[Otter]",
          },
        }),
      }
      opts.experimental = {
        ghost_text = true,
      }
    end,
  },
}
