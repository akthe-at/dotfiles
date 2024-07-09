---@class Wezterm
local wez = require "wezterm"
local fontselector = require "fontselector"
---@class Config
local Config = {}

Config.adjust_window_size_when_changing_font_size = true
Config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
Config.anti_alias_custom_block_glyphs = true
Config.font_size = 14
Config.line_height = 1.0
-- Config.Config.cell_width = 0.9
Config.warn_about_missing_glyphs = false
Config.use_resize_increments = false

fontselector.register_fonts {
  { name = "Maple Mono", mod = "fonts.font-maple" },
  { name = "JetBrainsMono Nerd Font", mod = "fonts.font-jetbrains" },
  { name = "ComicShannsMono Nerd Font", mod = "fonts.font-commicshanns" },
  { name = "Hack Nerd Font", mod = "fonts.font-hack" },
  { name = "Pragmasevka Nerd Font", mod = "fonts.font-pragmasevka" },
  { name = "Monaspace Neon", mod = "fonts.font-monaspace-neon" },
  { name = "Monaspace Argon", mod = "fonts.font-monaspace-argon" },
  { name = "Monaspace Krypton Var", mod = "fonts.font-monaspace-krypton" },
  { name = "Monaspace Radon", mod = "fonts.font-monaspace-radon" },
  { name = "Monaspace Xenon", mod = "fonts.font-monaspace-xenon" },
  { name = "UbuntuMono Nerd Font", mod = "fonts.font-ubuntu" },
  { name = "CommitMonoAK", mod = "fonts.font-commitmonoak" },
  { name = "CaskaydiaCove Nerd Font", mod = "fonts.font-caskaydiacove" },
  { name = "Victor Mono", mod = "fonts.font-victor" },
  { name = "FiraCode Nerd Font", mod = "fonts.font-firacode" },
  { name = "DroidSansM Nerd Font", mod = "fonts.font-droidsans" },
  { name = "D2CodingLigature Nerd Font", mod = "fonts.font-d2coding" },
  { name = "Cascadia Code PL", mod = "fonts.font-cascadiaPL" },
  { name = "Cascadia Code Mono NF", mod = "fonts.font-cascadiaNF" },
}

Config.font = wez.font_with_fallback {
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
    font = wez.font_with_fallback {
      {
        family = "Monaspace Radon", --"Monaspace Radon Var",
        -- family = "CommitMonoAK", --"Monaspace Krypton Var",
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
    font = wez.font_with_fallback {
      {
        family = "Monaspace Krypton Var", --"Monaspace Krypton Var",
        -- family = "CommitMonoAK", --"Monaspace Krypton Var",
        style = "Italic",
        weight = "Black",
        harfbuzz_features = monaspace_features,
        scale = 1.3,
      },
      { family = "Symbols Nerd Font" },
    },
  },
}

return Config
