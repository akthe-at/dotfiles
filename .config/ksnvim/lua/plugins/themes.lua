return {
  { 'bluz71/vim-moonfly-colors', name = 'moonfly', lazy = true, priority = 1000 },
  {
    'fynnfluegge/monet.nvim',
    lazy = true,
    name = 'monet',
    priority = 1000,
    opts = {
      styles = {
        strings = { 'italic' },
      },
    },
  },
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    --- @module 'catppuccin'
    --- @type CatppuccinOptions
    opts = {
      integrations = {
        blink_cmp = true,
        snacks = true,
        which_key = true,
        mini = true,
      },
    },
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'catppuccin-mocha', 'catppuccin-latte', or 'catppuccin-frappe'.
      --vim.cmd.colorscheme 'catppuccin'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'yorumicolors/yorumi.nvim',
    lazy = true,
    priority = 1000, -- Ensure it loads first
    opts = {},
  },
  {
    'vague2k/vague.nvim',
    lazy = true,
    priority = 9999,
    config = function()
      require('vague').setup { transparent = false }
      --vim.cmd.colorscheme 'vague'
    end,
  },
  {
    'sam4llis/nvim-tundra',
    lazy = true,
    priority = 1000, -- Ensure it loads first
    config = function()
      require('nvim-tundra').setup {
        transparent_background = false,
        dim_inactive_windows = {
          enabled = false,
          color = nil,
        },
        sidebars = {
          enabled = true,
          color = nil,
        },
        editor = {
          search = {},
          substitute = {},
        },
        syntax = {
          booleans = { bold = true, italic = true },
          comments = { bold = true, italic = true },
          conditionals = {},
          constants = { bold = true },
          fields = {},
          functions = {},
          keywords = {},
          loops = {},
          numbers = { bold = true },
          operators = { bold = true },
          punctuation = {},
          strings = {},
          types = { italic = true },
        },
        diagnostics = {
          errors = {},
          warnings = {},
          information = {},
          hints = {},
        },
        plugins = {
          lsp = true,
          semantic_tokens = true,
          treesitter = true,
          telescope = true,
          nvimtree = true,
          cmp = true,
          context = true,
          dbui = true,
          gitsigns = true,
          neogit = true,
          textfsm = true,
        },
        overwrite = {
          colors = {},
          highlights = {},
        },
      }

      vim.g.tundra_biome = 'arctic' -- 'arctic' or 'jungle'
      vim.opt.background = 'dark'
      -- vim.cmd("colorscheme tundra")
    end,
  },
  {
    'olimorris/onedarkpro.nvim',
    lazy = true,
    priority = 1000, -- Ensure it loads first
    opts = {
      highlights = {
        Comment = { italic = true },
        Directory = { bold = true },
        ErrorMsg = { italic = true, bold = true },
      },
      styles = {
        types = 'NONE',
        methods = 'NONE',
        numbers = 'NONE',
        strings = 'NONE',
        comments = 'italic',
        keywords = 'bold,italic',
        constants = 'NONE',
        functions = 'italic',
        operators = 'NONE',
        variables = 'NONE',
        parameters = 'NONE',
        conditionals = 'italic',
        virtual_text = 'NONE',
      },
    },
    config = function(_, o)
      require('onedarkpro').setup(o)
    end,
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      --'neovim/nvim-lspconfig',
    },
    ft = { 'html', 'htmldjango', 'templ' },
    opts = { document_color = { enabled = false } },
  },
  {
    'binhtran432k/dracula.nvim',
    lazy = true,
    enabled = true,
    priority = 1000,
  },
  {
    'fcancelinha/nordern.nvim',
    lazy = true,
    branch = 'master',
    priority = 1000,
    opts = {
      brighter_comments = true,
      brighter_conditionals = true,
      italic_comments = true,
    },
  },
  {
    'sainnhe/everforest',
    lazy = true,
    name = 'everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'hard'
      vim.g.everforest_dim_inactive_windows = 1
      vim.g.everforest_diagnostic_virtual_text = 'colored'
      vim.g.everforest_ui_contrast = 'high'
      vim.g.everforest_enable_italic = 1
      -- vim.g.everforest_better_performance = 1

      --vim.cmd 'colorscheme everforest'
    end,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
        style = 'multiplex',
        lualine = { transparent = false },
      }
      require('bamboo').load()
    end,
  },
  {
    'uloco/bluloco.nvim',
    lazy = true,
    enabled = true,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      require('bluloco').setup {
        style = 'dark',
        italics = true,
        transparent = false,
        termainl = vim.fn.has 'gui_running' == 1,
        guicursor = true,
      }
      vim.opt.termguicolors = true
    end,
  },
  {
    'Mofiqul/vscode.nvim',
    enabled = true,
    priority = 1000,
    opts = {},
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    priority = 1000,
    enabled = true,
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
      inverse = false, -- invert background for search, diffs, statuslines and errors
      contrast = 'hard', -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = true,
      transparent_mode = false,
    },
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   enabled = true,
  --   opts = {
  --     sidebars = "dark",
  --     style = "night",
  --     floats = "dark",
  --     dim_inactive = true,
  --     hide_inactive_statusline = true,
  --     lualine_bold = true,
  --   },
  --   config = function()
  --     require("tokyonight").setup({
  --       style = "night",
  --       dim_inactive = true,
  --       transparent = false,
  --       hide_inactive_statusline = true,
  --       lualine_bold = true,
  --     })
  --     vim.o.termguicolors = true
  --   end,
  -- },
  {
    'sainnhe/gruvbox-material',
    lazy = true,
    enabled = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
      vim.g.gruvbox_material_diagnostic_text_highlight = 0
      vim.g.gruvbox_material_diagnostic_line_highlight = 0
      vim.g.gruvbox_material_inlay_hints_background = 'none'
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_ui_contrast = 'high'
      vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_enable_bold = 1
    end,
    opts = {},
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    enabled = true,
    priority = 9999,
    config = function()
      require('rose-pine').setup {
        variant = 'auto',
        dark_variant = 'main',
        dim_inactive_windows = true,
        extend_background_behind_borders = false,
        enable = {
          terminal = true,
          legacy_highlights = false,
          migrations = true,
        },
        styles = { bold = true, italic = true, transparency = false },
        groups = {
          border = 'love',
        },
        highlight_groups = {
          FzfLuaNormal = { bg = 'none' },
          FzfLuaBorder = { fg = 'love', bg = 'none' },
          FzfLuaBackdrop = { bg = 'base' },
          FzfLuaTitle = { bg = 'base' },
          FzfLuaPreviewTitle = { bg = 'base' },
          TelescopeResultsNormal = { bg = 'none' },
          TelescopeBorder = { fg = 'love', bg = 'none' },
          TelescopeNormal = { bg = 'none' },
          TelescopeSelection = { fg = 'text', bg = 'base', bold = true },
          TelescopeSelectionCaret = { fg = 'rose', bg = 'rose' },
          TelescopePromptNormal = { bg = 'base' },
          SnacksPickerPrompt = { bg = 'base' },
          SnacksPickerBorder = { fg = 'love', bg = 'none' },
          SnacksPickerTitle = { bg = 'base' },
          NvimTreeCursorLine = { bg = 'surface' },
          NvimTreeNormal = { bg = '#161420' },
          NvimTreeWinSeparator = { bg = '#161420', fg = '#161420' },
          CmpWinBorder = { fg = 'overlay', bg = 'none' },
        },
        -- palette = {
        --   moon = {
        --     gold = "#f6d5a7",
        --     foam = "#a1d1da",
        --     iris = "#d9c7ef",
        --     rose = "#ebbcba",
        --     pine = "#437e91",
        --     no_bg = "#000000",
        --   },
        -- },
      }
      -- vim.cmd 'colorscheme rose-pine-moon'
      --vim.cmd 'colorscheme rose-pine'
    end,
  },
  {
    'oxfist/night-owl.nvim',
    lazy = true,
    priority = 1000,
    opts = {},
    config = function()
      require('night-owl').setup()
      -- vim.cmd.colorscheme("night-owl")
    end,
  },
  {
    '0xstepit/flow.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      theme = {
        style = 'dark', --  "dark" | "light"
        contrast = 'default', -- "default" | "high"
        transparent = false, -- true | false
      },
      colors = {
        mode = 'default', -- "default" | "dark" | "light"
        fluo = 'pink', -- "pink" | "cyan" | "yellow" | "orange" | "green"
      },
      ui = {
        borders = 'inverse', -- "theme" | "inverse" | "fluo" | "none"
        aggressive_spell = false, -- true | false
      },
    },
    config = function(_, opts)
      require('flow').setup {
        require('flow').setup(opts),
      }
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    enabled = true,
    lazy = true,
    priority = 1000,
    opts = {
      italic_comments = true,
      borderless_pickers = false,
      cache = true,
      saturation = 0.8,
      variant = 'auto',
    },
    config = function(_, opts)
      require('cyberdream').setup(opts)
      --vim.cmd.colorscheme 'cyberdream'
    end,
  },
  {
    'eldritch-theme/eldritch.nvim',
    lazy = true,
    enabled = true,
    priority = 1000,
    opts = {
      dim_inactive = true,
      hide_inactive_statusline = true,
      lualine_bold = true,
    },
    config = function()
      require('eldritch').setup {
        dim_inactive = true,
        transparent = false,
        hide_inactive_statusline = true,
        lualine_bold = true,
        palette = 'darker',
      }
    end,
  },
  -- {
  --   'Koalhack/darcubox-nvim',
  --   config = function()
  --     vim.cmd 'colorscheme darcubox'
  --   end,
  -- },
  -- {
  --   'deep_ocean_clarity_enhanced', -- The name of your plugin (can be anything, but usually matches the folder name)
  --   dev = true,                    -- Mark this as a development plugin
  --   dir = '~/projects/deep_clarity', -- The local path to your colorscheme's root directory
  --   lazy = false,                  -- Load this plugin immediately (colorschemes usually need to be loaded early)
  --   priority = 1000,               -- Give it a high priority to ensure it loads before other plugins that might set highlights
  --   opts = {},
  --   -- config = function()
  --   --   -- Call the setup function of your colorscheme here
  --   --   require('deep_ocean_clarity_enhanced').setup()
  --   --
  --   --     --vim.cmd 'colorscheme midnight_contrast'
  --   -- end,
  -- },
  -- {
  --   "mofiqul/dracula.nvim",
  --   enabled = true,
  --   priority = 1000,
  -- },
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
    'hardhackerlabs/theme-vim',
    lazy = true,
    name = 'hardhacker',
    priority = 1000,
    config = function()
      vim.g.hardhacker_hide_tilde = 1
      vim.g.hardhacker_keyword_italic = 1
      -- custom highlights
      vim.g.hardhacker_custom_highlights = {}
    end,
  },
  {
    'rebelot/kanagawa.nvim',
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
              bg_gutter = 'none',
            },
          },
        },
      },
      -- transparent = false,
      theme = 'wave',
      background = {
        dark = 'wave',
        light = 'lotus',
      },
    },
  },
  {
    'craftzdog/solarized-osaka.nvim',
    enabled = true,
    lazy = true,
    priority = 1000,
    config = function()
      require('solarized-osaka').setup {
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = 'dark', -- style for sidebars, see below
          floats = 'dark', -- style for floating windows
        },
        sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,
        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      }
    end,
  },
}
