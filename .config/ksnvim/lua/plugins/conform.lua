return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = false, lsp_format = 'fallback', timeout_ms = 1000 }
        end,
        mode = '',
        desc = '[C]onform [F]ormat buffer',
      },
    },
    config = function()
      vim.g.autoformat = true
      require('conform').setup {
        notify_on_error = true,

        formatters_by_ft = {
          lua = { 'stylua' },
          css = { 'prettier' },
          htmldjango = { 'djlint' },
          html = { 'prettier' },
          quarto = { 'injected' },
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
          sh = { 'shfmt' },
          r = { 'air' },
          sql = { 'sqruff' },
          python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
          templ = { 'templ' },
          toml = { 'taplo ' },
          yaml = { 'prettier' },
          go = { 'goimports', 'gofumpt' },
          ['*'] = { 'injected' },
        },
        format_on_save = function(bufnr)
          if not vim.g.autoformat then
            return
          else
          if vim.bo.filetype == "templ" then
            vim.lsp.buf.format()
            return
          else
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true, sql = true }
            if disable_filetypes[vim.bo[bufnr].filetype] then
              return nil
            else
              return {
                timeout_ms = 1000,
                async = false,
                lsp_format = 'fallback',
              }
            end
          end
        end
        end,
      }
    end,
  },
}
