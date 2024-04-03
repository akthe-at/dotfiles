-- A slightly altered version of catppucchin mocha
local mocha = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1E1D23",
  mantle = "#181825",
  crust = "#11111b",
}

local colorscheme = {
  foreground = mocha.text,
  background = mocha.base,
  cursor_bg = mocha.rosewater,
  cursor_border = mocha.rosewater,
  cursor_fg = mocha.crust,
  selection_bg = mocha.surface2,
  selection_fg = mocha.text,
  ansi = {
    "#0C0C0C", -- black
    "#C50F1F", -- red
    "#13A10E", -- green
    "#C19C00", -- yellow
    "#7E9CD8", -- blue
    "#881798", -- magenta/purple
    "#3A96DD", -- cyan
    "#CCCCCC", -- white
  },
  brights = {
    "#767676", -- black
    "#E74856", -- red
    "#16C60C", -- green
    "#F9F1A5", -- yellow
    "#3B78FF", -- blue
    "#B4009E", -- magenta/purple
    "#61D6D6", -- cyan
    "#F2F2F2", -- white
  },
  tab_bar = {
    background = "#000000",
    active_tab = {
      bg_color = mocha.flamingo,
      fg_color = mocha.text,
    },
    inactive_tab = {
      bg_color = "#727169",
      fg_color = "#181820",
    },

    inactive_tab_hover = {
      bg_color = "#223249",
      fg_color = "#727169",
      italic = true,
    },
    new_tab = {
      bg_color = "#727169",
      fg_color = "#000000",
    },
    new_tab_hover = {
      bg_color = "#9CABCA",
      fg_color = "#000000",
      italic = true,
    },
  },
  visual_bell = mocha.surface0,
  indexed = {
    [16] = mocha.peach,
    [17] = mocha.rosewater,
  },
  scrollbar_thumb = mocha.surface2,
  split = mocha.overlay0,
  compose_cursor = mocha.flamingo, -- nightbuild only
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

