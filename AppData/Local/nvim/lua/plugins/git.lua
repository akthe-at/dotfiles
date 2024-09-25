return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
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

      { "<leader>a", "", desc = "+assignee (Octo)", ft = "octo" },
      { "<leader>c", "", desc = "+comment/code (Octo)", ft = "octo" },
      { "<leader>l", "", desc = "+label (Octo)", ft = "octo" },
      { "<leader>i", "", desc = "+issue (Octo)", ft = "octo" },
      { "<leader>r", "", desc = "+react (Octo)", ft = "octo" },
      { "<leader>p", "", desc = "+pr (Octo)", ft = "octo" },
      { "<leader>v", "", desc = "+review (Octo)", ft = "octo" },
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
    lazy = true,
    branch = "master",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    opts = {
      kind = "floating",
      commit_editor = { kind = "split" },
      integrations = { diffview = true, telescope = nil, fzf_lua = true },
    },
  },
}
