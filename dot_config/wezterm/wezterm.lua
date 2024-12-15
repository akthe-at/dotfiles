local Config = require("utils.class.config"):new()

require "events.update-status"
require "events.format-tab-title"
require("utils.backdrops"):set_files():random()
require "events.augment-command-palette"

return Config:add("config"):add "mappings"
