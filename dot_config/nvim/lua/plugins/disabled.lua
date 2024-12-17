--disabling plugins from LazyVim distro
return {
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   enabled = false,
  -- },
  {
    "folke/ts-comments.nvim",
    enabled = true,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", enabled = true },
  {
    "windwp/nvim-ts-autotag",
    enabled = false,
  },
  -- {
  --   "stevearc/dressing.nvim",
  --   enabled = false,
  -- },
  -- {
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   enabled = false,
  -- },
  -- { "nvim-telescope/telescope.nvim", enabled = false },
}
