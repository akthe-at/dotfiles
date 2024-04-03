local main = {
  darklilac = "#6D5978",
  lilac = "#bd93f9", --"#BAA0E8",
  mauve = "#cba6f7",
  red = "#eb6f92",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f6c177",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#31748f",
  blue = "#000000",
  lavender = "#c4a7e7",
  text = "#e0def4",
  black = "#000000",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay = "#26233a",
  surface2 = "#9D5778",
  surface1 = "#6e6a86",
  surface = "#1f1d2e",
  base = "#0E1419",
  mantle = "#181825",
  crust = "#11111b",
  dracula_background = "#282a36",
  dracula_foreground = "#f8f8f2",
  dracula_cursor_bg = "#f8f8f2",
  dracula_cursor_fg = "#282a36",
  dracula_cursor_border = "#f8f8f2",
  split = "#50FA7b",
}

local colorscheme = {
  foreground = main.dracula_foreground,
  background = main.dracula_background,
  cursor_bg = main.dracula_cursor_bg,
  cursor_border = main.dracula_cursor_border,
  cursor_fg = main.dracula_cursor_fg,
  selection_bg = "rgba(26.666668% 27.843138% 35.294117% 50%)",
  selection_fg = "rgba(0% 0% 0% 0%)",
  ansi = {
    "#21222C",
    "#FF5555",
    "#50FA7B",
    "#F1FA8C",
    "#BD93F9",
    "#FF79C6",
    "#8BE9FD",
    "#F8F8F2",
  },
  brights = {
    "#6272A4",
    "#FF6E6E",
    "#69FF94",
    "#FFFFA5",
    "#D6ACFF",
    "#FF92DF",
    "#A4FFFF",
    "#FFFFFF",
  },
  tab_bar = {
    background = main.base,
    inactive_tab_edge = main.base,
    active_tab = {
      fg_color = main.lilac,
      bg_color = main.base,
    },

    inactive_tab = {
      bg_color = main.base,
      fg_color = main.dracula_foreground,
      italic = true,
      strikethrough = false,
      underline = "None",
    },

    inactive_tab_hover = {
      bg_color = main.dracula_cursor_border,
      fg_color = main.base,
      italic = false,
      strikethrough = false,
    },

    new_tab = {
      bg_color = main.lilac,
      fg_color = main.base,
    },

    new_tab_hover = {
      bg_color = main.surface2,
      fg_color = main.base,
      italic = false,
    },
  },
  visual_bell = main.surface0,
  indexed = {
    [16] = main.yellow,
    [17] = main.lilac,
  },
  scrollbar_thumb = main.surface2,
  split = main.split,
  compose_cursor = main.yellow, -- nightbuild only
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

