local mason_bin = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/")

vim.lsp.config("html", {
		cmd = { mason_bin .. "vscode-html-language-server", "--stdio" },
		filetypes = {
			"htmlangular",
			"html",
			"templ",
		},
  root_markers = {"packages.json", ".git"},
  settings = {},
  initialization_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript"}
  },
	})
vim.lsp.enable("html")

