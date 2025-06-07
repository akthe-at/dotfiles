local utils = require 'utils'

-- local map = function(keys, func, desc, mode)
--   mode = mode or 'n'
--   vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
-- end
-- map('gr', require('snacks').picker.lsp_references, '[G]oto [R]eferences')
-- map('gri', require('snacks').picker.lsp_implementations, '[G]oto [I]mplementation')
-- --  To jump back, press <C-t>.
-- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
-- map('<leader>ss', require('snacks').picker.lsp_symbols, 'Open Document Symbols')
-- map('<leader>sS', require('snacks').picker.lsp_workspace_symbols, 'Open Workspace Symbols')
-- map('gy', require('snacks').picker.lsp_type_definitions, '[G]oto [T]ype Definition')
local function set_global_keymaps(client, bufnr)

  if client:supports_method 'textDocument/declaration' then
    -- Go to declaration
    utils.set_keymap {
      key = 'gD',
      cmd = vim.lsp.buf.declaration,
      desc = '[G]oto [D]eclaration',
      bufnr = bufnr,
    }
  end

  -- Float diagnostics
  utils.set_keymap {
    key = '<leader>D',
    cmd = ':Telescope diagnostics bufnr=0<CR>',
    desc = 'Show diagnostics for current buffer',
    bufnr = bufnr,
  }

  -- Show hover information
  utils.set_keymap {
    key = 'K',
    cmd = vim.lsp.buf.hover,
    desc = 'Show hover information',
    bufnr = bufnr,
  }

  -- Go to implementation
  utils.set_keymap {
    key = 'gri',
    cmd = "require('snacks').picker.lsp_implementations",
    desc = '[G]oto [I]mplementation',
    bufnr = bufnr,
  }

  -- Show signature help
  utils.set_keymap {
    key = '<C-k>',
    cmd = vim.lsp.buf.signature_help,
    desc = 'Show signature help',
    bufnr = bufnr,
  }

  -- Go to references
  utils.set_keymap {
    key = 'gr',
    cmd = "require('snacks').picker.lsp_references",
    desc = '[G]oto [R]eferences',
    bufnr = bufnr,
  }

  -- Format document
  --   utils.set_keymap({
  --     key = '<leader>fa',
  --     cmd = function()
  --       vim.lsp.buf.format({ async = true })
  --     end,
  --     desc = "Format document",
  --     bufnr = bufnr,
  --   })
end

local function configure_diagnostics()
  vim.diagnostic.config {
    virtual_text = { current_line = true },
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
    },
    float = {
      border = 'rounded',
      source = 'if_many',
    },
  }
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('global.lsp', { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local bufnr = args.buf

    set_global_keymaps(client, bufnr)
    configure_diagnostics()
  end,
})

vim.lsp.config('*', {
  capabilities = require('saghen/blink.cmp').default_capabilities(),
})
