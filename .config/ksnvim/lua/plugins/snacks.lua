local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and '<c-' .. dir .. '>' or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies = {
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    -- [[ Configure Snacks Pickers ]]
    -- See `:help snacks-picker` and `:help snacks-picker-setup`
    ---@type snacks.Config
    opts = {
      dashboard = {
        -- preset = {
        --   header = "",
        -- },
        sections = {
          { section = 'header', padding = 1 },
          { section = 'keys', title = 'Keymaps', padding = 1, indent = 3 },
          { section = 'recent_files', title = 'Recent Files', indent = 3, padding = 1 },
          { section = 'startup' },
          {
            pane = 2,
            {
              { section = 'terminal', cmd = "echo ' '", padding = 0 },
              { section = 'projects', icon = ' ', title = 'Projects', indent = 3, padding = 1 },
              {
                section = 'terminal',
                icon = ' ',
                title = 'Git Status',
                enabled = vim.fn.isdirectory '.git' == 1,
                cmd = 'hub diff --stat -B -M -C',
                height = 10,
                padding = 1,
                indent = 3,
              },
            },
          },
        },
      },
      quickfile = { enabled = true },
      terminal = {
        win = {
          keys = {
            nav_h = { '<C-h>', term_nav 'h', desc = 'Go to Left Window', expr = true, mode = 't' },
            nav_j = { '<C-j>', term_nav 'j', desc = 'Go to Lower Window', expr = true, mode = 't' },
            nav_k = { '<C-k>', term_nav 'k', desc = 'Go to Upper Window', expr = true, mode = 't' },
            nav_l = { '<C-l>', term_nav 'l', desc = 'Go to Right Window', expr = true, mode = 't' },
          },
        },
      },
      bigfile = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      git = { enabled = true },
      words = { enabled = true },
      animate = {
        enabled = true,
        ---@type snacks.animate.Duration|number
        duration = 20, -- ms per step
        easing = 'linear',
        fps = 60, -- frames per second. Global setting for all animations
      },
      lazygit = {
        ---@class snacks.lazygit.Config: snacks.terminal.Opts
        ---@field args? string[]
        ---@field theme? snacks.lazygit.Theme
        {
          -- automatically configure lazygit to use the current colorscheme
          -- and integrate edit with the current neovim instance
          configure = true,
          -- extra configuration for lazygit that will be merged with the default
          -- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
          -- you need to double quote it: `"\"test\""`
          config = {
            os = { editPreset = 'nvim-remote' },
            gui = {
              -- set to an empty string "" to disable icons
              nerdFontsVersion = '3',
            },
          },
          theme_path = vim.fs.normalize(vim.fn.stdpath 'cache' .. '/lazygit-theme.yml'),
          -- Theme for lazygit
          theme = {
            [241] = { fg = 'Special' },
            activeBorderColor = { fg = 'MatchParen', bold = true },
            cherryPickedCommitBgColor = { fg = 'Identifier' },
            cherryPickedCommitFgColor = { fg = 'Function' },
            defaultFgColor = { fg = 'Normal' },
            inactiveBorderColor = { fg = 'FloatBorder' },
            optionsTextColor = { fg = 'Function' },
            searchingActiveBorderColor = { fg = 'MatchParen', bold = true },
            selectedLineBgColor = { bg = 'Visual' }, -- set to `default` to have no background colour
            unstagedChangesColor = { fg = 'DiagnosticError' },
          },
          win = {
            style = 'lazygit',
          },
        },
      },
      picker = {
        layout = { preset = 'telescope' },
      },
    },
    keys = {
      {
        '<leader>.',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<leader>S',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Buffer',
      },
      {
        '<leader>dps',
        function()
          Snacks.profiler.scratch()
        end,
        desc = 'Profiler Scratch Buffer',
      },
      {
        '<a-n>',
        function()
          Snacks.words.jump(vim.v.count1, true)
        end,
        desc = 'Next Reference',
      },
      {
        '<a-p>',
        function()
          Snacks.words.jump(-vim.v.count1, true)
        end,
        desc = 'Prev Reference',
      },
      {
        '<leader>un',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Dismiss All Notifications',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<c-_>',
        function()
          Snacks.terminal()
        end,
        desc = 'which_key_ignore',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
      -- todo comments
      {
        '<leader>st',
        function()
          Snacks.picker.todo_comments()
        end,
        desc = 'Todo',
      },
      {
        '<leader>sT',
        function()
          Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
        end,
        desc = 'Todo/Fix/Fixme',
      },

      -- Git Commands
      {
        '<leader>gb',
        function()
          Snacks.picker.git_branches()
        end,
        desc = 'Git Branches',
      },
      {
        '<leader>gl',
        function()
          Snacks.picker.git_log()
        end,
        desc = 'Git Log',
      },
      {
        '<leader>gL',
        function()
          Snacks.picker.git_log_line()
        end,
        desc = 'Git Log Line',
      },
      {
        '<leader>gs',
        function()
          Snacks.picker.git_status()
        end,
        desc = 'Git Status',
      },
      {
        '<leader>gS',
        function()
          Snacks.picker.git_stash()
        end,
        desc = 'Git Stash',
      },
      {
        '<leader>gd',
        function()
          Snacks.picker.git_diff()
        end,
        desc = 'Git Diff (Hunks)',
      },
      {
        '<leader>gf',
        function()
          Snacks.picker.git_log_file()
        end,
        desc = 'Git Log File',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit(Snacks.git.get_root())
        end,
        { desc = 'Lazygit (Root Dir)' },
      },
      {
        '<leader>gG',
        function()
          Snacks.lazygit()
        end,
        { desc = 'Lazygit (cwd)' },
      },
      {
        '<leader>fp',
        function()
          Snacks.picker.projects()
        end,
        desc = '[F]ind [P]rojects',
      },
      {
        '<leader>fe',
        function()
          Snacks.explorer()
        end,
        desc = '[F]ile [E]xplorer',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = '[S]earch [H]elp',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
        mode = { 'n', 'v' },
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = '[S]earch [K]eymaps',
      },
      {
        '<leader>ff',
        function()
          Snacks.picker.smart()
        end,
        desc = '[F]ind [F]iles',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undo History',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.pickers()
        end,
        desc = '[S]earch [S]elect Snacks',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = '[S]earch current [W]ord',
        mode = { 'n', 'x' },
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = '[S]earch by [G]rep',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = '[S]earch [D]iagnostics',
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.resume()
        end,
        desc = '[S]earch [R]esume',
      },
      {
        '<leader>fr',
        function()
          Snacks.picker.recent()
        end,
        desc = '[F]ind Recent Files ("." for repeat)',
      },
      {
        '<leader>fb',
        function()
          Snacks.picker.buffers()
        end,
        desc = '[ ] Find existing buffers',
      },
      {
        '<leader><space>',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Smart Find Files',
      },
      {
        '<leader>sb',
        function()
          Snacks.picker.lines {}
        end,
        desc = '[/] Fuzzily search in current buffer',
      },
      {
        '<leader>s/',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = '[S]earch [/] in Open Files',
      },
      -- Shortcut for searching your Neovim configuration files
      {
        '<leader>fc',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = '[F]ind Neovim [C]onfig files',
      },
      {
        '<leader>uC',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = 'Colorschemes',
      },
      {
        '<leader>N',
        desc = 'Neovim News',
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = 'yes',
              statuscolumn = ' ',
              conceallevel = 3,
            },
          }
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
          Snacks.toggle.inlay_hints():map '<leader>uh'
          Snacks.toggle.indent():map '<leader>ug'
          Snacks.toggle.dim():map '<leader>uD'
          -- Windows
          Snacks.toggle.zoom():map('<leader>wm'):map '<leader>uZ'
          Snacks.toggle.zen():map '<leader>uz'
        end,
      })
    end,
  },
}
