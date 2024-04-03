local wezterm = require "wezterm"

-- local M = {}

return {
  is_win = string.find(wezterm.target_triple, "windows") ~= nil,
  is_linux = string.find(wezterm.target_triple, "linux") ~= nil,
  is_mac = string.find(wezterm.target_triple, "apple") ~= nil,
}

