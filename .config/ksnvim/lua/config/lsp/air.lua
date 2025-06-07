vim.lsp.config.air = {
  cmd = { 'air', 'language-server' },
  filetypes = { 'r' },
  root_markers = { 'air.toml', '.air.toml', '.git' },
  single_file_support = true,
}

vim.lsp.enable 'air'
