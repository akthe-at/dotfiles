local mason_bin = vim.fn.expand '$HOME/.local/share/nvim/mason/bin/'
---@type vim.lsp.Config
vim.lsp.config.basedpyright = {
  cmd = { mason_bin .. 'basedpyright-langserver', '--stdio' },
  root_markers = {
    '.git',
    'Pipfile',
    'pyproject.toml',
    'pyrightconfig.json',
    'requirements.txt',
    'setup.cfg',
    'setup.py',
  },
  filetypes = { 'python' },
  single_file_support = true,
    settings = {
    python = {
      analysis = {
        ignore = { '*' },
      },
      basedpyright = {
        disableOrganizeImports = true,
        analysis = {
          typeCheckingMode = 'standard',
          diagnosticMode = 'openFilesOnly',
          useLibraryCodeForTypes = true,
          autoImportCompletions = true,
          autoSearchPaths = true,
        },
      },
    },
  },
}

vim.lsp.enable 'basedpyright'
