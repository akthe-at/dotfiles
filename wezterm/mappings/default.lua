---@module "mappings.default"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: undefined-field
local act = require("wezterm").action
local key = require("utils.fn").key
local backdrops = require "utils.backdrops"
local sessionizer = require "sessionizer"
local wezterm = require "wezterm"

local Config = {}

Config.disable_default_key_bindings = true
Config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

local mappings = {
  -- Tabs
  { "<M-[>", act.ActivateTabRelative(1), "" },
  { "<M-}>", act.ActivateTabRelative(-1), "" },
  { "<C-M-[>", act.MoveTabRelative(1), "" },
  { "<C-M-]>", act.MoveTabRelative(-1), "" },
  { "<leader>F4", act.ShowLauncherArgs { flags = "FUZZY|TABS" }, "" },
  { "<C-S-t>", act.SpawnTab "CurrentPaneDomain", "" },
  {
    "<leader>r",
    act.PromptInputLine {
      description = "Enter new name for Tab",
      ---@diagnostic disable-next-line: undefined-field
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
    "Rename Tab",
  },
  { "<leader>W", act.CloseCurrentTab { confirm = true }, "" },
  {
    "<C-S-u>",
    act.CharSelect {
      copy_on_select = true,
      copy_to = "ClipboardAndPrimarySelection",
    },
    "",
  },
  -- Panes
  { "<leader>f", act.TogglePaneZoomState, "Zoom Pane" },
  { "<leader>[", act.PaneSelect { mode = "SwapWithActiveKeepFocus" }, "Swap Panes" },
  { "<leader>w", act.CloseCurrentPane { confirm = true }, "close tab" },
  { "<PageUp>", act.ScrollByPage(-1), "" },
  { "<PageDown>", act.ScrollByPage(1), "" },
  ---quick split and nav
  { "<leader>\\", act.SplitHorizontal { domain = "CurrentPaneDomain" }, "vsplit" },
  { "<leader>-", act.SplitVertical { domain = "CurrentPaneDomain" }, "hsplit" },
  { "<leader>h", act.ActivatePaneDirection "Left", "move left" },
  { "<leader>j", act.ActivatePaneDirection "Down", "move down" },
  { "<leader>k", act.ActivatePaneDirection "Up", "move up" },
  { "<leader>l", act.ActivatePaneDirection "Right", "move right" },
  -- Attach/Detach Domains
  { "<leader>a", act.AttachDomain "wsl:ssh", "Attach to WSL/SSH Domain" },
  {
    "<leader>d",
    act.DetachDomain { DomainName = "wsl:ssh" },
    "Detach from the WSL/SSH Domain",
  },
  --- Modes
  { "<leader>c", act.ActivateCopyMode, "copy mode" },
  { "<leader>s", act.Search "CurrentSelectionOrEmptyString", "search mode" },
  --- Workspaces
  { "<leader>F5", act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" }, "" },
  -- Navigate Workspace
  { "<leader>n", act.SwitchWorkspaceRelative(1), "" },
  { "<leader>p", act.SwitchWorkspaceRelative(-1), "" },
  --Rename Workspace
  {
    "<leader>R",
    act.PromptInputLine {
      description = "Enter new name for workspace",
      ---@diagnostic disable-next-line: undefined-field
      action = wezterm.action_callback(function(_, _, line)
        if line then
          ---@diagnostic disable-next-line: undefined-field
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    },
    "Rename Workspace",
  },
  ---@diagnostic disable-next-line: undefined-field
  { "<leader>m", wezterm.action_callback(sessionizer.start), "" },

  -- -Custom Backdrops---
  {
    "<leader>b",
    ---@diagnostic disable-next-line: undefined-field
    wezterm.action_callback(function(window, _)
      backdrops:toggle_focus(window)
    end),
  },
  {
    "<M-/>",
    ---@diagnostic disable-next-line: undefined-field
    wezterm.action_callback(function(window, _)
      backdrops:random(window)
    end),
    "",
  },
  {
    "<leader>/",
    act.InputSelector {
      title = "Select Background",
      choices = backdrops:choices(),
      fuzzy = true,
      fuzzy_description = "Select Background: ",
      ---@diagnostic disable-next-line: undefined-field
      action = wezterm.action_callback(function(window, _, idx)
        ---@diagnostic disable-next-line: param-type-mismatch
        backdrops:set_img(window, tonumber(idx))
      end),
    },
    "",
  },
  { "<F12>", act.ShowDebugOverlay, "" },
  { "<M-\\>", act.ToggleFullScreen, "" },
  { "<C-S-Insert>", act.PasteFrom "PrimarySelection", "" },
  { "<C-Insert>", act.CopyTo "PrimarySelection", "" },
  { "<C-S-Space>", act.QuickSelect, "quick select" },
  { "<C-S-c>", act.CopyTo "Clipboard", "" },
  { "<C-S-v>", act.PasteFrom "Clipboard", "" },
  { "<C-S-f>", act.Search "CurrentSelectionOrEmptyString", "" },
  { "<leader>K", act.ClearScrollback "ScrollbackOnly", "" },
  { "<C-S-n>", act.SpawnWindow, "" },
  { "<C-S-p>", act.ActivateCommandPalette, "" },
  { "<C-S-r>", act.ReloadConfiguration, "" },
  --- open picker
  { "<leader>t", act.ActivateKeyTable { name = "pick_mode" }, "pick mode" },
  -- Open Wezterm Config Directly
  {
    "<leader>,",
    ---@diagnostic disable-next-line: undefined-field
    wezterm.action.SpawnCommandInNewTab {
      cwd = os.getenv "WEZTERM_CONFIG_DIR",
      args = {
        "nvim",
      },
    },
  },
}

for i = 1, 9 do
  mappings[#mappings + 1] =
    { "<leader>" .. i, act.ActivateTab(i - 1), "activate tab " .. i }
end

Config.keys = {}
for _, map_tbl in pairs(mappings) do
  key.map(map_tbl[1], map_tbl[2], Config.keys)
end

return Config
