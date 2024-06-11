---@class WezTerm
local wez = require "wezterm"
local fontselector = require "fontselector"
---@class Config
local Config = {}

Config.adjust_window_size_when_changing_font_size = false
Config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
Config.anti_alias_custom_block_glyphs = true
-- Config.font_size = 12
Config.cell_width = 0.9
Config.warn_about_missing_glyphs = false
Config.use_resize_increments = false

fontselector.register_fonts {
  { name = "Maple Mono", mod = "font-maple" },
  { name = "JetBrainsMono Nerd Font", mod = "font-jetbrains" },
  { name = "ComicShannsMono Nerd Font", mod = "font-commicshanns" },
  { name = "Hack Nerd Font", mod = "font-hack" },
  { name = "Pragmasevka Nerd Font", mod = "font-pragmasevka" },
  { name = "Monaspace Neon", mod = "font-monaspace-neon" },
  { name = "Monaspace Argon", mod = "font-monaspace-argon" },
  { name = "Monaspace Krypton Var", mod = "font-monaspace-krypton" },
  { name = "Monaspace Radon", mod = "font-monaspace-radon" },
  { name = "Monaspace Xenon", mod = "font-monaspace-xenon" },
  { name = "UbuntuMono Nerd Font", mod = "font-ubuntu" },
  { name = "CommitMonoAK", mod = "font-commitmonoak" },
  { name = "CaskaydiaCove Nerd Font", mod = "font-caskaydiacove" },
  { name = "Victor Mono", mod = "font-victor" },
  { name = "FiraCode Nerd Font", mod = "font-firacode" },
  { name = "DroidSansM Nerd Font", mod = "font-droidsans" },
  { name = "D2CodingLigature Nerd Font", mod = "font-d2coding" },
  { name = "Cascadia Code PL", mod = "font-cascadiaPL" },
  { name = "Cascadia Code Mono NF", mod = "font-cascadiaNF" },
}

Config.font = wez.font_with_fallback {
  {
    -- family = "ComicShannsMono Nerd Font",
    -- family = "Hack Nerd Font",
    -- family = "JetBrainsMono Nerd Font",
    -- family = "CommitMonoAK",
    -- family = "Maple Mono",
    family = "Cascadia Mono NF",
    -- family = "D2CodingLigature Nerd Font",
    weight = "Regular",
    harfbuzz_features = {
      -- "cv01", ---styles: a
      -- "cv02", ---styles: g
      "cv06", ---styles: i (03..06)
      -- "cv09", ---styles: l (07..10)
      "cv12", ---styles: 0 (11..13, zero)
      "cv14", ---styles: 3
      "cv16", ---styles: * (15..16)
      -- "cv17", ---styles: ~
      -- "cv18", ---styles: %
      -- "cv19", ---styles: <= (19..20
      -- "cv21", ---styles: =< (21..22)
      -- "cv23", ---styles: >=
      -- "cv24", ---styles: /=
      "cv25", ---styles: .-
      "cv26", ---styles: :-
      -- "cv27", ---styles: []
      "cv28", ---styles: {. .}
      "cv29", ---styles: { }
      -- "cv30", ---styles: |
      "cv31", ---styles: ()
      "cv32", ---styles: .=
      -- "ss01", ---styles: r
      -- "ss02", ---styles: <= >=
      "ss03", ---styles: &
      "ss04", ---styles: $
      "ss05", ---styles: @
      -- "ss06", ---styles: \\
      "ss07", ---styles: =~ !~
      -- "ss08", ---styles: == === != !==
      "ss09", ---styles: >>= <<= ||= |=
      -- "ss10", ---styles: Fl Tl fi fj fl ft
      -- "onum", ---styles: 1234567890
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
        stretch = "Expanded",
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
        scale = 1.1,
      },
      { family = "Symbols Nerd Font" },
    },
  },
}

return Config
