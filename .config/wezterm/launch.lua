local wezterm = require "wezterm"
local mux = wezterm.mux
local config = {}

wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local tab, pane, window = mux.spawn_window(cmd or {})
  -- window:gui_window():maximize()
  local gui = window:gui_window()
  local width = 0.90 * screen.width
  local height = 0.85 * screen.height
  gui:set_inner_size(width, height)
  gui:set_position((screen.width - width) / 2, (screen.height - height) / 2)
end)

return config

