return {
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 2, -- MiB (2 MiB is just over 2MB)
      features = {
        "indent_blankline",
        "lsp",
        "treesitter",
        "syntax",
        -- "matchparen", -- I'm not sure about this having a large impact on perf, and it stays disabled, so I'm going to comment it out
        "vimopts",
        "filetype",
        {
          name = "neoscroll",
          disable = function()
            vim.api.nvim_buf_set_var(0, "disable_neoscroll", true)
          end,
        },
      },
    },
  },
  {
    "benlubas/molten-nvim",
    lazy = false,
    enabled = true,
    -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    ft = { "python", "quarto", "markdown", "ipynb" },
    cmd = { "MoltenInit", "MoltenImportOutput", "MoltenExportOutput", "MoltenEvaluateOperator" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- vim.g.molten_show_mimetype_debug = true
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_show_more = true
      vim.g.molten_image_provider = "wezterm"
      vim.g.molten_output_win_border = { "", "━", "", "" }
      vim.g.molten_output_win_max_height = 25
      vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true
      vim.g.molten_tick_rate = 175
      vim.g.molten_auto_image_popup = false

      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInitPost",
        callback = function()
          -- quarto code runner mappings
          local r = require("quarto.runner")
          vim.keymap.set("n", "<localleader>rc", r.run_cell, { desc = "run cell", silent = true })
          vim.keymap.set("n", "<localleader>ra", r.run_above, { desc = "run cell and above", silent = true })
          vim.keymap.set("n", "<localleader>rb", r.run_below, { desc = "run cell and below", silent = true })
          vim.keymap.set("n", "<localleader>rl", r.run_line, { desc = "run line", silent = true })
          vim.keymap.set("n", "<localleader>rA", r.run_all, { desc = "run all cells", silent = true })
          vim.keymap.set("n", "<localleader>RA", function()
            r.run_all(true)
          end, {
            desc = "run all cells of all languages",
            silent = true,
          })

          -- setup some molten specific keybindings
          vim.keymap.set(
            "n",
            "<localleader>e",
            ":MoltenEvaluateOperator<CR>",
            { desc = "evaluate operator", silent = true }
          )
          vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
          vim.keymap.set(
            "v",
            "<localleader>r",
            ":<C-u>MoltenEvaluateVisual<CR>gv",
            { desc = "execute visual selection", silent = true }
          )
          vim.keymap.set(
            "n",
            "<localleader>os",
            ":noautocmd MoltenEnterOutput<CR>",
            { desc = "open output window", silent = true }
          )
          vim.keymap.set(
            "n",
            "<localleader>oh",
            ":MoltenHideOutput<CR>",
            { desc = "close output window", silent = true }
          )
          vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })
          local open = false
          vim.keymap.set("n", "<localleader>ot", function()
            open = not open
            vim.fn.MoltenUpdateOption("auto_open_output", open)
          end)

          -- if we're in a python file, change the configuration a little
          if vim.bo.filetype == "python" then
            vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
            vim.fn.MoltenUpdateOption("molten_virt_text_output", true)
          end
        end,
      })

      -- change the configuration when editing a python file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.py",
        callback = function(e)
          if string.match(e.file, ".otter.") then
            return
          end
          if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
            vim.fn.MoltenUpdateOption("molten_virt_text_output", true)
          end
        end,
      })
      -- Undo those config changes when we go back to a markdown or quarto file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.qmd", "*.md", "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", true)
            vim.fn.MoltenUpdateOption("molten_virt_text_output", true)
          end
        end,
      })

      local imb = function(e)
        vim.schedule(function()
          local kernels = vim.fn.MoltenAvailableKernels()

          local try_kernel_name = function()
            local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
            return metadata.kernelspec.name
          end
          local ok, kernel_name = pcall(try_kernel_name)

          if not ok or not vim.tbl_contains(kernels, kernel_name) then
            kernel_name = nil
            local venv = os.getenv("VIRTUAL_ENV")
            if venv ~= nil then
              kernel_name = string.match(venv, "/.+/(.+)")
            end
          end

          if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
          end
          vim.cmd("MoltenImportOutput")
        end)
      end
      -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.ipynb" },
        callback = function(e)
          if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
          end
        end,
      })
      -- automatically import output chunks from a jupyter notebook
      vim.api.nvim_create_autocmd("BufAdd", {
        pattern = { "*.ipynb" },
        callback = imb,
      })

      -- automatically export output chunks to a jupyter notebook
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
          end
        end,
      })
    end,
  },
  {
    "jpalardy/vim-slime",
    ft = { "quarto" },
    init = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1
      vim.g.slime_dispatch_ipython_pause = 100
      vim.g.slime_cell_delimiter = "#\\s\\=%%"

      vim.cmd([[
      function! _EscapeText_quarto(text)
      if slime#config#resolve("python_ipython") && len(split(a:text,"\n")) > 1
      return ["%cpaste -q\n", slime#config#resolve("dispatch_ipython_pause"), a:text, "--\n"]
      else
      let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
      let no_empty_lines = substitute(a:text, empty_lines_pat, "", "g")
      let dedent_pat = '\(^\|\n\)\zs'.matchstr(no_empty_lines, '^\s*')
      let dedented_lines = substitute(no_empty_lines, dedent_pat, "", "g")
      let except_pat = '\(elif\|else\|except\|finally\)\@!'
      let add_eol_pat = '\n\s[^\n]\+\n\zs\ze\('.except_pat.'\S\|$\)'
      return substitute(dedented_lines, add_eol_pat, "\n", "g")
      end
      endfunction
      ]])
    end,
    config = function()
      vim.keymap.set({ "n", "i" }, "<m-cr>", function()
        vim.cmd([[ call slime#send_cell() ]])
      end, { desc = "send code cell to terminal" })
    end,
  },
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
          languages = { "r", "python", "sql", "bash", "julia", "html", "javacsripts" },
          chunks = "all",
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
          ft_runners = { python = "molten" },
          default_method = "slime",
          never_run = { "yaml" },
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
  {
    "R-nvim/cmp-r",
    ft = { "r", "rmd", "quarto", "rout" },
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
    ft = { "r", "rmd", "rout" },
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
      pdfviewer = "sumatrapdf",
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
