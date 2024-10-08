local Config = require("utils.class.config"):new()
local wezterm = require "wezterm"
wezterm.plugin.update_all()
require "events.update-status"
require "events.format-tab-title"
-- require "events.new-tab-button-click"
require("utils.backdrops"):set_files():random()
require "events.augment-command-palette"

return Config:add("config"):add "mappings"
