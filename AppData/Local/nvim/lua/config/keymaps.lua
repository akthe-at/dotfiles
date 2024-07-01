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
wk.register({
  ["<c-LeftMouse>"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "go to definition" },
  ["<localleader>ir"] = { insert_r_chunk, "r code chunk" },
  ["<localleader>ip"] = { insert_py_chunk, "python code chunk" },
  ["zl"] = { ":FzfLua spell_suggest<cr>", "[l]ist spelling suggestions" },
}, { mode = "n", silent = true })

-- visual mode
wk.register({
  ["<localleader><cr>"] = { send_region, "run code region" },
}, { mode = "v" })

-- insert mode
wk.register({
  ["<m-->"] = { " <- ", "assign" },
  ["<m-m>"] = { " |>", "pipe" },
}, { mode = "i" })

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
wk.register({
  ["<cr>"] = { send_cell, "run code cell" },
}, { mode = "n", prefix = "<leader>" })

-- normal mode with <localleader>
wk.register({
  c = {
    name = "[c]ode / [c]ell / [c]hunk",
    n = { new_terminal_shell, "[n]ew terminal with shell" },
    R = {
      function()
        vim.b["quarto_is_r_mode"] = true
        new_terminal_r()
      end,
      "new [R] terminal",
    },
    P = { new_terminal_python, "new [p]ython terminal" },
    I = { new_terminal_ipython, "new [i]python terminal" },
  },
  q = {
    name = "[q]uarto",
    a = { ":QuartoActivate<cr>", "[a]ctivate" },
    q = { ":lua require'quarto'.quartoClosePreview()<cr>", "[q]uiet preview" },
    h = { ":QuartoHelp ", "[h]elp" },
    r = {
      name = "[r]un",
      r = { ":QuartoSendAbove<cr>", "to cu[r]sor" },
      a = { ":QuartoSendAll<cr>", "run [a]ll" },
      b = { ":QuartoSendBelow<cr>", "run [b]elow" },
    },
  },
  o = {
    name = "[otter]&[r] R specific tools",
    a = { require("otter").activate, "otter [a]ctivate" },
    d = { require("otter").deactivate, "otter [d]eactivate" },
    c = { "O# %%<cr>", "magic [c]omment code chunk # %%" },
    r = { insert_r_chunk, "[r] code chunk" },
    p = { insert_py_chunk, "[p]ython code chunk" },
    b = { insert_bash_chunk, "[b]ash code chunk" },
    l = { insert_lua_chunk, "[l]lua code chunk" },
    t = { show_r_table, "show [t]able" },
  },
  x = {
    name = "e[x]ecute",
    e = { ":w<cr>:source %<cr>", "[x] source %" },
  },
}, { mode = "n", prefix = "<localleader>" })
-- END OF QUARTO SECTION --
-----------------------------
-----------------------------
