-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- vim.highlight.priorities.semantic_tokens = 95
vim.g.lazyvim_python_lsp = "basedpyright"
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 10
vim.opt.undofile = true
vim.opt.undodir = os.getenv("USERPROFILE") .. "/nvim-data/undo"
vim.opt.fillchars = { eob = " " }
-- LazyVim.terminal.setup("pwsh")

--If I want to use bash as my shell in the neovim terminal I uncomment the following lines.
vim.o.shell = "C:/Users/ARK010/scoop/apps/git/current/bin/bash.exe"
local gitbash_options = {
  shell = vim.fn.executable("C:/Users/ARK010/scoop/apps/git/current/bin/bash.exe") == 1
    and "C:/Users/ARK010/scoop/apps/git/current/bin/bash.exe",
  shellcmdflag = "-c",
  shellredir = ">%s 2>&1",
  shellpipe = "2>&1| tee",
  shellquote = "",
  shellxquote = "",
}

for option, value in pairs(gitbash_options) do
  vim.opt[option] = value
end

-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#cc241d", bold = false })
-- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#cc241d", bold = false })
-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#eb6f92", bold = false })
-- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#eb6f92", bold = false })
vim.opt.colorcolumn = "88"
vim.opt.mouse = "a"
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/Scripts/python")

vim.g.root_spec = { { ".git", "lua" }, "cwd" }
