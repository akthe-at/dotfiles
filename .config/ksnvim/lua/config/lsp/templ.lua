vim.lsp.config.templ = {
  cmd = { 'templ', 'lsp' },
  filetypes = {
    'templ',
  },
  root_markers = { 'go.work', 'go.mod', '.git' },
}
vim.lsp.enable 'templ'
