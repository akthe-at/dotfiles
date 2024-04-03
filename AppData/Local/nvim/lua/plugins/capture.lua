return {
  {
    "michaelrommel/nvim-silicon",
    cmd = "Silicon",
    config = function()
      require("silicon").setup({
        -- Configuration here, or leave empty to use defaults
        font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
        theme = "Monokai Extended",
        to_clipboard = true,
        output = function()
          return "~/.code-shots/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
        end,
        window_title = function()
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
        end,
      })
    end,
  },
}
