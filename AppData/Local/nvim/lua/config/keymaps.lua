-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local neogit = require("neogit")
local wk = require("which-key")

-- the following keymap avoid the x delete key from overwriting the system clipboard
vim.keymap.set("n", "x", '"_x')

-- Launch Lua Debugger
vim.keymap.set("n", "<leader>dl", '<cmd>lua require"osv".launch({port = 8086})<CR>', { desc = "Launch Lua Debugger" })

-- Toggle an Oil.Nvim floating Window --
vim.keymap.set("n", "<leader>e", "<cmd>lua require('oil').toggle_float()<CR>", { desc = "Oil" })
vim.keymap.set("n", "<leader>E", "<CMD>Oil<CR>", { desc = "Open Oil Buffer" })
-- OBSIDIAN KEYMAPS --
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create a new note" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Create a new note from template" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open a note in Obsidian App" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show Obsidian Backlinks" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show Obsidian Links" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search in Obsidian" })
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick switch to a note" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Open today's note" })

-- next greatest remap ever : asbjornHaland
-- Don't use anymore because by default yank goes to system clipboard for now, may change in the future.
-- vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

-- Some more keymaps I dont use currently
-- vim.keymap.set('i', '<S-n>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
-- vim.keymap.set('i', '<S-m>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })

-- vim.keymap.set({ "n", "v" }, "<leader>D", '"_d')
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader>sp", "<cmd>CdProject<CR>", { desc = "[S]earch [P]rojects" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Toggle DBUI --
vim.keymap.set("n", "<leader>wt", "<cmd>DBUIToggle<CR>", { desc = "[T]oggle DB UI" })
vim.keymap.set("n", "<leader>wc", "<cmd>DBUIClose<CR>", { desc = "[C]lose DB UI/Connection" })

----neogit commands-------------------
vim.keymap.set("n", "<leader>gns", neogit.open, { desc = "Neogit Status" })
vim.keymap.set("n", "<leader>gnc", ":Neogit commit<CR>", { desc = "Neogit Commit" })
vim.keymap.set("n", "<leader>gnp", ":Neogit pull<CR>", { desc = "Neogit Pull" })
vim.keymap.set("n", "<leader>gnP", ":Neogit push<CR>", { desc = "Neogit push" })
vim.keymap.set("n", "<leader>gB", ":FzfLua git_branches<CR>", { desc = "FzfLua [g]it_[B]ranches" })
vim.keymap.set("n", "<leader>gnb", ":Git blame<CR>", { desc = "Git Blame" })

-----------------------------
--huez
-- vim.keymap.set("n", "<leader>co", "<cmd>Huez<cr>", { desc = "Start Huez" })
-- end huez -----------------

-----------------------------
-- START OF QUARTO SECTION --
-----------------------------
-- vim slime state varibles
P = vim.print
vim.g["quarto_is_r_mode"] = nil
vim.g["reticulate_running"] = false

--- Send code to terminal with vim-slime
--- If an R terminal has been opend, this is in r_mode
--- and will handle python code via reticulate when sent
--- from a python chunk.
local function send_cell()
  if vim.b["quarto_is_r_mode"] == nil then
    vim.fn["slime#send_cell"]()
    return
  end
  if vim.b["quarto_is_r_mode"] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require("otter.tools.functions").is_otter_language_context("python")
    if is_python and not vim.b["reticulate_running"] then
      vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
      vim.b["reticulate_running"] = true
    end
    if not is_python and vim.b["reticulate_running"] then
      vim.fn["slime#send"]("exit" .. "\r")
      vim.b["reticulate_running"] = false
    end
    vim.fn["slime#send_cell"]()
  end
end

--- Send code to terminal with vim-slime
--- If an R terminal has been opend, this is in r_mode
--- and will handle python code via reticulate when sent
--- from a python chunk.
local slime_send_region_cmd = ":<C-u>call slime#send_op(visualmode(), 1)<CR>"
slime_send_region_cmd = vim.api.nvim_replace_termcodes(slime_send_region_cmd, true, false, true)
local function send_region()
  -- if filetyps is not quarto, just send_region
  if vim.bo.filetype ~= "quarto" or vim.b["quarto_is_r_mode"] == nil then
    vim.cmd("normal" .. slime_send_region_cmd)
    return
  end
  if vim.b["quarto_is_r_mode"] == true then
    vim.g.slime_python_ipython = 0
    local is_python = require("otter.tools.functions").is_otter_language_context("python")
    if is_python and not vim.b["reticulate_running"] then
      vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
      vim.b["reticulate_running"] = true
    end
    if not is_python and vim.b["reticulate_running"] then
      vim.fn["slime#send"]("exit" .. "\r")
      vim.b["reticulate_running"] = false
    end
    vim.cmd("normal" .. slime_send_region_cmd)
  end
end

--- Show R dataframe in the browser
-- might not use what you think should be your default web browser
-- because it is a plain html file, not a link
-- see https://askubuntu.com/a/864698 for places to look for
local function show_r_table()
  local node = vim.treesitter.get_node({ ignore_injections = false })
  assert(node, "no symbol found under cursor")
  local text = vim.treesitter.get_node_text(node, 0)
  local cmd = [[call slime#send("DT::datatable(]] .. text .. [[)" . "\r")]]
  vim.cmd(cmd)
end

local is_code_chunk = function()
  local current, _ = require("otter.keeper").get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end

local insert_r_chunk = function()
  insert_code_chunk("r")
end

local insert_py_chunk = function()
  insert_code_chunk("python")
end

local insert_lua_chunk = function()
  insert_code_chunk("lua")
end

local insert_bash_chunk = function()
  insert_code_chunk("bash")
end

--show kepbindings with whichkey
--add your own here if you want them to
--show up in the popup as well

-- normal mode
wk.add({
  { "<c-LeftMouse>", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "go to definition", mode = "n", silent = true },
  { "zl", ":FzfLua spell_suggest<cr>", desc = "[l]ist spelling suggestions", mode = "n", silent = true },
})

-- visual mode
wk.add({
  { "<localleader><cr>", send_region, desc = "run code region", mode = "v" },
})

-- insert mode
wk.add({
  { "<m-->", " <- ", desc = "assign", mode = "i" },
  { "<m-m>", " |>", desc = "pipe", mode = "i" },
})

local function new_terminal(lang)
  vim.cmd("vsplit term://" .. lang)
end

local function new_terminal_python()
  new_terminal("python")
end

local function new_terminal_r()
  new_terminal("R --no-save")
end

local function new_terminal_ipython()
  new_terminal("ipython --no-confirm-exit")
end

local function new_terminal_shell()
  new_terminal("$SHELL")
end

-- normal mode with <leader>
-- wk.add({
--   { "<cr>", send_cell, desc = "run code cell", prefix = "<leader>", mode = "n" },
-- })


-- normal mode with <leader>
wk.add({
  {
    { "<localleader><cr>", send_cell, desc = "run code cell" },
    { "<localleader>c", group = "[c]ode / [c]ell / [c]hunk" },
    { "<localleader>ci", new_terminal_ipython, desc = "new [i]python terminal" },
    { "<localleader>cn", new_terminal_shell, desc = "[n]ew terminal with shell" },
    { "<localleader>cp", new_terminal_python, desc = "new [p]ython terminal" },
    { "<localleader>cr", new_terminal_r, desc = "new [R] terminal" },
    { "<localleader>gwc", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", desc = "worktree create" },
    { "<localleader>gws", ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", desc = "worktree switch" },
    { "<localleader>o", group = "[o]tter & c[o]de" },
    { "<localleader>oa", require'otter'.activate, desc = "otter [a]ctivate" },
    { "<localleader>ob", insert_bash_chunk, desc = "[b]ash code chunk" },
    { "<localleader>oc", "O# %%<cr>", desc = "magic [c]omment code chunk # %%" },
    { "<localleader>od", require'otter'.activate, desc = "otter [d]eactivate" },
    { "<localleader>ol", insert_lua_chunk, desc = "[l]lua code chunk" },
    { "<localleader>op", insert_py_chunk, desc = "[p]ython code chunk" },
    { "<localleader>or", insert_r_chunk, desc = "[r] code chunk" },
    { "<localleader>q", group = "[q]uarto" },
    { "<localleader>qE", function() require('otter').export(true) end, desc = "[E]xport with overwrite" },
    { "<localleader>qa", ":QuartoActivate<cr>", desc = "[a]ctivate" },
    { "<localleader>qe", require('otter').export, desc = "[e]xport" },
    { "<localleader>qh", ":QuartoHelp ", desc = "[h]elp" },
    { "<localleader>qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "[p]review" },
    { "<localleader>qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "[q]uiet preview" },
    { "<localleader>qr", group = "[r]un" },
    { "<localleader>qra", ":QuartoSendAll<cr>", desc = "run [a]ll" },
    { "<localleader>qrb", ":QuartoSendBelow<cr>", desc = "run [b]elow" },
    { "<localleader>qrr", ":QuartoSendAbove<cr>", desc = "to cu[r]sor" },
    { "<localleader>r", group = "[r] R specific tools" },
    { "<localleader>rt", show_r_table, desc = "show [t]able" },
    { "<localleader>x", group = "e[x]ecute" },
    { "<localleader>xx", ":w<cr>:source %<cr>", desc = "[x] source %" },
  }
}, { mode = 'n'})
-- END OF QUARTO SECTION --
-----------------------------
-----------------------------
