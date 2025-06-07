return {

  -- {
  --   'ray-x/go.nvim',
  --   event = { 'CmdlineEnter' },
  --   ft = { 'go', 'gomod' },
  --   dependencies = { -- optional packages
  --     'ray-x/guihua.lua',
  --     'neovim/nvim-lspconfig',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   opts = {
  --     remap_commands = {
  --       GoDoc = false,
  --     },
  --   },
  --   init = function()
  --     local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
  --     vim.api.nvim_create_autocmd('BufWritePre', {
  --       pattern = '*.go',
  --       callback = function()
  --         require('go.format').goimports()
  --       end,
  --       group = format_sync_grp,
  --     })
  --   end,
  --
  --   build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  -- },
  {
    'numToStr/Comment.nvim',
    event = 'LazyFile',
    version = nil,
    cond = function()
      return vim.fn.has 'nvim-0.10' == 0
    end,
    branch = 'master',
    opts = {},
  },
}
