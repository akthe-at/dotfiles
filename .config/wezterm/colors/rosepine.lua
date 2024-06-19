local main = {
  rosewater = "#ebbcba",
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
  foam = "#9ccfd8",
  test = "#e0def4",
  color0 = "#26233a",
  color1 = "#eb6f92",
  color2 = "#3e8fb0",
  color3 = "#f6c177",
  color4 = "#31748f",
  color5 = "#c4a7e7",
  color6 = "#ebbcba",
  color7 = "#e0def4",
  color8 = "#6e6a86",
  color9 = "#ea9a97",
  color10 = "#9ccfd8",
  color12 = "#31748f",
  color13 = "#c4a7e7",
  color14 = "#ebbcba",
  color15 = "#e0def4",
  highlight_bg_color = "#191724",
  highlight_fg_color = "#e0def4",
  lavender = "#c4a7e7", --(iris)
  text = "#e0def4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay = "#26233a",
  surface2 = "#585b70",
  surface1 = "#6e6a86",
  surface = "#1f1d2e",
  base = "#21202e",
  mantle = "#181825",
  crust = "#11111b",
}

local colorscheme = {
  foreground = main.text,
  background = main.base,
  cursor_bg = main.rosewater,
  cursor_border = main.maroon,
  cursor_fg = main.crust,
  selection_bg = main.color3,
  selection_fg = "rgba(0% 0% 0% 0%)",
  ansi = {
    "#0C0C0C", --
    "#C50F1F", --
    "#13A10E", --
    "#c4a7e7", --
    main.sapphire, --
    "#881798", --
    "#3A96DD", --
    "#CCCCCC", --
  },
  brights = {
    "#bac2de", --
    "#E74856", --
    "#16C60C", --
    "#F9F1A5", --
    "#9ccfd8", --
    "#B4009E", --
    "#61D6D6", --
    "#F2F2F2", --
  },
  tab_bar = {
    background = main.base,
    inactive_tab_edge = main.base,
    active_tab = {
      bg_color = main.crust,
      fg_color = main.color2,
    },
    inactive_tab = {
      bg_color = main.base,
      fg_color = main.color9,
    },

    inactive_tab_hover = {
      bg_color = main.base,
      fg_color = main.base,
      italic = false,
    },
    new_tab = {
      bg_color = main.color1,
      fg_color = main.base,
    },
    new_tab_hover = {
      bg_color = main.rosewater,
      fg_color = main.base,
      italic = true,
      strikethrough = false,
    },
  },
  visual_bell = main.surface0,
  indexed = {
    [16] = main.peach,
    [17] = main.rosewater,
  },
  scrollbar_thumb = main.surface2,
  split = main.surface2,
  compose_cursor = main.flamingo, -- nightbuild only
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
