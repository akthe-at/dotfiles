local wezterm = require "wezterm"
local mux = wezterm.mux
local config = {}

local function recompute_line_height(window)
  local window_dims = window:get_dimensions()
  local height = window_dims.pixel_height
  local overrides = window:get_config_overrides() or {}
  overrides.line_height = 1.0
  window:set_config_overrides(overrides)
end

wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local tab, pane, window = mux.spawn_window(cmd or {})
  -- window:gui_window():maximize()
  local gui = window:gui_window()
  local width = 0.95 * screen.width
  local height = 0.90 * screen.height
  gui:set_inner_size(width, height)
  gui:set_position((screen.width - width) / 2, (screen.height - height) / 2)
  recompute_line_height(window)
end)

return config
