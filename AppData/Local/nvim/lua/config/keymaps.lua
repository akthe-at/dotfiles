-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local neogit = require("neogit")
--
vim.keymap.set("n", "x", '"_x')
--
vim.keymap.set("n", "<leader>dl", '<cmd>lua require"osv".launch({port = 8086})<CR>', { desc = "Launch Lua Debugger" })
vim.keymap.set("n", "<leader>e", "<cmd>lua require('oil').toggle_float()<CR>", { desc = "Oil" })
--
-- OBSIDIAN KEYMAPS --
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create a new note" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Create a new note from template" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open a note in Obsidian App" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show Obsidian Backlinks" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show Obsidian Links" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search in Obsidian" })
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick switch to a note" })

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>D", '"_d')
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>sp", "<cmd>CdProject<CR>", { desc = "[S]earch [P]rojects" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- vim.keymap.set('i', '<S-n>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
-- vim.keymap.set('i', '<S-m>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--neogen commands
vim.keymap.set("n", "<leader>nf", ":lua require('neogen').generate()<CR>")
vim.keymap.set("n", "<leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>")

--neogit commands
vim.keymap.set("n", "<leader>gs", neogit.open, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gB", ":Git blame<CR>", { silent = true, noremap = true })

-- vim.keymap.set("n", "<leader>uC", ":Telescope themes<CR>", { silent = true, noremap = true })
--
