local mason_bin = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/")
vim.lsp.config('ruff', {
  cmd = { mason_bin.."ruff", "server"},
  filetypes = {"python", "quarto"},
  init_options = {
    settings = {
      fixAll = true,
      organizeImports = true,
      logLevel = 'error',
    },
  },
})

vim.lsp.enable 'ruff'

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})
