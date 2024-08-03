---@diagnostic disable: undefined-field

local wezterm = require "wezterm"

local Config = {}

Config.adjust_window_size_when_changing_font_size = true
Config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
Config.anti_alias_custom_block_glyphs = true
Config.font_size = 14
Config.line_height = 1.0
Config.warn_about_missing_glyphs = false
Config.use_resize_increments = false

Config.font = wezterm.font_with_fallback {
  {
    family = "Cascadia Mono NF",
    weight = "Regular",
    harfbuzz_features = {
      "calt",
      "ss01",
    },
  },
  { family = "Noto Color Emoji" },
  { family = "LegacyComputing" },
}

local monaspace_features =
  { "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" }

Config.font_rules = {
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font_with_fallback {
      {
        family = "Monaspace Radon",
        style = "Normal",
        weight = "Regular",
        stretch = "Normal",
        harfbuzz_features = monaspace_features,
      },
      { family = "Symbols Nerd Font" },
    },
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font_with_fallback {
      {
        -- family = "Monaspace Krypton Var", --"Monaspace Krypton Var",
        family = "Cascadia Mono NF", --"Monaspace Radon Var",
        style = "Italic",
        weight = "DemiBold",
        harfbuzz_features = monaspace_features,
        scale = 1.1,
      },
      { family = "Symbols Nerd Font" },
    },
  },
}

return Config
