require("quarto").activate()

-- markdown link text objects for i and a
vim.keymap.set({ "o", "x" }, "il", "<cmd>lua require('various-textobjs').mdlink('inner')<CR>", { buffer = true })
vim.keymap.set({ "o", "x" }, "al", "<cmd>lua require('various-textobjs').mdlink('outer')<CR>", { buffer = true })
vim.opt.colorcolumn = ""
vim.b.slime_cell_delimiter = "```"

-- wrap text, but by word no character
-- indent the wrappped line
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.showbreak = "|"
