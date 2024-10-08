-- ---@module "events.format-tab-title"
-- ---@author sravioli
-- ---@license GNU-GPLv3
--
-- ---@diagnostic disable: undefined-field
--
local wt = require "wezterm"

local Utils = require "utils"

local str = Utils.fn.str
local Icon = Utils.class.icon
local tabicons = Icon.Sep.tb

wt.on("format-tab-title", function(tab, _, _, config, hover, max_width)
  if config.use_fancy_tab_bar or not config.enable_tab_bar then
    return
  end

  local theme = config.color_schemes[config.color_scheme]
  local bg = theme.tab_bar.background
  local fg
  local tab_circle_right
  local tab_font
  local index_font = theme.brights[8]
  local tab_fg = theme.ansi[1]

  local Title = Utils.class.layout:new "TabTitle"

  local tab_idx = tab.tab_index + 1
  local attributes = {}

  ---set colors based on states
  if tab.is_active then
    fg = tab_fg
    tab_circle_right = theme.brights[2]
    tab_font = theme.brights[2]
    index_font = theme.brights[8]
    attributes = { "Bold" }
  elseif hover then
    fg = theme.brights[1]
    tab_circle_right = theme.brights[7]
    tab_font = theme.foreground
    index_font = bg
    tab_fg = theme.brights[1]
  else
    fg = theme.tab_bar.inactive_tab.fg_color
    tab_circle_right = theme.brights[7]
    tab_font = theme.foreground
    index_font = bg
  end

  ---Check if any pane has unseen output
  local unseen_output = false
  for _, p in ipairs(tab.panes) do
    if p.has_unseen_output then
      unseen_output = true
      break
    end
  end

  local title = str.format_tab_title(tab, config, max_width)

  Title:push(bg, tab_fg, tabicons.left, attributes)
  Title:push(bg, fg, "", attributes)
  Title:push(tab_fg, bg, (unseen_output and Icon.Notification .. " " or ""), attributes)

  ---the formatted tab title
  Title:push(tab_fg, tab_font, title .. " ", attributes)
  Title:push(tab_circle_right, index_font, " " .. tostring(tab_idx), attributes)

  -- ---the right tab bar separator
  Title:push(bg, tab_circle_right, tabicons.right, attributes)

  return Title
end)
