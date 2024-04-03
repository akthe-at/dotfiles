return {
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
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      templates = {
        subdir = "Templates",
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
          path = "~\\Documents\\Obsidian\\akthe_at\\",
        },
      },
      notes_subdir = "notes",
      ui = {
        enable = true,
      },
      nvim_cmp = true,
      min_chars = 2,
    },
    daily_notes = {
      -- optional folder to keep daily notes in:
      folder = "notes/daily",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "Templates/daily.md",
    },
    picker = {
      name = "telescope.nvim",
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
      img_folder = "assets\\imgs", -- This is the default
      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
      -- This is the default implementation.
      ---@param client obsidian.Client
      ---@param path Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        local link_path
        local vault_relative_path = client:vault_relative_path(path)
        if vault_relative_path ~= nil then
          -- Use relative path if the image is saved in the vault dir.
          link_path = vault_relative_path
        else
          -- Otherwise use the absolute path.
          link_path = tostring(path)
        end
        local display_name = vim.fs.basename(link_path)
        return string.format("![%s](%s)", display_name, link_path)
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
  },
}
