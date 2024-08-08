---@module "mappings.default"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: undefined-field
local act = require("wezterm").action
local key = require("utils.fn").key
local backdrops = require "utils.backdrops"
-- local session_manager = require "wezterm-session-manager/session-manager"
local sessionizer = require "sessionizer"
local wezterm = require "wezterm"
local resurrect = wezterm.plugin.require "https://github.com/MLFlexer/resurrect.wezterm"
local workspace_state = resurrect.workspace_state
resurrect.save_state_dir = "C:\\Users\\ARK010\\.config\\wezterm\\state\\" -- Set some directory where wezterm has write access

local Config = {}
Config.disable_default_key_bindings = true
Config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }

local mappings = {
  { "<M-[>", act.ActivateTabRelative(1), "" },
  { "<M-}>", act.ActivateTabRelative(-1), "" },
  { "<C-M-[>", act.MoveTabRelative(1), "" },
  { "<C-M-]>", act.MoveTabRelative(-1), "" },
  { "<leader>F4", act.ShowLauncherArgs { flags = "FUZZY|TABS" }, "" },
  { "<leader>F5", act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" }, "" },
  { "<F12>", act.ShowDebugOverlay, "" },
  { "<M-\\>", act.ToggleFullScreen, "" },
  { "<C-S-c>", act.CopyTo "Clipboard", "" },
  { "<C-S-v>", act.PasteFrom "Clipboard", "" },
  { "<C-S-f>", act.Search "CurrentSelectionOrEmptyString", "" },
  { "<leader>K", act.ClearScrollback "ScrollbackOnly", "" },
  { "<C-S-n>", act.SpawnWindow, "" },
  { "<C-S-p>", act.ActivateCommandPalette, "" },
  { "<C-S-r>", act.ReloadConfiguration, "" },
  { "<C-S-t>", act.SpawnTab "CurrentPaneDomain", "" },
  { "<C-S-w>", act.CloseCurrentTab { confirm = true }, "" },
  {
    "<C-S-u>",
    act.CharSelect {
      copy_on_select = true,
      copy_to = "ClipboardAndPrimarySelection",
    },
    "",
  },
  { "<C-S-z>", act.TogglePaneZoomState, "" },
  { "<leader>W", act.CloseCurrentPane { confirm = true }, "close tab" },
  { "<PageUp>", act.ScrollByPage(-1), "" },
  { "<PageDown>", act.ScrollByPage(1), "" },
  { "<C-S-Insert>", act.PasteFrom "PrimarySelection", "" },
  { "<C-Insert>", act.CopyTo "PrimarySelection", "" },
  { "<C-S-Space>", act.QuickSelect, "quick select" },

  ---quick split and nav
  { "<leader>\\", act.SplitHorizontal { domain = "CurrentPaneDomain" }, "vsplit" },
  { "<leader>-", act.SplitVertical { domain = "CurrentPaneDomain" }, "hsplit" },
  { "<leader>h", act.ActivatePaneDirection "Left", "move left" },
  { "<leader>j", act.ActivatePaneDirection "Down", "move down" },
  { "<leader>k", act.ActivatePaneDirection "Up", "move up" },
  { "<leader>l", act.ActivatePaneDirection "Right", "move right" },

  ---key tables
  { "<leader>H", act.ActivateKeyTable { name = "help_mode", one_shot = true }, "help" },
  {
    "<leader>w",
    act.ActivateKeyTable { name = "window_mode", one_shot = false },
    "window mode",
  },
  {
    "<leader>F",
    act.ActivateKeyTable { name = "font_mode", one_shot = false },
    "font mode",
  },
  -- { "<leader>f", font.selector_action(), "selector action" },
  { "<leader>c", act.ActivateCopyMode, "copy mode" },
  { "<leader>s", act.Search "CurrentSelectionOrEmptyString", "search mode" },
  -- { "<leader>S", wezterm.action_callback(session_manager.save_state), "session save" },
  {
    "<leader>S",
    act.Multiple {
      wezterm.action_callback(function(win, pane)
        resurrect.save_state_dir = "C:\\Users\\ARK010\\.config\\wezterm\\state\\"
        resurrect.save_state(workspace_state.get_workspace_state())
      end),
    },
    "save workspace state",
  },
  -- { "<leader>L", wezterm.action_callback(session_manager.load_state), "load session" },
  { "<leader>t", act.ActivateKeyTable { name = "pick_mode" }, "pick mode" },
  -- {
  --   "<leader>P",
  --   wezterm.action_callback(session_manager.restore_state),
  --   "restore session",
  -- },
  {
    "<leader>P",
    act.Multiple {
      wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_load(win, pane, function(id, label)
          id = string.match(id, "([^/]+)$")
          id = string.match(id, "(.+)%..+$")
          local state = resurrect.load_state(id, "workspace")
          workspace_state.restore_workspace(state, {
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          })
        end)
      end),
    },
    "load workspace state",
  },
  --custom keys
  --rename Tab
  {
    "<leader>r",
    act.PromptInputLine {
      description = "Enter new name for Tab",
      action = wezterm.action_callback(function(_, tab, line)
        if line then
          wezterm.custom_tab_titles[tab.id] = line
        end
      end),
    },
    "rename_tab",
  },
  -- Navigate Workspace
  { "<leader>n", act.SwitchWorkspaceRelative(1), "" },
  { "<leader>p", act.SwitchWorkspaceRelative(-1), "" },
  --Rename Workspace
  {
    "<leader>R",
    act.PromptInputLine {
      description = "Enter new name for workspace",
      action = wezterm.action_callback(function(_, _, line)
        if line then
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    },
    "",
  },
  { "<leader>m", wezterm.action_callback(sessionizer.start), "" },
  -- {
  --   "<leader>m",
  --   wezterm.action_callback(workspace_switcher.switch_workspace),
  --   "",
  -- },
  -- -Custom Backdrops---
  {
    "<M-/>",
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
      action = wezterm.action_callback(function(window, _, idx)
        ---@diagnostic disable-next-line: param-type-mismatch
        backdrops:set_img(window, tonumber(idx))
      end),
    },
    "",
  },
  -- Open Wezterm Config Directly
  {
    "<leader>,",
    wezterm.action.SpawnCommandInNewTab {
      cwd = os.getenv "WEZTERM_CONFIG_DIR",
      args = {
        "nvim",
        os.getenv "WEZTERM_CONFIG_FILE",
      },
    },
    -- Open Neovim Config Directly
    {
      "<leader>.",
      wezterm.action.SpawnCommandInNewTab {
        cwd = os.getenv "NEOVIM_CONFIG_DIR",
        args = {
          "nvim",
          os.getenv "NEOVIM_CONFIG_FILE",
        },
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
