return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = "LazyFile",
    config = function()
      require("nvim-highlight-colors").setup()
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      mini = {
        position = {
          row = -2,
          col = "100%",
        },
      },
      cmdline = {
        enabled = false,
        view = "cmdline",
      },
      messages = {
        enabled = false,
      },
      lsp = {
        progress = {
          enabled = true,
          view = "mini",
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  -- stylua: ignore
  keys = {
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
  },
  },
  {
    enabled = true,
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function() end,
    config = function()
      local lualine = require("lualine")
      lualine.setup({
        options = {
          theme = "auto",
          component_separators = "",
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha" },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "", right = "" }, right_padding = 2 },
          },
          lualine_b = {
            "branch",
            "diff",
            "diagnostics",
          },
          lualine_c = {},
          lualine_x = { "filename", "filetype" },
          lualine_y = { "progress" },
          lualine_z = {
            { "location", separator = { right = "", left = "" }, left_padding = 2 },
          },
        },
        extensions = { "nvim-tree", "fzf" },
      })
    end,
  },
}
