vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'


-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'
-- [[ Configure and install plugins ]]
require 'lazy-plugins'
vim.cmd 'colorscheme kanagawa-wave'
-- [[ Setting options ]]
require 'config.options'
require 'config.autocmds'

-- [[ Basic Keymaps ]]
require 'config.keymaps'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
