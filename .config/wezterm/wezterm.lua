local Config = require("utils.class.config"):new()

local wezterm = require "wezterm"
local resurrect = wezterm.plugin.require "https://github.com/MLFlexer/resurrect.wezterm"
wezterm.plugin.update_all()
resurrect.save_state_dir = "C:\\Users\\ARK010\\.config\\wezterm\\state\\" -- Set some directory where wezterm has write access
resurrect.periodic_save()

require("utils.backdrops"):set_files():random()
require "events.update-status"
require "events.format-tab-title"
require "events.new-tab-button-click"
require "events.augment-command-palette"
require "sessionizer"

return Config:add("config"):add "mappings"
