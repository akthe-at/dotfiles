local Utils = require "utils"
local wezterm = require "wezterm"
local color = Utils.fn.color
local fs = Utils.fn.fs
local mux = wezterm.mux
local Config = {}

Config.color_schemes = color.get_schemes()
Config.color_scheme = color.get_scheme()
-- local bar = wezterm.plugin.require "https://github.com/adriankarlen/bar.wezterm"
-- bar.apply_to_config(Config, {
--   max_width = 32,
--   modules = {
--     spotify = {
--       enabled = false,
--     },
--     hostname = {
--       enabled = false,
--     },
--   },
-- })
local theme = Config.color_schemes[Config.color_scheme]
wezterm.on("gui-startup", function(cmd)
  local screen = wezterm.gui.screens().active
  local _, _, window = mux.spawn_window(cmd or {})
  local gui = window:gui_window()

  local width = 0.95 * screen.width
  local height = 0.90 * screen.height
  gui:set_inner_size(width, height)
  gui:set_position((screen.width - width) / 2, (screen.height - height) / 2)
end)
Config.background = {
  {
    source = { Color = theme.background },
    width = "120%",
    height = "120%",
    vertical_offset = "-10%",
    horizontal_offset = "-10%",
    opacity = 0.96,
  },
}

Config.inactive_pane_hsb = {
  saturation = 0.6,
  brightness = 0.6,
}

Config.bold_brightens_ansi_colors = "BrightAndBold"

---char select and command palette
Config.char_select_bg_color = theme.brights[6]
Config.char_select_fg_color = theme.background
Config.char_select_font_size = 12

Config.command_palette_bg_color = theme.brights[6]
Config.command_palette_fg_color = theme.background
Config.command_palette_font_size = 14
Config.command_palette_rows = 20

---cursor
Config.cursor_blink_ease_in = "Linear"
Config.cursor_blink_rate = 500
Config.cursor_thickness = 2
Config.force_reverse_video_cursor = true
Config.default_cursor_style = "BlinkingBlock"
Config.force_reverse_video_cursor = true

Config.enable_scroll_bar = false

Config.hide_mouse_cursor_when_typing = false

---text blink
Config.text_blink_ease_in = "EaseIn"
Config.text_blink_ease_out = "EaseOut"
Config.text_blink_rapid_ease_in = "Linear"
Config.text_blink_rapid_ease_out = "Linear"
Config.text_blink_rate = 500
Config.text_blink_rate_rapid = 250

---visual bell
Config.audible_bell = "Disabled"
Config.visual_bell = {
  fade_in_function = "EaseOut",
  fade_in_duration_ms = 200,
  fade_out_function = "EaseIn",
  fade_out_duration_ms = 200,
}

---window appearance
Config.window_padding = { left = 1, right = 1, top = 1, bottom = 0 }
if fs.platform().is_win then
  Config.window_decorations = "RESIZE"
end
Config.integrated_title_button_alignment = "Right"
Config.integrated_title_button_style = "Windows"
Config.integrated_title_buttons = { "Hide", "Maximize", "Close" }

---exit behavior
Config.clean_exit_codes = { 130 }
Config.exit_behavior = "CloseOnCleanExit"
Config.exit_behavior_messaging = "Verbose"
Config.skip_close_confirmation_for_processes_named = {
  "bash",
  "sh",
  "zsh",
  "fish",
  "tmux",
  "nu",
  "cmd.exe",
  "pwsh.exe",
  "powershell.exe",
}
Config.window_close_confirmation = "AlwaysPrompt"

color.set_tab_button(Config, theme)

return Config
