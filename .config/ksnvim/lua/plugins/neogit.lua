return {
  {
    'NeogitOrg/neogit',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    branch = 'master',
    cmd = 'Neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'folke/snacks.nvim', -- optional
    },
    opts = {
      kind = 'auto',
      commit_editor = { kind = 'auto' },
      integrations = { diffview = true, telescope = nil, fzf_lua = nil, snacks = true },
    },
  },
}
