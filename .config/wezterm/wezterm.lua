require("utils.backdrops"):set_files()
-- :random()
require "events.update-status"
require "events.format-tab-title"
require "events.new-tab-button-click"
require "events.lock-interface"
require "launch"
require "sessionizer"
require "wezterm-session-manager/session-manager"
return require("utils.config"):new():add("config"):add "mappings"
