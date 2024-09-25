-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
------------- R Options --------------
-------------------------------------------
------------- Python Options --------------
vim.g.lazyvim_python_lsp = "basedpyright"
-- vim.g.lazyvim_python_lsp = "pylance"
vim.g.lazyvim_python_ruff = "ruff"
-------------------------------------------
vim.opt.cmdheight = 1
-- vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.undofile = true
vim.opt.undodir = os.getenv("USERPROFILE") .. "/nvim-data/undo"
vim.opt.fillchars = { eob = " " }
LazyVim.terminal.setup("bash")
LazyVim.pick("fzf")

-- --If I want to use bash as my shell in the neovim terminal I uncomment the following lines.
-- vim.o.shell = "C:/Users/ARK010/scoop/apps/git/current/bin/bash.exe"
vim.o.shell = "bash"
local gitbash_options = {
  -- shell = vim.fn.executable("C:/Users/ARK010/scoop/apps/git/current/bin/bash.exe") == 1
  --   and "C:/Users/ARK010/scoop/apps/git/current/bin/bash.exe",
  shell = "bash",
  shellcmdflag = "-c",
  shellredir = ">%s 2>&1",
  shellpipe = "2>&1| tee",
  shellquote = "",
  shellxquote = "",
}
-- local nushell_options = {
--   -- shell = vim.fn.executable("C:/Users/ARK010/scoop/apps/git/current/bin/bash.exe") == 1
--   --   and "C:/Users/ARK010/scoop/apps/git/current/bin/bash.exe",
--   shell = "nu",
--   shellcmdflag = "-c",
--   shellredir = "| save %s",
--   shellpipe = "2>&1| tee",
--   shellquote = "",
--   shellxquote = "",
-- }
-- for option, value in pairs(nushell_options) do
--   vim.opt[option] = value
-- end

for option, value in pairs(gitbash_options) do
  vim.opt[option] = value
end

-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#eb6f92", bold = false })
-- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#eb6f92", bold = false })
vim.opt.colorcolumn = "80"
vim.opt.mouse = "a"
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/Scripts/python")

vim.g.root_spec = { { ".git", "lua" }, "cwd" }

-- Remove "How-to disable mouse" from right-click menu
pcall(vim.cmd.aunmenu, [[PopUp.How-to\ disable\ mouse]])
pcall(vim.cmd.aunmenu, [[PopUp.-1-]])
pcall(vim.cmd.aunmenu, [[PopUp.Paste]])
