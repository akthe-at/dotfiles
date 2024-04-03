return {
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    ft = { "ipynb", "python", "md" },
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      })
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        opts = {
          handle_leading_whitespace = true,
          lsp = {
            hover = { border = "none" },
          },
        },
      },
      "hrsh7th/nvim-cmp",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local quarto = require("quarto")
      quarto.setup({
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          languages = { "r", "python" },
          chunks = "all", -- 'curly' or 'all'
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "K",
          definition = "gd",
          type_definition = "gD",
          rename = "<leader>rn",
          references = "gr",
          format = "<leader>gf",
        },
        codeRunner = {
          enabled = true,
          ft_runners = {
            bash = "slime",
          },
          default_method = "molten",
        },
      })

      vim.keymap.set("n", "<localleader>qp", quarto.quartoPreview, {
        desc = "Preview the Quarto document",
        silent = true,
        noremap = true,
      })
      -- to create a cell in insert mode, I have the ` snippet
      vim.keymap.set("n", "<localleader>cc", "i`<c-j>", { desc = "Create a new code cell", silent = true })
      vim.keymap.set(
        "n",
        "<localleader>cs",
        "i```\r\r```{}<left>",
        { desc = "Split code cell", silent = true, noremap = true }
      )
    end,
  },
}
