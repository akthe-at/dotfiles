-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python", -- filetype for which to run the autocmd
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.conceallevel = 0
    vim.opt_local.smartindent = true
    vim.opt_local.foldmethod = "indent"
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Open file at the last position it was edited earlier",
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

-- wrap  in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt.spelllang = "en_us"
    vim.opt.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "r", -- filetype for which to run the autocmd
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.conceallevel = 0
    vim.opt_local.softtabstop = 2
    vim.opt_local.smartindent = true
    vim.opt_local.foldmethod = "indent"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  command = ":lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })",
})

local autocomplete_group = vim.api.nvim_create_augroup("vimrc_autocompletion", { clear = true })
local cmp = require("cmp")
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    cmp.setup.buffer({
      sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "vim-dadbod-completion" },
        { name = "path" },
        { name = "buffer" },
      },
    })
  end,
  group = autocomplete_group,
})
