---@class PickList
local M = {}

local Utils = require "utils"
local color = Utils.fn.color

M.scheme = {
  ansi = {
    "#bcc0cc",
    "#d20f39",
    "#40a02b",
    "#df8e1d",
    "#1e66f5",
    "#ea76cb",
    "#179299",
    "#5c5f77",
  },
  background = "#eff1f5",
  brights = {
    "#acb0be",
    "#d20f39",
    "#40a02b",
    "#df8e1d",
    "#1e66f5",
    "#ea76cb",
    "#179299",
    "#6c6f85",
  },
  compose_cursor = "#dd7878",
  cursor_bg = "#dc8a78",
  cursor_border = "#dc8a78",
  cursor_fg = "#dce0e8",
  foreground = "#4c4f69",
  scrollbar_thumb = "#acb0be",
  selection_bg = "#acb0be",
  selection_fg = "#4c4f69",
  split = "#9ca0b0",
  visual_bell = "#ccd0da",

  indexed = {
    [16] = "#fe640b",
    [17] = "#dc8a78",
  },

  tab_bar = {
    background = "#dce0e8",
    inactive_tab_edge = "#ccd0da",

    active_tab = {
      bg_color = "#8839ef",
      fg_color = "#dce0e8",
      intensity = "Normal",
      italic = false,
      strikethrough = false,
      underline = "None",
    },

    inactive_tab = {
      bg_color = "#e6e9ef",
      fg_color = "#4c4f69",
      intensity = "Normal",
      italic = false,
      strikethrough = false,
      underline = "None",
    },

    inactive_tab_hover = {
      bg_color = "#eff1f5",
      fg_color = "#4c4f69",
      intensity = "Normal",
      italic = false,
      strikethrough = false,
      underline = "None",
    },

    new_tab = {
      bg_color = "#ccd0da",
      fg_color = "#4c4f69",
      intensity = "Normal",
      italic = false,
      strikethrough = false,
      underline = "None",
    },

    new_tab_hover = {
      bg_color = "#bcc0cc",
      fg_color = "#4c4f69",
      intensity = "Normal",
      italic = false,
      strikethrough = false,
      underline = "None",
    },
  },
}

function M.get()
  return { id = "catppuccin-latte", label = "Catppuccin Latte" }
end

function M.activate(Config, callback_opts)
  local theme = M.scheme
  color.set_scheme(Config, theme, callback_opts.id)
end

return M
