local wt = require "wezterm"
local resurrect = wt.plugin.require "https://github.com/MLFlexer/resurrect.wezterm"
resurrect.save_state_dir = "C:\\Users\\ARK010\\.config\\wezterm\\state\\" -- Set some directory where wezterm has write access

-- loads the state whenever I create a new workspace
wt.on("workspace_switcher.switched", function(window, path, label)
  local workspace_state = resurrect.workspace_state
  workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
    window = window,
    relative = true,
    restore_text = true,
    on_pane_restore = resurrect.tab_state.default_on_pane_restore,
  })
end)

-- Saves the state whenever I select a workspace
wt.on("workspace_switcher.selected", function(window, path, label)
  local workspace_state = resurrect.workspace_state
  resurrect.save_state(workspace_state.get_workspace_state())
end)
