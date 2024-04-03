return {
  "ibhagwan/fzf-lua",
  lazy = true,
  cmd = "FzfLua",
  branch = "windows",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({ "telescope" })
  end,
}
