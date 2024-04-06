return {
  { "xiyaowong/transparent.nvim", lazy = false },
  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "html" },
    opts = {},
  },
  {
    "eldritch-theme/eldritch.nvim",
    priority = 1000,
    keys = {
      { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    opts = {},
    config = function()
      require("eldritch").setup({
        dim_inactive = true,
        transparent = false,
        hide_inactive_statusline = true,
        lualine_bold = true,
      })
      vim.o.termguicolors = true
    end,
  },
  -- {
  --   "mofiqul/dracula.nvim",
  --   lazy = true,
  --   enabled = true,
  --   priority = 1000,
  --   keys = {
  --     { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  --   },
  --   opts = {},
  --   config = function()
  --     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --       border = "rounded",
  --     })
  --   end,
  -- },
  -- {
  --   "maxmx03/dracula.nvim",
  --   lazy = true,
  --   enabled = true,
  --   priority = 1000,
  --   keys = {
  --     { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  --   },
  --   opts = {},
  --   config = function()
  --     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --       border = "rounded",
  --     })
  --   end,
  -- },
  {
    "binhtran432k/dracula.nvim", -- There are a lot of dracula esque nvim themes but I like this one the most so far.
    lazy = true,
    enabled = true,
    priority = 1000,
    keys = {
      { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    opts = {},
    -- config = function()
    --   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --     border = "rounded",
    --   })
    -- end,
  },
  -- {
  --   "sainnhe/everforest",
  --   name = "everforest",
  --   enabled = true,
  --   lazy = true,
  --   keys = {
  --     { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  --   },
  --   priority = 1000,
  --   config = function()
  --     vim.g.everforest_background = "hard"
  --     vim.g.everforest_dim_inactive_windows = 1
  --     vim.g.everforest_ui_contrast = "high"
  --     vim.g.everforest_enable_italic = 1
  --     vim.g.everforest_better_performance = 1
  --   end,
  -- },
  -- {
  --   "fynnfluegge/monet.nvim",
  --   name = "monet",
  --   lazy = true,
  --   enabled = false,
  --   keys = {
  --     { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  --   },
  --   opts = { transparent_background = false },
  -- },
  {
    "catppuccin/nvim",
    lazy = true,
    keys = {
      { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    enabled = true,
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      transparent_background = false,
      integrations = {
        aerial = true,
        alpha = true,
        harpoon = true,
        fidget = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
      color_overrides = {
        mocha = {
          -- I don't think these colours are pastel enough by default!
          peach = "#fcc6a7",
          green = "#d2fac5",
        },
      },
    },
  },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   enabled = true,
  --   lazy = true,
  --   keys = {
  --     { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  --   },
  --   priority = 1000,
  --   opts = {
  --     transparent = false,
  --     theme = "wave",
  --   },
  -- },
  -- {
  --   "ribru17/bamboo.nvim",
  --   enabled = false,
  --   lazy = true,
  --   keys = {
  --     { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  --   },
  --   priority = 1000,
  -- },
  {
    "rockyzhang24/arctic.nvim",
    enabled = true,
    lazy = true,
    keys = {
      { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    priority = 1000,
    branch = "main",
    name = "arctic",
    dependencies = { "rktjmp/lush.nvim" },
  },
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = false,
  --   keys = {
  --     { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  --   },
  --   enabled = true,
  --   priority = 1000,
  --   opts = {},
  -- },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    enabled = true,
    lazy = true,
    keys = {
      { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    config = true,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "soft", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = true,
    opts = {
      -- sidebars = "dark",
      -- style = "night",
      -- floats = "dark",
      -- dim_inactive = true,
      -- hide_inactive_statusline = true,
      -- lualine_bold = true,
    },
    config = function()
      require("tokyonight").setup({
        style = "night",
        dim_inactive = true,
        transparent = false,
        hide_inactive_statusline = true,
        lualine_bold = true,
      })
      vim.o.termguicolors = true
    end,
  },
  {
    "sainnhe/gruvbox-material",
    enabled = false,
    keys = {
      { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    priority = 1000,
    lazy = true,
    config = true,
    opts = {},
  },
  {
    "rose-pine/neovim",
    enabled = true,
    name = "rose-pine",
    priority = 1000,
    keys = {
      { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "moon",
        dim_inactive_windows = true,
        extend_background_behind_borders = false,
        styles = { bold = true, italic = true, transparency = false },
        groups = {
          border = "pine", --"pine",
        },
        highlight_groups = {
          TelescopeResultsTitle = { fg = "rose", bg = "surface" },
          TelescopeBorder = { fg = "rose", bg = "surface" },
          TelescopeSelection = { fg = "text", bg = "overlay", bold = true },
          TelescopeSelectionCaret = { fg = "text", bg = "highlight_med" },
          TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
          TelescopeTitle = { fg = "base", bg = "love" },
          TelescopePromptTitle = { fg = "base", bg = "love" },
          TelescopePreviewTitle = { fg = "base", bg = "foam" },
          TelescopePromptNormal = { bg = "overlay" },
          TelescopePromptBorder = { fg = "rose", bg = "overlay" },
          TelescopePromptPrefix = { fg = "love", bg = "overlay" },
          NvimTreeCursorLine = { bg = "surface" },
          NvimTreeNormal = { bg = "#161420" },
          NvimTreeWinSeparator = { bg = "#161420", fg = "#161420" },
          CmpWinBorder = { fg = "overlay", bg = "base" },
        },
      })
    end,
  },
  -- {
  --   "asilvam133/rose-pine.nvim",
  --   name = "rosepine",
  --   lazy = true,
  --   keys = {
  --     { "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
  --   },
  --   priority = 1000,
  --   config = function()
  --     return {
  --       require("rose-pine").setup({
  --         variant = "main",
  --         dark_variant = "moon",
  --         dim_inactive_windows = true,
  --         extend_background_behind_borders = true,
  --         styles = { italic = true, transparency = false },
  --         groups = {
  --           border = "pine", --"pine",
  --         },
  --       }),
  --     }
  --   end,
  -- },
}
