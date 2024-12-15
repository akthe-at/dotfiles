---Ported from: https://stephango.com/flexoki
---@module "picker.assets.colorschemes.flexoki_dark"
---@license GNU-GPLv3

---@class PickList
local M = {}

local color = require("utils").fn.color

M.scheme = {
  foreground = "#CECDC3",
  background = "#100F0F",
  cursor_bg = "#CECDC3",
  cursor_fg = "#100F0F",
  cursor_border = "#CECDC3",
  selection_bg = "#282726",
  selection_fg = "#CECDC3",
  scrollbar_thumb = "#5E409D",
  split = "#AF3029",
  ansi = {
    "#100F0F", --#Black
    "#AF3029", --# Red
    "#66800B", --# Green
    "#AD8301", --# Yellow
    "#205EA6", --# Blue
    "#5E409D", --# Purple
    "#24837B", --# Cyan
    "#CECDC3", --# White
  },
  brights = {
    "#575653", --# Black
    "#D14D41", --# Red
    "#879A39", --# Green
    "#D0A215", --# Yellow
    "#4385BE", --# Blue
    "#8B7EC8", --# Purple
    "#3AA99F", --# Cyan
    "#FFFCF0", --# White
  },
  indexed = {},
  compose_cursor = "#F7C67F",
  visual_bell = "#323449",
  copy_mode_active_highlight_bg = { Color = "#3aa99f" },
  copy_mode_active_highlight_fg = { Color = "#212337" },
  copy_mode_inactive_highlight_bg = { Color = "#212337" },
  copy_mode_inactive_highlight_fg = { Color = "#4385be" },
  quick_select_label_bg = { Color = "#F16C75" },
  quick_select_label_fg = { Color = "#EBFAFA" },
  quick_select_match_bg = { Color = "#F7C67F" },
  quick_select_match_fg = { Color = "#EBFAFA" },
  tab_bar = {
    background = "#282726",
    inactive_tab_edge = "#282726",
    active_tab = { bg_color = "#3aa99f", fg_color = "#282726", italic = false },
    inactive_tab = { bg_color = "#282726", fg_color = "#4385be", italic = false },
    inactive_tab_hover = { bg_color = "#3aa99f", fg_color = "#282726", italic = true },
    new_tab = { bg_color = "#212337", fg_color = "#EBFAFA", italic = false },
    new_tab_hover = { bg_color = "#3aa99f", fg_color = "#EBFAFA", italic = true },
  },
}

function M.get()
  return { id = "flexoki_dark", label = "Flexoki Dark" }
end

function M.activate(Config, callback_opts)
  local theme = M.scheme
  color.set_scheme(Config, theme, callback_opts.id)
end

return M
