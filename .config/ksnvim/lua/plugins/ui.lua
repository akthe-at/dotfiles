return {

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
      -- stylua: ignore
      close_command = function(n) Snacks.bufdelete(n) end,
      -- stylua: ignore
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
          {
            filetype = 'snacks_layout_box',
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
  {
    'echasnovski/mini.icons',
    opts = {
      file = {
        ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
      filetype = {
        gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
      },
    },
  },
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'UIEnter',
    opts = {
      ---Render style
      ---@usage 'background'|'foreground'|'virtual'
      render = 'background',
      ---Set virtual symbol (requires render to be set to 'virtual')
      virtual_symbol = '■',
      ---Highlight tailwind colors, e.g. 'bg-blue-500'
      enable_tailwind = false,
    },
    config = function(opts)
      require('nvim-highlight-colors').setup { opts }
    end,
  },
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   event = 'VeryLazy',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   init = function()
  --     vim.g.lualine_laststatus = vim.o.laststatus
  --
  --     if vim.fn.argc(-1) > 0 then
  --       -- set an empty statusline till lualine loads
  --       vim.o.statusline = ' '
  --     else
  --       -- hide the statusline on the starter page
  --       vim.o.laststatus = 0
  --     end
  --   end,
  --   opts = function()
  --     local lualine_require = require 'lualine_require'
  --     lualine_require.require = require
  --
  --     local icons = require('icons').icons
  --
  --     vim.o.laststatus = vim.g.lualine_laststatus
  --
  --     local opts = {
  --       options = {
  --         theme = 'auto',
  --         globalstatus = vim.o.laststatus == 3,
  --         disabled_filetypes = { statusline = { 'alpha', 'dashboard', 'ministarter', 'snacks_dashboard' } },
  --       },
  --       sections = {
  --         lualine_a = {
  --           { 'mode', separator = { left = '', right = '' }, right_padding = 2 },
  --         },
  --         lualine_b = { 'branch' },
  --         lualine_c = {
  --           Snacks.git.get_root(),
  --           {
  --             'diagnostics',
  --             symbols = {
  --               error = icons.diagnostics.Error,
  --               warn = icons.diagnostics.Warn,
  --               info = icons.diagnostics.Info,
  --               hint = icons.diagnostics.Hint,
  --             },
  --           },
  --           {
  --             'filetype',
  --             icon_only = true,
  --             separator = '',
  --             padding = { left = 1, right = 0 },
  --           },
  --           {
  --             function()
  --               return vim.fn.fnamemodify(vim.fn.expand '%:p', ':~')
  --             end,
  --             cond = function()
  --               return vim.bo.filetype ~= 'alpha' and vim.bo.filetype ~= 'dashboard'
  --             end,
  --             padding = { left = 0, right = 1 },
  --           },
  --         },
  --         lualine_x = {
  --           Snacks.profiler.status(),
  --           {
  --             function()
  --               return '  ' .. require('dap').status()
  --             end,
  --             cond = function()
  --               return package.loaded['dap'] and require('dap').status() ~= ''
  --             end,
  --             color = function()
  --               return { fg = Snacks.util.color 'Debug' }
  --             end,
  --           },
  --           {
  --             require('lazy.status').updates,
  --             cond = require('lazy.status').has_updates,
  --             color = function()
  --               return { fg = Snacks.util.color 'Special' }
  --             end,
  --           },
  --           {
  --             'diff',
  --             symbols = {
  --               added = icons.git.added,
  --               modified = icons.git.modified,
  --               removed = icons.git.removed,
  --             },
  --             source = function()
  --               local gitsigns = vim.b.gitsigns_status_dict
  --               if gitsigns then
  --                 return {
  --                   added = gitsigns.added,
  --                   modified = gitsigns.changed,
  --                   removed = gitsigns.removed,
  --                 }
  --               end
  --             end,
  --           },
  --         },
  --         lualine_y = {
  --           { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
  --           { 'location', padding = { left = 0, right = 1 } },
  --         },
  --         lualine_z = {
  --           function()
  --             return ' ' .. os.date '%R'
  --           end,
  --         },
  --       },
  --       extensions = { 'lazy' },
  --     }
  --
  --     if vim.g.trouble_lualine then
  --       local trouble = require 'trouble'
  --       local symbols = trouble.statusline {
  --         mode = 'symbols',
  --         groups = {},
  --         title = false,
  --         filter = { range = true },
  --         format = '{kind_icon}{symbol.name:Normal}',
  --         hl_group = 'lualine_c_normal',
  --       }
  --       table.insert(opts.sections.lualine_c, {
  --         symbols and symbols.get,
  --         cond = function()
  --           return vim.b.trouble_lualine ~= false and symbols.has()
  --         end,
  --       })
  --     end
  --     return opts
  --   end,
  -- },
  --
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   event = 'VeryLazy',
  --   init = function()
  --     vim.g.lualine_laststatus = vim.o.laststatus
  --     if vim.fn.argc(-1) > 0 then
  --       -- set an empty statusline till lualine loads
  --       vim.o.statusline = ' '
  --     else
  --       -- hide the statusline on the starter page
  --       vim.o.laststatus = 0
  --     end
  --   end,
  --   opts = function()
  --     -- PERF: we don't need this lualine require madness 🤷
  --     local lualine_require = require 'lualine_require'
  --     lualine_require.require = require
  --
  --     vim.o.laststatus = vim.g.lualine_laststatus
  --
  --     local opts = {
  --       options = {
  --         theme = 'auto',
  --         globalstatus = vim.o.laststatus == 3,
  --         disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
  --       },
  --       sections = {
  --         lualine_a = { 'mode' },
  --         lualine_b = { 'branch' },
  --
  --         lualine_c = {
  --           {
  --             'diagnostics',
  --           },
  --           { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
  --         },
  --         lualine_x = {
  --           Snacks.profiler.status(),
  --         -- stylua: ignore
  --         {
  --           function() return require("noice").api.status.command.get() end,
  --           cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
  --           color = function() return { fg = Snacks.util.color("Statement") } end,
  --         },
  --         -- stylua: ignore
  --         {
  --           function() return require("noice").api.status.mode.get() end,
  --           cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
  --           color = function() return { fg = Snacks.util.color("Constant") } end,
  --         },
  --         -- stylua: ignore
  --         {
  --           function() return "  " .. require("dap").status() end,
  --           cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
  --           color = function() return { fg = Snacks.util.color("Debug") } end,
  --         },
  --         -- stylua: ignore
  --         {
  --           require("lazy.status").updates,
  --           cond = require("lazy.status").has_updates,
  --           color = function() return { fg = Snacks.util.color("Special") } end,
  --         },
  --           {
  --             'diff',
  --             symbols = {},
  --             source = function()
  --               local gitsigns = vim.b.gitsigns_status_dict
  --               if gitsigns then
  --                 return {
  --                   added = gitsigns.added,
  --                   modified = gitsigns.changed,
  --                   removed = gitsigns.removed,
  --                 }
  --               end
  --             end,
  --           },
  --         },
  --         lualine_y = {
  --           { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
  --           { 'location', padding = { left = 0, right = 1 } },
  --         },
  --         lualine_z = {
  --           function()
  --             return ' ' .. os.date '%R'
  --           end,
  --         },
  --       },
  --       extensions = { 'neo-tree', 'lazy', 'fzf' },
  --     }
  --
  --     -- do not add trouble symbols if aerial is enabled
  --     -- And allow it to be overriden for some buffer types (see autocmds)
  --     local trouble = require 'trouble'
  --     local symbols = trouble.statusline {
  --       mode = 'symbols',
  --       groups = {},
  --       title = false,
  --       filter = { range = true },
  --       format = '{kind_icon}{symbol.name:Normal}',
  --       hl_group = 'lualine_c_normal',
  --     }
  --     table.insert(opts.sections.lualine_c, {
  --       symbols and symbols.get,
  --       cond = function()
  --         return vim.b.trouble_lualine ~= false and symbols.has()
  --       end,
  --     })
  --
  --     return opts
  --   end,
  -- },
}
