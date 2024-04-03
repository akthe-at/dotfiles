return {
  "mbbill/undotree",
  event = "LazyFile",
  config = function()
    -- Save undo history
    --Undo tree
    vim.g.undotree_DiffCommand = "FC"
    vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)
  end,
}
