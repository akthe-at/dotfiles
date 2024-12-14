---@diagnostic disable: undefined-global
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_blink_main = true
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
LazyVim.pick("fzf")
LazyVim.terminal.setup("bash")
-- vim.g.snacks_animate = false
vim.g.LanguageClient_serverCommands = {
  r = { "R", "--slave", "-e", "languageserver::run()" },
}
-- vim.o.shell = "bash"
-- vim.opt.cmdheight = 1
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undo"
vim.opt.fillchars = { eob = " " }
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#eb6f92", bold = false })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#eb6f92", bold = false })
vim.opt.colorcolumn = "88"
vim.opt.mouse = "a"
vim.g.python3_host_prog = vim.fn.expand("/home/aktheat/.venvs/neovim/bin/python3")

vim.g.root_spec = { { ".git", "lua" }, "cwd" }

vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

-- Remove "How-to disable mouse" from right-click menu
pcall(vim.cmd.aunmenu, [[PopUp.How-to\ disable\ mouse]])
pcall(vim.cmd.aunmenu, [[PopUp.-1-]])
pcall(vim.cmd.aunmenu, [[PopUp.Paste]])

vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "win32yank-wsl.exe",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = 0,
}
