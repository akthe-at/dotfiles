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
      format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- custom script for using stylr on R files
        -- rpretty = {
        --   inherit = false,
        --   stdin = false,
        --   command = "StyleScript",
        --   args = { "$FILENAME" },
        -- },
        sql_formatter = {
          prepend_args = { "-c", vim.fn.expand("~/.config/sql_formatter.json") },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        htmldjango = { "djlint" },
        quarto = { "injected" },
        javascript = { "prettier" },
        -- r = { "rpretty" },
        sh = { "shfmt" },
        sql = { "sql_formatter" },
        ["*"] = { "injected" },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "LazyFile",
    branch = "canary",
    cmd = "CopilotChat",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        model = "gpt-4",
        auto_insert_mode = false,
        show_help = true,
        debug = false,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        allow_insecure = true,
        disable_extra_info = "no",
        language = "English",
        window = {
          width = 0.4,
        },
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source) or select.buffer(source)
        end,
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").clear()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show help actions with telescope
      { "<leader>ad", M.pick("help"), desc = "Diagnostic Help (CopilotChat)", mode = { "n", "v" } },
      -- Show prompts actions with telescope
      { "<leader>ap", M.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      require("CopilotChat.integrations.cmp").setup()

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "copilot-chat",
        title = "Copilot Chat",
        size = { width = 50 },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "f3fora/cmp-spell",
      "ray-x/cmp-treesitter",
      -- "jmbuhr/otter.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "R-nvim/cmp-r",
      "luckasRanarison/tailwind-tools.nvim",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function(_, opts)
          local copilot_cmp = require("copilot_cmp")
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          LazyVim.lsp.on_attach(function(client)
            if client.name == "copilot" then
              copilot_cmp._on_insert_enter({})
            end
          end)
        end,
      },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local auto_select = true
      return {
        auto_brackets = {},
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "cmp_r" },
          { name = "tailwindcss" },
          { name = "luasnip" },
          -- { name = "otter" },
          { name = "path" },
          { name = "buffer", keyword_length = 3 },
          { name = "spell" },
          { name = "pandoc_references" },
          { name = "treesitter" },
        }),
        view = { entries = { follow_cursor = true } },
        formatting = {
          format = function(entry, item)
            local icons = LazyVim.config.icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end
            return item
          end,
        },
        sorting = defaults.sorting,
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      },
        table.insert(opts.sources, 1, {
          name = "copilot",
          group_index = 1,
          priority = 100,
        })
    end,
    main = "lazyvim.util.cmp",
    ---@param opts cmp.ConfigSchema | {auto_brackets?: string[]}
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      local parse = require("cmp.utils.snippet").parse
      require("cmp.utils.snippet").parse = function(input)
        local ok, ret = pcall(parse, input)
        if ok then
          return ret
        end
        return LazyVim.cmp.snippet_preview(input)
      end
      local cmp = require("cmp")
      cmp.setup(opts)
      cmp.event:on("confirm_done", function(event)
        if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
          LazyVim.cmp.auto_brackets(event.entry)
        end
      end)
      cmp.event:on("menu_opened", function(event)
        LazyVim.cmp.add_missing_snippet_docs(event.window)
      end)
    end,
  },
  vim.fn.has("nvim-0.10") == 1
      and {
        "nvim-cmp",
        dependencies = {
          {
            "garymjr/nvim-snippets",
            opts = {
              friendly_snippets = true,
            },
            dependencies = {
              "rafamadriz/friendly-snippets",
            },
          },
          { "saadparwaiz1/cmp_luasnip" },
          {
            "L3MON4D3/LuaSnip",
            dependencies = {
              "rafamadriz/friendly-snippets",
              "saadparwaiz1/cmp_luasnip",
            },
          },
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
        opts = function(_, opts)
          local ls = require("luasnip")
          ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            override_builtin = true,
          })

          for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
            loadfile(ft_path)()
          end

          vim.snippet.expand = ls.lsp_expand
          ---@diagnostic disable-next-line: duplicate-set-field
          vim.snippet.active = function(filter)
            filter = filter or {}
            filter.direction = filter.direction or 1

            if filter.direction == 1 then
              return ls.expand_or_jumpable()
            else
              return ls.jumpable(filter.direction)
            end
          end

          ---@diagnostic disable-next-line: duplicate-set-field
          vim.snippet.jump = function(direction)
            if direction == 1 then
              if ls.expandable() then
                return ls.expand_or_jump()
              else
                return ls.jumpable(-1) and ls.jump(1)
              end
            else
              return ls.jumpable(-1) and ls.jump(-1)
            end
          end

          vim.snippet.stop = ls.unlink_current

          opts.snippet = {
            expand = function(item)
              return LazyVim.cmp.expand(item.body)
            end,
          }
          table.insert(opts.sources, { name = "snippets" })
        end,
        keys = {
          {
            "<C-l>",
            function()
              return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
            end,
            silent = true,
            mode = { "i", "s" },
          },
          {
            "<C-h>",
            function()
              return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
            end,
            expr = true,
            silent = true,
            mode = { "i", "s" },
          },
        },
      }
    or { import = "lazyvim.plugins.extras.coding.luasnip", enabled = vim.fn.has("nvim-0.10") == 0 },
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
