return {
  {
    "meanderingprogrammer/markdown.nvim",
    opts = {
      file_types = { "markdown", "quarto", "norg", "rmd", "org" },
      code = {
        sign = true,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
    },
  },
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   enabled = true,
  --   ft = { "qmd", "rmd" },
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = function()
  --     local custom = {
  --       codeblock_highlight = false,
  --       dash_string = "━",
  --       fat_headlines = false,
  --       headline_highlights = { "Headline1", "Headline2", "Headline3" },
  --       bullet_highlights = { "Headline1", "Headline2", "Headline3" },
  --       bullets = { "❯", "❯", "❯", "❯" },
  --     }
  --     local qmd = vim.tbl_deep_extend("force", custom, { treesitter_language = "markdown" })
  --     local bg = "#292e42"
  --     vim.api.nvim_set_hl(0, "Headline1", { fg = "#39DDFD", bg = bg })
  --     vim.api.nvim_set_hl(0, "Headline2", { fg = "#04d1f9", bg = bg })
  --     vim.api.nvim_set_hl(0, "Headline3", { fg = "#10A1BD", bg = bg })
  --     vim.api.nvim_set_hl(0, "CodeBlock", { bg = bg })
  --     vim.api.nvim_set_hl(0, "Dash", { fg = "#37f499", bold = true })
  --     require("headlines").setup({
  --       quarto = {
  --         query = vim.treesitter.query.parse(
  --           "markdown",
  --           [[
  --               (fenced_code_block) @codeblock
  --               ]]
  --         ),
  --         codeblock_highlight = "CodeBlock",
  --         treesitter_language = "markdown",
  --       },
  --       markdown = {
  --         query = vim.treesitter.query.parse(
  --           "markdown",
  --           [[
  --               (fenced_code_block) @codeblock
  --               ]]
  --         ),
  --         codeblock_highlight = "CodeBlock",
  --       },
  --     })
  --   end,
  -- },
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    opts = {
      width = 150,
      mappings = { enabled = true },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    cmd = {
      "ObsidianOpen",
      "ObsidianQuickSwitch",
      "ObsidianNewFromTemplate",
      "ObsidianTOC",
      "ObsidianNew",
      "ObsidianFollowLink",
      "ObsidianWorkspace",
      "ObsidianBacklinks",
      "ObsidianDailies",
      "ObsidianLink",
      "ObsidianLinkNew",
      "ObsidianLinks",
      "ObsidianSearch",
      "ObsidianPasteImg",
      "ObsidianRename",
      "ObsidianTemplate",
      "ObsidianToday",
      "ObsidianTomorrow",
      "ObsidianYesterday",
      "ObsidianDailies",
      "ObsidianTags",
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required.
      "hrsh7th/nvim-cmp",
      -- "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ibhagwan/fzf-lua",
    },
    opts = {
      templates = {
        subdir = "/Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",

        substitutions = {
          time24 = function()
            return os.date("%H:%M:%S")
          end,
          time12 = function()
            -- Conversion to 12-hour format with AM/PM
            local hour = tonumber(os.date("%H"))
            local ampm = hour >= 12 and "PM" or "AM"
            hour = hour % 12
            hour = hour == 0 and 12 or hour
            return string.format("%02d:%s %s", hour, os.date("%M:%S"), ampm)
          end,
          year = function()
            return os.date("%Y", os.time())
          end,
          month = function()
            return os.date("%B", os.time())
          end,
          yesterday = function()
            return os.date("%Y-%m-%d", os.time() - 86400)
          end,
          nextday = function()
            return os.date("%Y-%m-%d", os.time() + 86400)
          end,
          hdate = function()
            return os.date("%A, %B %d, %Y")
          end,
          rfc3339 = function()
            return os.date("!%Y-%m-%dT%H:%M:%SZ")
          end,
          week = function()
            return os.date("%V", os.time())
          end,
          isoweek = function()
            return os.date("%G-W%V", os.time())
          end,
          isoprevweek = function()
            local adjustment = -7 * 24 * 60 * 60 -- One week in seconds
            return os.date("%G-W%V", os.time() + adjustment)
          end,
          isonextweek = function()
            local adjustment = 7 * 24 * 60 * 60 -- One week in seconds
            return os.date("%G-W%V", os.time() + adjustment)
          end,
          day_of_month = function()
            return os.date("%d", os.time())
          end,
          month_numeric = function()
            return os.date("%m", os.time())
          end,
          weekday = function()
            return os.date("%A", os.time())
          end,
        },
      },
      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart({ "open", url }) -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
      end,

      workspaces = {
        {
          name = "work",
          path = "~/Documents/Obsidian/akthe_at/",
        },
      },
      notes_subdir = "/notes",
      daily_notes = {
        -- optional folder to keep daily notes in:
        folder = "/notes/daily",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "daily.md",
      },
      ui = {
        enable = false,
      },
      nvim_cmp = true,
      min_chars = 2,
    },
    picker = {
      -- name = "telescope.nvim",
      name = "fzf-lua",
      mappings = {
        new = "<C-x>",
        insert_link = "<c-l>",
      },
    },
    sort_by = "modified",
    sort_reversed = true,
    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = "assets/imgs", -- This is the default
      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
      -- This is the default implementation.
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
    new_notes_location = "notes_subdir",
    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,

    preferred_link_style = "wiki",

    -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
    ---@return string
    image_name_func = function()
      -- Prefix image names with timestamp.
      return string.format("%s-", os.time())
    end,

    -- Optional, boolean or a function that takes a filename and returns a boolean.
    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
    disable_frontmatter = false,
    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
  },
}
