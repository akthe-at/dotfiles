local M = {}

---@param kind string
function M.pick(kind)
  return function()
    local actions = require("CopilotChat.actions")
    local items = actions[kind .. "_actions"]()
    if not items then
      LazyVim.warn("No " .. kind .. " found on the current line")
      return
    end
    local ok = pcall(require, "fzf-lua")
    require("CopilotChat.integrations." .. (ok and "fzflua" or "telescope")).pick(items)
  end
end

return {
  {
    "ray-x/go.nvim",
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "numToStr/Comment.nvim",
    event = "LazyFile",
    version = nil,
    cond = function()
      return vim.fn.has("nvim-0.10") == 0
    end,
    branch = "master",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    lazy = true,
    dependencies = { "mason.nvim" },
    cmd = "ConformInfo",
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
      },
      formatters = {
        injected = {
          options = { ignore_errors = false },
          lang_to_ext = {
            bash = "sh",
            c_sharp = "cs",
            elixir = "exs",
            javascript = "js",
            julia = "jl",
            latex = "tex",
            markdown = "md",
            python = "py",
            ruby = "rb",
            rust = "rs",
            teal = "tl",
            quarto = "qmd",
            -- r = "r",
            typescript = "ts",
          },
          lang_to_formatters = {},
        },
        -- sql_formatter = {
        --   prepend_args = { "-c", vim.fn.expand("~/.config/sql_formatter.json") },
        -- },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        htmldjango = { "djlint" },
        quarto = { "injected" },
        javascript = { "prettier" },
        sh = { "shfmt" },
        -- sql = { "sql_formatter" },
        ["*"] = { "injected" },
      },
    },
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   version = false, -- last release is way too old
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "R-nvim/cmp-r",
  --     "luckasRanarison/tailwind-tools.nvim",
  --     "onsails/lspkind-nvim",
  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",
  --   },
  --   -- Not all LSP servers add brackets when completing a function.
  --   -- To better deal with this, LazyVim adds a custom option to cmp,
  --   -- that you can configure. For example:
  --   --
  --   -- ```lua
  --   -- opts = {
  --   --   auto_brackets = { "python" }
  --   -- }
  --   -- ```
  --   opts = function()
  --     vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  --     local cmp = require("cmp")
  --     local defaults = require("cmp.config.default")()
  --     local auto_select = true
  --     return {
  --       auto_brackets = {},
  --       completion = {
  --         completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
  --       },
  --       preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-h>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-l>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<C-y>"] = LazyVim.cmp.confirm({ select = auto_select }),
  --         -- ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
  --         ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         ["<C-CR>"] = function(fallback)
  --           cmp.abort()
  --           fallback()
  --         end,
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "copilot" },
  --         { name = "CopilotChat" },
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --         { name = "path" },
  --         { name = "cmp_r" },
  --         { name = "tailwindcss" },
  --       }, {
  --         { name = "buffer", keyword_length = 3 },
  --       }),
  --       view = { entries = { follow_cursor = true } },
  --       formatting = {
  --         format = function(entry, item)
  --           local icons = LazyVim.config.icons.kinds
  --           if icons[item.kind] then
  --             item.kind = icons[item.kind] .. item.kind
  --           end
  --
  --           local widths = {
  --             abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
  --             menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
  --           }
  --
  --           for key, width in pairs(widths) do
  --             if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
  --               item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
  --             end
  --           end
  --
  --           return item
  --         end,
  --       },
  --       experimental = {
  --         ghost_text = {
  --           hl_group = "CmpGhostText",
  --         },
  --       },
  --       sorting = defaults.sorting,
  --     }
  --   end,
  --   main = "lazyvim.util.cmp",
  -- },
  -- --snippets
  -- {
  --   "nvim-cmp",
  --   optional = true,
  --   dependencies = {
  --     {
  --       "garymjr/nvim-snippets",
  --       opts = {
  --         friendly_snippets = true,
  --       },
  --       dependencies = { "rafamadriz/friendly-snippets" },
  --     },
  --   },
  --   opts = function(_, opts)
  --     opts.snippet = {
  --       expand = function(item)
  --         return LazyVim.cmp.expand(item.body)
  --       end,
  --     }
  --     if LazyVim.has("nvim-snippets") then
  --       table.insert(opts.sources, { name = "snippets" })
  --     end
  --   end,
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   version = false,
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "R-nvim/cmp-r",
  --     "luckasRanarison/tailwind-tools.nvim",
  --     "onsails/lspkind-nvim",
  --     -- "ray-x/cmp-treesitter",
  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",
  --     -- {
  --     --   "zbirenbaum/copilot-cmp",
  --     --   dependencies = "copilot.lua",
  --     --   opts = {},
  --     --   config = function(_, opts)
  --     --     local copilot_cmp = require("copilot_cmp")
  --     --     copilot_cmp.setup(opts)
  --     --     -- attach cmp source whenever copilot attaches
  --     --     -- fixes lazy-loading issues with the copilot cmp source
  --     --     LazyVim.lsp.on_attach(function(client)
  --     --       if client.name == "copilot" then
  --     --         copilot_cmp._on_insert_enter({})
  --     --       end
  --     --     end)
  --     --   end,
  --     -- },
  --   },
  --   opts = function()
  --     vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  --     local cmp = require("cmp")
  --     local defaults = require("cmp.config.default")()
  --     local auto_select = true
  --     return {
  --       auto_brackets = {}, --config any filetype to auto add brackets
  --       completion = {
  --         completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
  --       },
  --       preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<CR>"] = cmp.config.disable,
  --         -- ["<C-y>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         ["<C-y>"] = LazyVim.cmp.confirm({ select = auto_select }),
  --         ["<C-CR>"] = function(fallback)
  --           cmp.abort()
  --           fallback()
  --         end,
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "copilot" },
  --         { name = "CopilotChat" },
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --         { name = "path" },
  --         { name = "cmp_r" },
  --         { name = "tailwindcss" },
  --       }, {
  --         { name = "buffer", keyword_length = 3 },
  --       }),
  --       -- view = { entries = { follow_cursor = false } },
  --       formatting = {
  --         format = function(entry, item)
  --           local icons = LazyVim.config.icons.kinds
  --           if icons[item.kind] then
  --             item.kind = icons[item.kind] .. item.kind
  --           end
  --
  --           local widths = {
  --             abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
  --             menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
  --           }
  --
  --           for key, width in pairs(widths) do
  --             if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
  --               item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
  --             end
  --           end
  --
  --           return item
  --         end,
  --       },
  --       experimental = {
  --         ghost_text = vim.g.ai_cmp and {
  --           hl_group = "CmpGhostText",
  --         } or false,
  --       },
  --       sorting = defaults.sorting,
  --     }
  --   end,
  --   main = "lazyvim.util.cmp",
  -- },
  -- {
  --   "nvim-cmp",
  --   dependencies = {
  --     {
  --       "garymjr/nvim-snippets",
  --       opts = {
  --         friendly_snippets = true,
  --       },
  --       dependencies = {
  --         "rafamadriz/friendly-snippets",
  --       },
  --     },
  --     { "saadparwaiz1/cmp_luasnip" },
  --     {
  --       "L3MON4D3/LuaSnip",
  --       lazy = true,
  --       build = "make install_jsregexp",
  --       dependencies = {
  --         "rafamadriz/friendly-snippets",
  --         "saadparwaiz1/cmp_luasnip",
  --       },
  --     },
  --     config = function()
  --       require("luasnip.loaders.from_vscode").lazy_load()
  --     end,
  --   },
  --   opts = function(_, opts)
  --     local ls = require("luasnip")
  --     ls.config.set_config({
  --       history = true,
  --       updateevents = "TextChanged,TextChangedI",
  --       override_builtin = true,
  --     })
  --
  --     require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snips" } })
  --     -- link quarto and rmarkdown to markdown snippets
  --     ls.filetype_extend("quarto", { "markdown" })
  --     ls.filetype_extend("rmarkdown", { "markdown" })
  --     for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
  --       loadfile(ft_path)()
  --     end
  --
  --     vim.snippet.expand = ls.lsp_expand
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.snippet.active = function(filter)
  --       filter = filter or {}
  --       filter.direction = filter.direction or 1
  --
  --       if filter.direction == 1 then
  --         return ls.expand_or_jumpable()
  --       else
  --         return ls.jumpable(filter.direction)
  --       end
  --     end
  --
  --     ---@diagnostic disable-next-line: duplicate-set-field
  --     vim.snippet.jump = function(direction)
  --       if direction == 1 then
  --         if ls.expandable() then
  --           return ls.expand_or_jump()
  --         else
  --           return ls.jumpable(-1) and ls.jump(1)
  --         end
  --       else
  --         return ls.jumpable(-1) and ls.jump(-1)
  --       end
  --     end
  --
  --     vim.snippet.stop = ls.unlink_current
  --
  --     opts.snippet = {
  --       expand = function(item)
  --         return LazyVim.cmp.expand(item.body)
  --       end,
  --     }
  --     table.insert(opts.sources, { name = "snippets" })
  --   end,
  --   keys = {
  --     {
  --       "<C-l>",
  --       function()
  --         return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
  --       end,
  --       silent = true,
  --       mode = { "i", "s" },
  --     },
  --     {
  --       "<C-h>",
  --       function()
  --         return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
  --       end,
  --       expr = true,
  --       silent = true,
  --       mode = { "i", "s" },
  --     },
  --   },
  -- } or { import = "lazyvim.plugins.extras.coding.luasnip", enabled = vim.fn.has("nvim-0.10") == 0 },
  {
    "mbbill/undotree",
    event = "LazyFile",
    config = function()
      -- Save undo history
      vim.g.undotree_DiffCommand = "FC"
      vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)
    end,
  },
}
