return {
  {
    "pwntester/octo.nvim",
    opts = {
      enable_builtin = true,
      default_to_projects_v2 = true,
      default_merge_method = "squash",
      picker = "fzf-lua",
    },
    keys = {
      { "<leader>goi", "<cmd>Octo issue list<CR>", desc = "List Isues (Octo)" },
      { "<leader>goI", "<cmd>Octo issue search<CR>", desc = "Search Isues (Octo)" },
      { "<leader>gop", "<cmd>Octo pr list<CR>", desc = "List PRs (Octo)" },
      { "<leader>goP", "<cmd>Octo pr search<CR>", desc = "Search PRs (Octo)" },
      { "<leader>gor", "<cmd>Octo repo list<CR>", desc = "List Repos (Octo)" },
      { "<leader>goS", "<cmd>Octo search<CR>", desc = "Search (Octo)" },

      { "<leader>a", "", desc = "+assignee (Otco)", ft = "octo" },
      { "<leader>c", "", desc = "+comment/code (Otco)", ft = "octo" },
      { "<leader>l", "", desc = "+label (Otco)", ft = "octo" },
      { "<leader>i", "", desc = "+issue (Otco)", ft = "octo" },
      { "<leader>r", "", desc = "+react (Otco)", ft = "octo" },
      { "<leader>p", "", desc = "+pr (Otco)", ft = "octo" },
      { "<leader>v", "", desc = "+review (Otco)", ft = "octo" },
      { "@", "@<C-x><C-o>", mode = "i", ft = "octo", silent = true },
      { "#", "#<C-x><C-o>", mode = "i", ft = "octo", silent = true },
      ---- Disable Lazy's version below ----
      { "<leader>gi", false },
      { "<leader>gI", false },
      { "<leader>gp", false },
      { "<leader>gP", false },
      { "<leader>gr", false },
      { "<leader>gS", false },
    },
  },
  {
    "NeogitOrg/neogit",
    enabled = true,
    lazy = true,
    branch = "master",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    opts = {
      kind = "split",
      commit_editor = { kind = "split" },
      integrations = { diffview = true, telescope = nil, fzf_lua = true },
    },
    config = true,
  },
  -- {
  --   "tpope/vim-fugitive", -- Git commands in nvim
  --   dependencies = { "tpope/vim-rhubarb" },
  --   cmd = {
  --     "Gvdiffsplit",
  --     "Gdiffsplit",
  --     "Gedit",
  --     "Gsplit",
  --     "Gread",
  --     "Gwrite",
  --     "Ggrep",
  --     "GMove",
  --     "GRename",
  --     "GDelete",
  --     "GRemove",
  --     "GBrowse",
  --     "Git",
  --     "Gstatus",
  --   },
  --   init = function()
  --     vim.g.fugitive_no_maps = 1
  --   end,
  -- },
}
