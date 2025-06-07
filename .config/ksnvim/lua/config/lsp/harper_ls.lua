local mason_bin = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/")
vim.lsp.config.harper_ls = {
  cmd = { mason_bin..'harper-ls', '--stdio' },
  filetypes = { 'markdown', 'quarto', 'qmd' },
  settings = {
    ['harper-ls'] = {
      userDictPath = '~/dict.txt',
      linters = {
        spell_check = true,
        spelled_numbers = false,
        an_a = true,
        sentence_capitalization = true,
        unclosed_quotes = true,
        wrong_quotes = false,
        long_sentences = true,
        repeated_words = true,
        spaces = true,
        matcher = true,
        correct_number_suffix = true,
        number_suffix_capitalization = true,
        multiple_sequential_pronouns = true,
        linking_verbs = false,
        avoid_curses = true,
      },
    },
  },
  root_markers = { '.git' },
  single_file_support = true,
}

vim.lsp.enable 'harper_ls'
