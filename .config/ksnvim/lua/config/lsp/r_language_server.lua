---@type vim.lsp.Config
vim.lsp.config.r_language_server = {
  cmd = { 'R', '--slave', '--no-echo', '-e', 'languageserver::run()' },
  filetypes = { 'r', 'rmd', 'quarto' },
  root_markers = {'.Rproj', 'DESCRIPTION', 'renv.lock', 'NAMESPACE', '.Rbuildignore', '.git'},
}
vim.lsp.enable('r_language_server', true)
