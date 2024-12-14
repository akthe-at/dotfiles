return {

  {
    "LazyVim/LazyVim",
    version = false,
    opts = {
      -- colorscheme = "onenord",
      -- colorscheme = "monet",
      -- colorscheme = "rose-pine",
      colorscheme = "rose-pine-moon",
      -- colorscheme = "rose-pine-dawn",
      -- colorscheme = "tokyonight",
      -- colorscheme = "tokyonight-day",
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "dracula",
      -- colorscheme = "miss-dracula",
      -- colorscheme = "nordern",
      -- colorscheme = "arctic",
      -- colorscheme = "lavish-dark",
      -- colorscheme = "onedark_vivid",
      -- colorscheme = "bluloco",
      -- colorscheme = "vscode",
      -- colorscheme = "bamboo",
      -- colorscheme = "everforest",
      -- colorscheme = "evergarden",
      -- colorscheme = "cyberdream",
      -- colorscheme = "flow",
      -- colorscheme = "night-owl",
      -- colorscheme = "eldritch",
      -- colorscheme = "catppuccin",
      -- colorscheme = "kanagawa",
      -- colorscheme = "solarized-osaka",
      -- colorscheme = "hardhacker",
      -- colorscheme = "gruvbox",
      -- colorscheme = "gruvbox-baby",
      -- colorscheme = "gruvbox-material",
      -- colorscheme = "yorumi",
    },
  },
  -- { "nvim-lua/plenary.nvim" },
  -- {
  --   "nvchad/ui",
  --   config = function()
  --     require("nvchad")
  --   end,
  -- },
  -- {
  --   "nvchad/base46",
  --   lazy = true,
  --   build = function()
  --     require("base46").load_all_highlights()
  --   end,
  -- },
  {
    "fynnfluegge/monet.nvim",
    name = "monet",
    priority = 1000,
    opts = {
      styles = {
        strings = { "italic" },
      },
    },
  },
  {
    "comfysage/evergarden",
    priority = 1000,
    opts = {
      contrast_dark = "hard",
      style = {
        comment = { italic = true },
      },
    },
  },
  {
    "yorumicolors/yorumi.nvim",
    lazy = true,
    priority = 1000, -- Ensure it loads first
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000, -- Ensure it loads first
    opts = {
      highlights = {
        Comment = { italic = true },
        Directory = { bold = true },
        ErrorMsg = { italic = true, bold = true },
      },
      styles = {
        types = "NONE",
        methods = "NONE",
        numbers = "NONE",
        strings = "NONE",
        comments = "italic",
        keywords = "bold,italic",
        constants = "NONE",
        functions = "italic",
        operators = "NONE",
        variables = "NONE",
        parameters = "NONE",
        conditionals = "italic",
        virtual_text = "NONE",
      },
    },
    config = function(_, o)
      require("onedarkpro").setup(o)
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = { "html", "htmldjango" },
    opts = { document_color = { enabled = false } },
  },
  {
    "luisiacc/gruvbox-baby",
    lazy = true,
    enabled = true,
    priority = 1000,
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "ferdinandrau/lavish.nvim",
    lazy = true,
    enabled = true,
    priority = 1000,
    opts = {},
    config = function()
      require("lavish").apply("dark")
      require("lavish").setup({
        style = { italic_comments = true, italic_strings = true },
      })
    end,
  },
  -- {
  --   "binhtran432k/dracula.nvim", -- There are a lot of dracula esque nvim themes but I like this one the most so far.
  --   name = "bin-dracula",
  --   lazy = true,
  --   enabled = true,
  --   priority = 1000,
  --   opts = {},
  -- },
  {
    "rmehri01/onenord.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "fcancelinha/nordern.nvim",
    lazy = true,
    branch = "master",
    priority = 1000,
    opts = {
      brighter_comments = true,
      brighter_conditionals = true,
      italic_comments = true,
    },
  },
  {
    "sainnhe/everforest",
    lazy = true,
    name = "everforest",
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_dim_inactive_windows = 1
      vim.g.everforest_diagnostic_virtual_text = "colored"
      vim.g.everforest_ui_contrast = "high"
      vim.g.everforest_enable_italic = 1
      -- vim.g.everforest_better_performance = 1
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
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
    "Mofiqul/vscode.nvim",
    enabled = true,
    priority = 1000,
    opts = {},
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
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
      contrast = "hard", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = true,
      transparent_mode = false,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
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
    lazy = true,
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_diagnostic_text_highlight = 0
      vim.g.gruvbox_material_diagnostic_line_highlight = 0
      vim.g.gruvbox_material_inlay_hints_background = "none"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high"
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
          border = "love",
        },
        highlight_groups = {
          FzfLuaNormal = { bg = "none" },
          FzfLuaBorder = { fg = "love", bg = "none" },
          FzfLuaBackdrop = { bg = "base" },
          FzfLuaTitle = { bg = "base" },
          FzfLuaPreviewTitle = { bg = "base" },
          TelescopeResultsNormal = { bg = "none" },
          TelescopeBorder = { fg = "love", bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopeSelection = { fg = "text", bg = "base", bold = true },
          TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
          TelescopePromptNormal = { bg = "base" },
          NvimTreeCursorLine = { bg = "surface" },
          NvimTreeNormal = { bg = "#161420" },
          NvimTreeWinSeparator = { bg = "#161420", fg = "#161420" },
          CmpWinBorder = { fg = "overlay", bg = "none" },
        },
      })
      -- vim.cmd("colorscheme rose-pine")
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "oxfist/night-owl.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      require("night-owl").setup()
      vim.cmd.colorscheme("night-owl")
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "0xstepit/flow.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      require("flow").setup({
        dark_theme = true,
        high_contrast = true,
        transparent = false, -- Set transparent background.
        fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
        mode = "normal", -- Intensity of the palette: normal, dark, or bright. Notice that dark is ugly!
        aggressive_spell = false, -- Display colors for spell check.
      })

      vim.cmd("colorscheme flow")
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    enabled = true,
    priority = 1000,
    opts = {
      italic_comments = true,
      borderless_telescope = false,
    },
    -- config = function()
    --   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --     border = "rounded",
    --   })
    -- end,
  },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = true,
    enabled = true,
    priority = 1000,
    opts = {
      dim_inactive = true,
      hide_inactive_statusline = true,
      lualine_bold = true,
    },
    config = function()
      require("eldritch").setup({
        dim_inactive = true,
        transparent = false,
        hide_inactive_statusline = true,
        lualine_bold = true,
      })
    end,
  },
  {
    "mofiqul/dracula.nvim",
    name = "mofi-dracula",
    enabled = true,
    priority = 1000,
    opts = {},
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  -- {
  --   "maxmx03/dracula.nvim",
  --   name = "max-dracula",
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
    "hardhackerlabs/theme-vim",
    lazy = true,
    name = "hardhacker",
    priority = 1000,
    config = function()
      vim.g.hardhacker_hide_tilde = 1
      vim.g.hardhacker_keyword_italic = 1
      -- custom highlights
      vim.g.hardhacker_custom_highlights = {}
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    enabled = true,
    priority = 1000,
    opts = {
      compile = true,
      undercurl = true,
      functionStyle = { bold = true, italic = true },
      dimInactive = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      -- transparent = false,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
    },
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    enabled = true,
    priority = 1000,
    config = function()
      require("solarized-osaka").setup({
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,
        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      })
    end,
  },
  -- {
  --   "asilvam133/rose-pine.nvim",
  --   name = "dumb-pine",
  --   enabled = true,
  --   priority = 1000,
  --   config = function()
  --     require("rose-pine").setup({
  --       variant = "moon",
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
}
