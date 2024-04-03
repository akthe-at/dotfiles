--
local main = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#ebbcba",
  mauve = "#cba6f7",
  red = "#eb6f92",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f6c177",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#31748f",
  blue = "#9ccfd8",
  test = "#e0def4",
  color0 = "#26233a",
  color1 = "#eb6f92",
  color2 = "#9ccfd8",
  color3 = "#f6c177",
  color4 = "#31748f",
  color5 = "#c4a7e7",
  color6 = "#ebbcba",
  color7 = "#e0def4",
  color8 = "#6e6a86",
  color9 = "#eb6f92",
  color10 = "#9ccfd8",
  color11 = "#f6c177",
  color12 = "#31748f",
  color13 = "#c4a7e7",
  color14 = "#ebbcba",
  color15 = "#e0def4",
  highlight_bg_color = "#191724",
  highlight_fg_color = "#e0def4",
  lavender = "#c4a7e7",
  text = "#e0def4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay = "#26233a",
  surface2 = "#585b70",
  surface1 = "#6e6a86",
  surface = "#1f1d2e",
  base = "#212337",
  mantle = "#181825",
  crust = "#11111b",
  cursor_bg = "#37f499",
  cursor_fg = "#212337",
  cursor_border = "#04d1f9",
  compose_cursor = "#f7c67f",
  foreground = "#ebfafa",
  scrollbar_thumb = "#37f499",
  selection_bg = "rgba(26.666668% 27.843138% 35.294117% 50%)",
  selection_fg = "rgba(0% 0% 0% 0%)",
  split = "#a48cf2",
}

local colorscheme = {
  foreground = main.foreground,
  background = main.base,
  cursor_bg = main.cursor_bg,
  cursor_border = main.cursor_border,
  cursor_fg = main.cursor_fg,
  selection_bg = main.selection_bg,
  selection_fg = main.selection_fg,
  ansi = {
    "#212337",
    "#f16c75",
    "#37f499",
    "#f7c67f",
    "#a48cf2",
    "#f265b5",
    "#04d1f9",
    "#ebfafa",
  },
  brights = {
    "#323449",
    "#f9515d",
    "#37f499",
    "#e9f941",
    "#9071f4",
    "#f265b5",
    "#66e4fd",
    "#FFFFFF",
  },
  tab_bar = {
    background = main.base,
    inactive_tab_edge = main.base,
    active_tab = {
      fg_color = main.cursor_bg,
      bg_color = main.base,
      intensity = "Normal",
      italic = false,
      strikethrough = false,
      underline = "None",
    },
    inactive_tab = {
      bg_color = main.base,
      fg_color = main.cursor_border,
    },

    inactive_tab_hover = {
      fg_color = main.base,
      bg_color = main.cursor_border,
      italic = false,
      strikethrough = false,
      underline = "None",
    },
    new_tab = {
      fg_color = main.base,
      bg_color = main.foreground,
      italic = false,
      intensity = "Normal",
      strikethrough = false,
      underline = "None",
    },
    new_tab_hover = {
      fg_color = main.base,
      bg_color = main.cursor_bg,
      italic = true,
      intensity = "Normal",
      strikethrough = false,
    },
  },
  visual_bell = main.surface0,
  indexed = {
    [16] = main.scrollbar_thumb,
    [17] = main.lavender,
  },
  scrollbar_thumb = main.scrollbar_thumb,
  split = main.split,
  compose_cursor = main.compose_cursor, -- nightbuild only
  copy_mode_active_highlight_bg = { Color = "#223249" },
  copy_mode_active_highlight_fg = { Color = "#DCD7BA" },
  copy_mode_inactive_highlight_bg = { Color = "#C8C093" },
  copy_mode_inactive_highlight_fg = { Color = "#16161D" },

  quick_select_label_bg = { Color = "#FF5D62" },
  quick_select_label_fg = { Color = "#DCD7BA" },
  quick_select_match_bg = { Color = "#FF9E3B" },
  quick_select_match_fg = { Color = "#DCD7BA" },
}

return colorscheme

