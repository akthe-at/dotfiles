vim.lsp.config('ty', {
  cmd = { 'uvx', 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
})

vim.lsp.enable('ty')
