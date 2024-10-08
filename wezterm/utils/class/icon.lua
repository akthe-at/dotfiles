---@module "utils.class.icon"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: undefined-field
local nf = require("wezterm").nerdfonts

-- {{{1 META

--~ {{{2 Icons.Sep

---Tabs bar separators
---@class Utils.Class.Icons.Sep.tb
---@field leftmost string `▐`
---@field left     string ``
---@field right    string ``
---
---Status-bar separators
---@class Utils.Class.Icons.Sep.sb
---@field left  string ``
---@field right string ``
---@field modal string ``
---
---Separators
---@class Utils.Class.Icons.Sep
---@field sb    Utils.Class.Icons.Sep.sb
---@field tb    Utils.Class.Icons.Sep.tb
---@field block string `█`

--~ }}}

--~ {{{2 Icons.Bat

---Icons for a full battery
---@class Utils.Class.Icons.Bat.Full
---@field ["100"] string `󰁹`
---
---Icons for a charging battery
---@class Utils.Class.Icons.Bat.Charging
---@field ["00"]  string `󰂃`
---@field ["10"]  string `󰢜
---@field ["20"]  string `󰂆
---@field ["30"]  string `󰂇
---@field ["40"]  string `󰂈
---@field ["50"]  string `󰢝
---@field ["60"]  string `󰂉
---@field ["70"]  string `󰢞
---@field ["80"]  string `󰂊
---@field ["90"]  string `󰂋
---@field ["100"] string `󰂅`
---
---Icons for a discharging battery
---@class Utils.Class.Icons.Bat.Discharging
---@field ["00"]  string `󰂎`
---@field ["10"]  string `󰁺`
---@field ["20"]  string `󰁻`
---@field ["30"]  string `󰁼`
---@field ["40"]  string `󰁽`
---@field ["50"]  string `󰁾`
---@field ["60"]  string `󰁿`
---@field ["70"]  string `󰂀`
---@field ["80"]  string `󰂁`
---@field ["90"]  string `󰂂`
---@field ["100"] string `󰁹`
---
---Collection of battery icons
---@class Utils.Class.Icons.Bat
---@field Full        Utils.Class.Icons.Bat.Full
---@field Charging    Utils.Class.Icons.Bat.Charging
---@field Discharging Utils.Class.Icons.Bat.Discharging

--~ }}}

--~ {{{2 Icons.Nums

---{ 󰬺, 󰬻, 󰬼, 󰬽, 󰬾, 󰬿, 󰭀, 󰭁, 󰭂, 󰿩 }
---@class Utils.Class.Icons.Nums: string[]

--~ }}}

--~ {{{2 Icons.Progs

---Indexed list of programs names and their respective icons
---@class Utils.Class.Icons.Progs: table<string: string>

--~ }}}

--~ {{{2 Utils.Class.Icons

---@class Utils.Class.Icons
---@field Sep          Utils.Class.Icons.Sep
---@field Bat          Utils.Class.Icons.Bat
---@field Nums         Utils.Class.Icons.Nums
---@field Progs        Utils.Class.Icons.Progs
---@field Notification string ``

--~ }}}

-- }}}

---@class Utils.Class.Icons
local M = {}

M.Notification = nf.cod_circle_small_filled

M.Sep = {
  block = "█",

  sb = {
    left = nf.ple_left_half_circle_thick,
    leftmost = "" .. nf.ple_left_half_circle_thick,
    rightmost = "" .. nf.ple_right_half_circle_thick,
    right = nf.ple_right_half_circle_thick,
    modal = nf.ple_forwardslash_separator,
  },

  tb = {
    dev_terminal = "" .. nf.dev_terminal,
    leftmost = "" .. nf.ple_left_half_circle_thick,
    left = nf.ple_left_half_circle_thick,
    right = nf.ple_right_half_circle_thick .. " ",
  },
}

M.Bat = {
  Full = {
    ["100"] = nf.md_battery,
  },

  Charging = {
    ["00"] = nf.md_battery_alert,
    ["10"] = nf.md_battery_charging_10,
    ["20"] = nf.md_battery_charging_20,
    ["30"] = nf.md_battery_charging_30,
    ["40"] = nf.md_battery_charging_40,
    ["50"] = nf.md_battery_charging_50,
    ["60"] = nf.md_battery_charging_60,
    ["70"] = nf.md_battery_charging_70,
    ["80"] = nf.md_battery_charging_80,
    ["90"] = nf.md_battery_charging_90,
    ["100"] = nf.md_battery_charging_100,
  },

  Discharging = {
    ["00"] = nf.md_battery_outline,
    ["10"] = nf.md_battery_10,
    ["20"] = nf.md_battery_20,
    ["30"] = nf.md_battery_30,
    ["40"] = nf.md_battery_40,
    ["50"] = nf.md_battery_50,
    ["60"] = nf.md_battery_60,
    ["70"] = nf.md_battery_70,
    ["80"] = nf.md_battery_80,
    ["90"] = nf.md_battery_90,
    ["100"] = nf.md_battery,
  },
}

M.Nums = {
  nf.md_numeric_1,
  nf.md_numeric_2,
  nf.md_numeric_3,
  nf.md_numeric_4,
  nf.md_numeric_5,
  nf.md_numeric_6,
  nf.md_numeric_7,
  nf.md_numeric_8,
  nf.md_numeric_9,
  nf.md_numeric_10,
}

M.Status = {
  folder = nf.md_folder,
  user = nf.fa_user,
  cod_server = nf.cod_server,
  cal_clock = nf.md_calendar_clock,
  charge = nf.md_lightning_bolt_circle,
  domain = nf.oct_goal,
}

M.Progs = {
  ["C:\\WINDOWS\\system32\\cmd.exe"] = nf.md_console_line,
  ["Topgrade"] = nf.md_rocket_launch,
  ["bash"] = nf.cod_terminal_bash,
  ["btm"] = nf.md_chart_donut_variant,
  ["cargo"] = nf.dev_rust,
  ["curl"] = nf.mdi_flattr,
  ["docker"] = nf.linux_docker,
  ["docker-compose"] = nf.linux_docker,
  ["fish"] = nf.md_fish,
  ["gh"] = nf.dev_github_badge,
  ["git"] = nf.dev_git,
  ["go"] = nf.seti_go,
  ["htop"] = nf.md_chart_areaspline,
  ["btop"] = nf.md_chart_areaspline,
  ["kubectl"] = nf.linux_docker,
  ["kuberlr"] = nf.linux_docker,
  ["lazydocker"] = nf.linux_docker,
  ["lua"] = nf.seti_lua,
  ["python"] = nf.seti_python,
  ["perl"] = nf.seti_perl,
  ["make"] = nf.seti_makefile,
  ["node"] = nf.md_nodejs,
  ["nvim"] = nf.custom_neovim,
  ["pacman"] = "󰮯 ",
  ["paru"] = "󰮯 ",
  ["psql"] = nf.dev_postgresql,
  ["pwsh.exe"] = nf.md_console,
  ["ruby"] = nf.cod_ruby,
  ["sudo"] = nf.fa_hashtag,
  ["vim"] = nf.dev_vim,
  ["wget"] = nf.mdi_arrow_down_box,
  ["zsh"] = nf.dev_terminal,
  ["lazygit"] = nf.cod_github,
}

return M

-- vim: fdm=marker fdl=1
