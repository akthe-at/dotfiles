return {
  { -- github PRs and the like with gh - cli
    "pwntester/octo.nvim",
    enabled = true,
    cmd = "Octo",
    config = function()
      require("octo").setup()
      vim.keymap.set("n", "<leader>gpl", ":Octo pr list<cr>", { desc = "octo [p]r list" })
      vim.keymap.set("n", "<leader>gpr", ":Octo review start<cr>", { desc = "octo [r]eview" })
    end,
  },
  {
    "NeogitOrg/neogit",
    branch = "nightly",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    opts = { diaable_commit_confirmation = true, integrations = { diffview = true, telescope = true } },
    config = true,
  },
  {
    "tpope/vim-fugitive", -- Git commands in nvim
    enabled = vim.fn.executable("git") == 1,
    dependencies = { "tpope/vim-rhubarb" },
    cmd = {
      "Gvdiffsplit",
      "Gdiffsplit",
      "Gedit",
      "Gsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GRename",
      "GDelete",
      "GRemove",
      "GBrowse",
      "Git",
      "Gstatus",
    },
    init = function()
      vim.g.fugitive_no_maps = 1
    end,
  },
}
