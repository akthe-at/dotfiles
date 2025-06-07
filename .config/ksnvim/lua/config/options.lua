-- [[ Setting options ]]
vim.g.have_nerd_font = true
vim.opt.conceallevel = 2
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.confirm = true
vim.o.number = true
vim.opt.expandtab = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus'
  vim.g.clipboard = {
    name = 'win32yank-wsl.exe',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
--vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = '',
  [vim.diagnostic.severity.WARN] = '',
  [vim.diagnostic.severity.INFO] = '',
  [vim.diagnostic.severity.HINT] = '󰌵',
}
local shorter_source_names = {
  ['Lua Diagnostics.'] = 'Lua',
  ['Lua Syntax Check.'] = 'Lua',
}

function diagnostic_format(diagnostic)
  return string.format(
    '%s %s (%s): %s',
    diagnostic_signs[diagnostic.severity],
    shorter_source_names[diagnostic.source] or diagnostic.source,
    diagnostic.code,
    diagnostic.message
  )
end

vim.diagnostic.config {
  virtual_text = {
    spacing = 4,
    prefix = '',
    format = diagnostic_format,
  },
  signs = {
    text = diagnostic_signs,
  },
  virtual_lines = {
    current_line = true,
    format = diagnostic_format,
  },
  underline = true,
  severity_sort = true,
}

vim.diagnostic.config {
  virtual_text = {
    spacing = 4,
    prefix = '',
    format = diagnostic_format,
  },
  signs = {
    text = diagnostic_signs,
  },
  virtual_lines = {
    current_line = true,
    format = diagnostic_format,
  },
  underline = true,
  severity_sort = true,
}
-- vim.o.shell = "bash"
-- vim.opt.cmdheight = 1
vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.config/nvim/undo'
vim.opt.foldlevel = 99
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.ignorecase = true
vim.opt.jumpoptions = 'view'
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.pumblend = 10
vim.opt.pumheight = 10
vim.opt.ruler = false
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append { W = true, I = true, c = true, C = true }
vim.opt.sidescrolloff = 8
vim.opt.smartindent = true
vim.opt.splitkeep = 'screen'
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
vim.opt.virtualedit = 'block'
vim.opt.wildmode = 'longest:full,full'
vim.opt.winminwidth = 5
vim.opt.wrap = false
vim.opt.foldmethod = 'indent'
vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"

vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#A7C080', bold = false })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#A7C080', bold = false })

-- vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#eb6f92', bold = false })
-- vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#eb6f92', bold = false })
vim.opt.mouse = 'a'
vim.g.python3_host_prog = vim.fn.expand '/home/aktheat/.config/nvim/.venv/bin/python3.13'
vim.g.copilot_browser = 'firefox'
vim.g.root_spec = { { '.git', 'lua' }, 'cwd' }

-- Remove "How-to disable mouse" from right-click menu
pcall(vim.cmd.aunmenu, [[PopUp.How-to\ disable\ mouse]])
pcall(vim.cmd.aunmenu, [[PopUp.-1-]])
pcall(vim.cmd.aunmenu, [[PopUp.Paste]])
