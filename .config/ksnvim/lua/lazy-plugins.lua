-- [[ Configure and install plugins ]]
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  { import = 'plugins' },
}, {
  rocks = { enabled = false },
  defaults = {
    lazy = false,
    version = false,
    install = { colorscheme = { 'vague', 'catppuccin' } },
    checker = {
      enabled = false, -- check for plugin updates periodically
      notify = false, -- notify on update
    },
    performance = {
      rtp = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

local lsp_path = vim.fn.stdpath 'config' .. '/lua/config/lsp'
for _, file in ipairs(vim.fn.readdir(lsp_path)) do
  if file:match '%.lua' and file ~= 'global.lua' then
    local module_name = 'config.lsp.' .. file:gsub('%.lua$', '')
    require(module_name)
  end
end

-- vim: ts=2 sts=2 sw=2 et
