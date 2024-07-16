return {
  { "xiyaowong/transparent.nvim", cmd = { "TransparentToggle", "TransparentEnable", "TransparentDisable" } },
  -- {
  --   "oxfist/night-owl.nvim",
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     require("night-owl").setup()
  --     vim.cmd.colorscheme("night-owl")
  --     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --       border = "rounded",
  --     })
  --   end,
  -- },
  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "html", "htmldjango" },
    opts = { document_coolor = { enabled = false } },
    config = function(opts)
      require("tailwind-tools").setup({ opts })
    end,
  },
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   enabled = true,
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --       border = "rounded",
  --     })
  --   end,
  -- },
  -- {
  --   "eldritch-theme/eldritch.nvim",
  --   enabled = true,
  --   priority = 1000,
  --   opts = {
  --     dim_inactive = true,
  --     hide_inactive_statusline = true,
  --     lualine_bold = true,
  --   },
  --   config = function()
  --     require("eldritch").setup({
  --       dim_inactive = true,
  --       transparent = false,
  --       hide_inactive_statusline = true,
  --       lualine_bold = true,
  --     })
  --     vim.o.termguicolors = true
  --   end,
  -- },
  -- {
  --   "mofiqul/dracula.nvim",
  --   enabled = true,
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --       border = "rounded",
  --     })
  --   end,
  -- },
  -- {
  --   "maxmx03/dracula.nvim",
  --   enabled = true,
  --   priority = 1000,
  --   opts = {},
  --   config = function()
  --     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --       border = "rounded",
  --     })
  --   end,
  -- },
  {
    "binhtran432k/dracula.nvim", -- There are a lot of dracula esque nvim themes but I like this one the most so far.
    enabled = true,
    priority = 1000,
    opts = {},
    config = function() end,
  },
  {
    "sainnhe/everforest",
    name = "everforest",
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_dim_inactive_windows = 1
      vim.g.everforest_ui_contrast = "high"
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_better_performance = 1
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   enabled = true,
  --   priority = 1000,
  --   opts = {
  --     colors = {
  --       theme = {
  --         all = {
  --           ui = {
  --             bg_gutter = "none",
  --           },
  --         },
  --       },
  --     },
  --     -- transparent = false,
  --     theme = "wave",
  --   },
  -- },
  {
    "ribru17/bamboo.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("bamboo").setup({
        -- optional configuration here
        style = "multiplex",
        lualine = { transparent = false },
      })
      require("bamboo").load()
    end,
  },
  {
    "uloco/bluloco.nvim",
    lazy = true,
    enabled = true,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      require("bluloco").setup({
        style = "dark",
        italics = true,
        transparent = false,
        termainl = vim.fn.has("gui_running") == 1,
        guicursor = true,
      })
      vim.opt.termguicolors = true
    end,
  },
  {
    "rockyzhang24/arctic.nvim",
    enabled = true,
    branch = "v2",
    priority = 1000,
    name = "arctic",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   enabled = true,
  --   priority = 1000,
  --   opts = {},
  -- },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    enabled = true,
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
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
      dim_inactive = true,
      transparent_mode = false,
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = true,
    opts = {
      sidebars = "dark",
      style = "night",
      floats = "dark",
      dim_inactive = true,
      hide_inactive_statusline = true,
      lualine_bold = true,
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
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "sainnhe/gruvbox-material",
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "soft"
      vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_enable_bold = 1
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
    opts = {},
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = true,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main",
        dark_variant = "main",
        dim_inactive_windows = true,
        extend_background_behind_borders = false,
        styles = { bold = true, italic = true, transparency = false },
        groups = {
          border = "pine",
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
      -- vim.cmd("colorscheme rose-pine")
      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      --   border = "rounded",
      -- })
    end,
  },
  -- {
  --   "asilvam133/rose-pine.nvim",
  --   name = "rose-pine",
  --   enabled = false,
  --   priority = 1000,
  --   config = function()
  --     require("rose-pine").setup({
  --       variant = "main",
  --       dark_variant = "main",
  --       dim_inactive_windows = true,
  --       extend_background_behind_borders = true,
  --       styles = { bold = true, italic = true, transparency = false },
  --       -- groups = {
  --       --   border = "pine", --"pine",
  --       -- },
  --       -- highlight_groups = {
  --       --   TelescopeResultsTitle = { fg = "rose", bg = "surface" },
  --       --   TelescopeBorder = { fg = "rose", bg = "surface" },
  --       --   TelescopeSelection = { fg = "text", bg = "overlay", bold = true },
  --       --   TelescopeSelectionCaret = { fg = "text", bg = "highlight_med" },
  --       --   TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
  --       --   TelescopeTitle = { fg = "base", bg = "love" },
  --       --   TelescopePromptTitle = { fg = "base", bg = "love" },
  --       --   TelescopePreviewTitle = { fg = "base", bg = "foam" },
  --       --   TelescopePromptNormal = { bg = "overlay" },
  --       --   TelescopePromptBorder = { fg = "rose", bg = "overlay" },
  --       --   TelescopePromptPrefix = { fg = "love", bg = "overlay" },
  --       --   NvimTreeCursorLine = { bg = "surface" },
  --       --   NvimTreeNormal = { bg = "#161420" },
  --       --   NvimTreeWinSeparator = { bg = "#161420", fg = "#161420" },
  --       --   CmpWinBorder = { fg = "overlay", bg = "base" },
  --       -- },
  --     })
  --     vim.cmd("colorscheme rose-pine")
  --     vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --       border = "rounded",
  --     })
  --   end,
  -- },
  -- {
  --   "akthe-at/rose-pine.nvim",
  --   priority = 1000,
  --   config = function()
  --     return {
  --       require("rose-pine").setup({
  --         variant = "main",
  --         dark_variant = "moon",
  --         dim_inactive_windows = true,
  --         extend_background_behind_borders = true,
  --         styles = { italic = true, transparency = false },
  --         -- groups = {
  --         --   border = "pine", --"pine",
  --         -- },
  --       }),
  --     }
  --   end,
  -- },
}
