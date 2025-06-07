local neogit = require 'plugins.neogit'
local wk = require 'plugins.whichkey'
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- normal mode
-- wk.add({
--   { '<c-LeftMouse>', '<cmd>lua vim.lsp.buf.definition()<CR>', desc = 'go to definition', mode = 'n', silent = true }
-- })
--- LSP Keymaps
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', 'gK', function()
  return vim.lsp.buf.signature_help()
end, { desc = 'Signature Help' })

vim.keymap.set('n','gd', function()
  return require('snacks').picker.lsp_definitions()
end, { desc = '[G]oto [D]efinition'})
vim.keymap.set('n','gt', function()
  return require('snacks').picker.lsp_type_definitions()
end, {desc = '[G]oto [T]ype Definition'})
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover { border = 'rounded', max_height = 25 }
end, { desc = 'Hover' })
vim.keymap.set('i', 'c-k', function()
  return vim.lsp.buf.signature_help()
end, { desc = 'Signature Help' })
vim.keymap.set({ 'n', 'v' }, '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set({ 'n', 'v' }, '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
vim.keymap.set({ 'n', 'v' }, '<leader>cC', vim.lsp.codelens.refresh, { desc = 'Refresh & Display Codelens' })
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })

----neogit commands-------------------
vim.keymap.set('n', '<leader>gns', ':Neogit<CR>', { desc = 'Neogit Status' })
vim.keymap.set('n', '<leader>gnc', ':Neogit commit<CR>', { desc = 'Neogit Commit' })
vim.keymap.set('n', '<leader>gnp', ':Neogit pull<CR>', { desc = 'Neogit Pull' })
vim.keymap.set('n', '<leader>gnP', ':Neogit push<CR>', { desc = 'Neogit push' })
vim.keymap.set('n', '<leader>gnb', ':Git blame_line<CR>', { desc = 'Git Blame' })

--- Toggle an Oil.Nvim floating Window --
vim.keymap.set('n', '<leader>e', "<cmd>lua require('oil').toggle_float()<CR>", { desc = 'Oil' })
vim.keymap.set('n', '<leader>E', '<CMD>Oil<CR>', { desc = 'Open Oil Buffer' })
vim.keymap.set('n', 'x', '"_x')

-- Run current buffer via UV (python)
vim.api.nvim_set_keymap('n', '<localleader>pp', '<cmd>!uv run %<CR>', { noremap = false, silent = true })

-- OBSIDIAN KEYMAPS --
vim.keymap.set('n', '<leader>onn', '<cmd>ObsidianNew<CR>', { desc = 'Create a new note' })
vim.keymap.set('n', '<leader>ont', '<cmd>ObsidianTemplate<CR>', { desc = 'Create a new note from template' })
vim.keymap.set('n', '<leader>ono', '<cmd>ObsidianOpen<CR>', { desc = 'Open a note in Obsidian App' })
vim.keymap.set('n', '<leader>onb', '<cmd>ObsidianBacklinks<CR>', { desc = 'Show Obsidian Backlinks' })
vim.keymap.set('n', '<leader>onl', '<cmd>ObsidianLinks<CR>', { desc = 'Show Obsidian Links' })
vim.keymap.set('n', '<leader>ons', '<cmd>ObsidianSearch<CR>', { desc = 'Search in Obsidian' })
vim.keymap.set('n', '<leader>onq', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Quick switch to a note' })
vim.keymap.set('n', '<leader>ond', '<cmd>ObsidianToday<CR>', { desc = "Open today's note" })

-- Toggle DBUI --
vim.keymap.set('n', '<leader>wt', '<cmd>DBUIToggle<CR>', { desc = '[T]oggle DB UI' })
vim.keymap.set('n', '<leader>wc', '<cmd>DBUIClose<CR>', { desc = '[C]lose DB UI/Connection' })

-- Go KeyMaps --
vim.keymap.set('n', '<localleader>gr', '<cmd>GoRun<CR>', { desc = 'Go Run' })
vim.keymap.set('n', '<localleader>gt', '<cmd>GoTest<CR>', { desc = 'Go Test' })
vim.keymap.set('n', '<localleader>gb', '<cmd>GoBuild<CR>', { desc = 'Go Build' })
vim.keymap.set('n', '<localleader>gd', '<cmd>GoDoc<CR>', { desc = 'Go Doc' })

-- Don't use anymore because by default yank goes to system clipboard for now, may change in the future.
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

-- vim.keymap.set({ "n", "v" }, "<leader>D", '"_d')
vim.keymap.set('x', '<leader>p', [["_dP]])

--- ??
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>xq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- better up/down
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move Lines
vim.keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

-- buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
vim.keymap.set('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
vim.keymap.set('n', '<leader>bd', function()
  Snacks.bufdelete()
end, { desc = 'Delete Buffer' })
vim.keymap.set('n', '<leader>bo', function()
  Snacks.bufdelete.other()
end, { desc = 'Delete Other Buffers' })
vim.keymap.set('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

-- Clear search and stop snippet on escape
-- vim.keymap.set({ 'i', 'n', 's' }, '<esc>', function()
--   vim.cmd 'noh'
--   LazyVim.cmp.actions.snippet_stop()
--   return '<esc>'
-- end, { expr = true, desc = 'Escape and Clear hlsearch' })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.keymap.set('n', '<leader>ur', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { desc = 'Redraw / Clear hlsearch / Diff Update' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
vim.keymap.set('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- save file
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

--keywordprg
vim.keymap.set('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

-- better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- commenting
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- lazy
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- new file
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'Create New File' })

vim.keymap.set('n', '<leader>cy', '<Plug>OSCYankOperator')
vim.keymap.set('v', '<leader>cy', '<Plug>OSCYankVisual')

-- windows
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right', remap = true })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })

-- vim: ts=2 sts=2 sw=2 et
