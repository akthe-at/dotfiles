local sql_ft = { 'sql', 'mysql', 'plsql', 'sqlite3' }
return {
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    ft = sql_ft,
    dependencies = {
      { 'tpope/vim-dadbod' },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql', 'sqlite3', 'sqlit3' } },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  -- {
  --   "benlubas/molten-nvim",
  --   lazy = false,
  --   -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
  --   ft = { "python", "quarto", "markdown", "ipynb" },
  --   cmd = { "MoltenInit", "MoltenImportOutput", "MoltenExportOutput", "MoltenEvaluateOperator" },
  --   build = ":UpdateRemotePlugins",
  --   init = function()
  --     -- vim.g.molten_show_mimetype_debug = true
  --     vim.g.molten_auto_open_output = false
  --     vim.g.molten_output_show_more = true
  --     vim.g.molten_image_provider = "wezterm"
  --     vim.g.molten_split_direction = "bottom"
  --     vim.g.molten_split_size = 30
  --     vim.g.molten_output_win_border = { "", "━", "", "" }
  --     vim.g.molten_output_win_max_height = 50
  --     vim.g.molten_output_virt_lines = true
  --     vim.g.molten_virt_text_output = true
  --     vim.g.molten_use_border_highlights = true
  --     vim.g.molten_virt_lines_off_by_1 = true
  --     vim.g.molten_wrap_output = false
  --     vim.g.molten_virt_text_max_lines = 25
  --     vim.g.molten_tick_rate = 175
  --     vim.g.molten_auto_image_popup = false
  --
  --     vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
  --   end,
  -- },
  -- {
  --   "jpalardy/vim-slime",
  --   dev = false,
  --   ft = { "quarto" },
  --   init = function()
  --     vim.b["quarto_is_python_chunk"] = false
  --     Quarto_is_in_python_chunk = function()
  --       require("otter.tools.functions").is_otter_language_context("python")
  --     end
  --
  --     vim.cmd([[
  --     let g:slime_dispatch_ipython_pause = 100
  --     function SlimeOverride_EscapeText_quarto(text)
  --     call v:lua.Quarto_is_in_python_chunk()
  --     if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
  --     return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
  --     else
  --     if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
  --     return [a:text, "\n"]
  --     else
  --     return [a:text]
  --     end
  --     end
  --     endfunction
  --     ]])
  --
  --     vim.g.slime_target = "neovim"
  --     vim.g.slime_no_mappings = true
  --     vim.g.slime_python_ipython = 1
  --   end,
  --   config = function()
  --     vim.g.slime_input_pid = false
  --     vim.g.slime_suggest_default = true
  --     vim.g.slime_menu_config = false
  --     vim.g.slime_neovim_ignore_unlisted = true
  --     vim.keymap.set({ "n", "i" }, "<m-cr>", function()
  --       vim.cmd([[ call slime#send_cell() ]])
  --     end, { desc = "send code cell to terminal" })
  --
  --     local function mark_terminal()
  --       local job_id = vim.b.terminal_job_id
  --       vim.print("job_id: " .. job_id)
  --     end
  --
  --     local function set_terminal()
  --       vim.fn.call("slime#config", {})
  --     end
  --
  --     vim.keymap.set("n", "<leader>cm", mark_terminal, { desc = "[m]ark terminal" })
  --     vim.keymap.set("n", "<leader>cs", set_terminal, { desc = "[s]et terminal" })
  --   end,
  -- },
  -- {
  --   "GCBallesteros/jupytext.nvim",
  --   ft = { "ipynb", "python", "markdown" },
  --   config = function()
  --     require("jupytext").setup({
  --       style = "markdown",
  --       output_extension = "md",
  --       force_ft = "markdown",
  --     })
  --   end,
  -- },
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' },
    dependencies = {
      {
        'jmbuhr/otter.nvim',
      },
    },
  },
  {
    'R-nvim/R.nvim',
    filetypes = { 'r', 'rout' },
    lazy = false,
    opts = {
      open_html = 'open',
      objbr_auto_start = false,
      objbr_opendf = false,
      open_pdf = 'no',
      hl_term = true,
      OutDec = ',',
      close_term = true,
      --external_term = "wezterm cli split-pane --pane-id 0 --bottom --percent 30",
      auto_quit = true,
      R_args = { '--quiet', '--no-save' },
      hook = {
        on_filetype = function()
          -- This function will be called at the FileType event
          -- of files supported by R.nvim. This is an
          -- opportunity to create mappings local to buffers.
          vim.keymap.set('n', '<Enter>', '<Plug>RDSendLine', { buffer = true })
          vim.keymap.set('v', '<Enter>', '<Plug>RSendSelection', { buffer = true })
          vim.keymap.set('n', '<localleader>ir', ':Roxygenize<cr>', { buffer = true })

          -- Increase the width of which-key to handle the longer r-nvim descriptions
          local wk = require 'which-key'
          -- Workaround from https://github.com/folke/which-key.nvim/issues/514#issuecomment-1987286901
          wk.add {
            buffer = true,
            mode = { 'n', 'v' },
            { '<localleader>a', group = 'all' },
            { '<localleader>b', group = 'between marks' },
            { '<localleader>c', group = 'chunks' },
            { '<localleader>f', group = 'functions' },
            { '<localleader>g', group = 'goto' },
            { '<localleader>i', group = 'install' },
            { '<localleader>k', group = 'knit' },
            { '<localleader>p', group = 'paragraph' },
            { '<localleader>q', group = 'quarto' },
            { '<localleader>r', group = 'r general' },
            { '<localleader>s', group = 'split or send' },
            { '<localleader>t', group = 'terminal' },
            { '<localleader>v', group = 'view' },
          }
        end,
      },
    },
    config = function(_, opts)
      vim.g.R_bracketed_paste = 0
      vim.g.rout_follow_colorscheme = true
      require('r').setup(opts)
      require('r.pdf.generic').open = vim.ui.open
    end,
  },
}
