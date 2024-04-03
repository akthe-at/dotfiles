return {
  {
    "R-nvim/cmp-r",
    ft = { "r", "rmd", "qmd", "rout" },
    config = function()
      require("cmp").setup.buffer({
        sources = {
          { name = "cmp_r" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      })
    end,
  },
  {
    "R-nvim/R.nvim",
    ft = { "r", "rmd", "qmd", "rout" },
    opts = {
      R_path = "C:/Users/ARK010/AppData/Local/Programs/R/R-4.3.1/bin/x64",
      open_html = 1,
      objbr_auto_start = true,
      objbr_opendf = 1,
      objr_place = "console, below",
      open_pdf = 0,
      hl_term = true,
      OutDec = ",",
      close_term = true,
      nvim_pager = "tab",
      pdfviewer = "C:\\Users\\ARK010\\scoop\\apps\\sumatrapdf\\current\\SumatraPDF.exe",
    },
    config = function()
      vim.g.R_bracketed_paste = 0
      vim.g.R_args = {}
      vim.g.rout_follow_colorscheme = false
      if vim.o.termguicolors then
        vim.g.rout_color_input = "guifg=#f265b5"
        vim.g.rout_color_normal = "guifg=#10A1BD"
        vim.g.rout_color_number = "guifg=#c0c95f"
        vim.g.rout_color_integer = "guifg=#c0c95f"
        vim.g.rout_color_float = "guifg=#c0c95f"
        vim.g.rout_color_complex = "guifg=#c0c95f"
        vim.g.rout_color_negnum = "guifg=#a48cf2"
        vim.g.rout_color_negfloat = "guifg=#a48cf2"
        vim.g.rout_color_date = "guifg=#37f499"
        vim.g.rout_color_true = "guifg=#37f499"
        vim.g.rout_color_false = "guifg=#ff5d5e"
        vim.g.rout_color_inf = "guifg=#04d1f9"
        vim.g.rout_color_constant = "guifg=#39DDFD"
        vim.g.rout_color_string = "guifg=#37f499"
        vim.g.rout_color_error = "guifg=#ffffff guibg=#f0313e"
        vim.g.rout_color_warn = "guifg=#f0313e"
        vim.g.rout_color_index = "guifg=#d0d080"
      end
    end,
  },
}
