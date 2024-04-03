local act = require("wezterm").action
local fun = require "utils.fun" ---@class Fun
local wezterm = require "wezterm"
local sessionizer = require "sessionizer"
local backdrops = require "utils.backdrops"
local session_manager = require "wezterm-session-manager/session-manager"

---@class Config
local Config = {}
Config.disable_default_key_bindings = true
Config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

local keys = {
  ["<M-[>"] = act.ActivateTabRelative(1),
  ["<M-]>"] = act.ActivateTabRelative(-1),
  ["<C-M-[>"] = act.MoveTabRelative(1),
  ["<C-M-]>"] = act.MoveTabRelative(-1),
  ["<leader>F4"] = act.ShowLauncherArgs { flags = "FUZZY|TABS" },
  ["<leader>F5"] = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" },
  ["<F12>"] = act.ShowDebugOverlay,
  ["<M-\\>"] = act.ToggleFullScreen,
  ["<C-S-c>"] = act.CopyTo "Clipboard",
  ["<C-S-v>"] = act.PasteFrom "Clipboard",
  ["<C-S-f>"] = act.Search "CurrentSelectionOrEmptyString",
  ["<leader>K"] = act.ClearScrollback "ScrollbackOnly",
  ["<C-S-n>"] = act.SpawnWindow,
  ["<C-S-p>"] = act.ActivateCommandPalette,
  ["<C-S-r>"] = act.ReloadConfiguration,
  ["<C-S-t>"] = act.SpawnTab "CurrentPaneDomain",
  ["<C-S-w>"] = act.CloseCurrentTab { confirm = true },
  ["<C-S-u>"] = act.CharSelect {
    copy_on_select = true,
    copy_to = "ClipboardAndPrimarySelection",
  },
  ["<C-S-z>"] = act.TogglePaneZoomState,
  ["<leader>W"] = act.CloseCurrentPane { confirm = true },
  ["<PageUp>"] = act.ScrollByPage(-1),
  ["<PageDown>"] = act.ScrollByPage(1),
  ["<C-S-Insert>"] = act.PasteFrom "PrimarySelection",
  ["<C-Insert>"] = act.CopyTo "PrimarySelection",
  ["<C-S-Space>"] = act.QuickSelect,

  ---quick split and nav
  ["<leader>\\"] = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  ["<leader>-"] = act.SplitVertical { domain = "CurrentPaneDomain" },
  ["<leader>h"] = act.ActivatePaneDirection "Left",
  ["<leader>j"] = act.ActivatePaneDirection "Down",
  ["<leader>k"] = act.ActivatePaneDirection "Up",
  ["<leader>l"] = act.ActivatePaneDirection "Right",

  ---key tables
  ["<leader>w"] = act.ActivateKeyTable { name = "window_mode", one_shot = false },
  ["<leader>f"] = act.ActivateKeyTable { name = "font_mode", one_shot = false },
  ["<leader>c"] = act.ActivateCopyMode,
  ["<leader>s"] = act.Search "CurrentSelectionOrEmptyString",
  ["<leader>S"] = wezterm.action_callback(session_manager.save_state),
  ["<leader>L"] = wezterm.action_callback(session_manager.load_state),
  ["<leader>P"] = wezterm.action_callback(session_manager.restore_state),

  --custom keys
  --rename Tab
  ["<leader>r"] = act.PromptInputLine {
    description = "Enter new name for Tab",
    action = wezterm.action_callback(function(_, tab, line)
      if line then
        wezterm.custom_tab_titles[tab.id] = line
        print(_)
        print(tab)
        print(line)
      end
    end),
  },
  -- Navigate Workspace
  ["<leader>n"] = act.SwitchWorkspaceRelative(1),
  ["<leader>p"] = act.SwitchWorkspaceRelative(-1),
  --Rename Workspace
  ["<leader>R"] = act.PromptInputLine {
    description = "Enter new name for workspace",
    action = wezterm.action_callback(function(_, _, line)
      if line then
        wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
      end
    end),
  },
  ["<leader>m"] = wezterm.action_callback(sessionizer.start),
  ---Custom Backdrops---
  ["<M-/>"] = wezterm.action_callback(function(window, _)
    backdrops:random(window)
  end),
  ["<leader>/"] = act.InputSelector {
    title = "Select Background",
    choices = backdrops:choices(),
    fuzzy = true,
    fuzzy_description = "Select Background: ",
    action = wezterm.action_callback(function(window, _pane, idx)
      ---@diagnostic disable-next-line: param-type-mismatch
      backdrops:set_img(window, tonumber(idx))
    end),
  },
  -- Open Wezterm Config Directly
  ["<leader>,"] = wezterm.action.SpawnCommandInNewTab {
    cwd = os.getenv "WEZTERM_CONFIG_DIR",
    args = {
      "C:/Users/ARK010/scoop/shims/nvim.exe",
      os.getenv "WEZTERM_CONFIG_FILE",
    },
  },
}

for i = 1, 9 do
  keys["<leader>" .. i .. ""] = act.ActivateTab(i - 1)
end

Config.keys = {}
for lhs, rhs in pairs(keys) do
  fun.map(lhs, rhs, Config.keys)
end

return Config

