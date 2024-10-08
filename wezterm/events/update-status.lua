---@module "events.update-status"
---@author sravioli
---@license GNU-GPLv3

local wt = require "wezterm"

local Utils = require "utils"
local Icon = Utils.class.icon
local StatusBar = Utils.class.layout
local fs, mt, str = Utils.fn.fs, Utils.fn.mt, Utils.fn.str

---@diagnostic disable-next-line: undefined-field
local wt_format, strftime = wt.format, wt.strftime
local strwidth = fs.platform().is_win and string.len or str.strwidth

-- luacheck: push ignore 561
---@diagnostic disable-next-line: undefined-field
wt.on("update-status", function(window, pane)
  local Config = window:effective_config()
  local Overrides = window:get_config_overrides() or {}
  local theme = Config.color_schemes[Overrides.color_scheme or Config.color_scheme]
  local stat_bg = theme.ansi[1]
  local sep_right = Icon.Sep.sb.right
  local sep_left = Icon.Sep.sb.left
  local stat_ico = Icon.Status

  local modes = {
    search_mode = { i = "󰍉", txt = "SEARCH", bg = theme.brights[4], pad = 10 },
    window_mode = { i = "󱂬", txt = "WINDOW", bg = theme.ansi[6], pad = 8 },
    copy_mode = { i = "󰆏", txt = "COPY", bg = theme.brights[3], pad = 8 },
    font_mode = { i = "󰛖", txt = "FONT", bg = theme.ansi[7], pad = 7 },
    help_mode = { i = "󰞋", txt = "NORMAL", bg = theme.ansi[5], pad = 9 },
    pick_mode = { i = "󰢷", txt = "PICK", bg = theme.ansi[2], pad = 9 },
  }
  -- local bg = theme.ansi[5]
  local bg = theme.tab_bar.background
  local mode_indicator_width = 0

  -- {{{1 LEFT STATU
  local LeftStatus = StatusBar:new "LeftStatus"
  local name = window:active_key_table()
  if name and modes[name] then
    local txt, ico = modes[name].txt or "", modes[name].i or ""
    mode_indicator_width, bg = strwidth(txt) + 2 + strwidth(ico), modes[name].bg
    LeftStatus:push(bg, theme.background, str.pad(ico .. " " .. txt, 1), { "Bold" })
  end

  LeftStatus:push(bg, theme.brights[3], sep_left)
  LeftStatus:push(theme.brights[3], theme.ansi[1], stat_ico.domain .. " ")
  LeftStatus:push(stat_bg, theme.foreground, " " .. pane:get_domain_name())
  LeftStatus:push(bg, stat_bg, sep_right .. " ")
  window:set_left_status(LeftStatus:format())
  -- }}}

  -- {{{1 RIGHT STATUS
  local RightStatus = StatusBar:new "RightStatus"

  --~~ {{{2 Calculate the used width by the @tabs
  local MuxWindow = window:mux_window()
  local tab_bar_width = 5
  for i = 1, #MuxWindow:tabs() do
    local MuxPane = MuxWindow:tabs()[i]:panes()[1]
    local tab_title = MuxPane:get_title()

    local process, other = tab_title:match "^(%S+)%s*%-?%s*%s*(.*)$"
    tab_title = tab_title:gsub("^Copy mode: ", "")
    if Icon.Progs[process] then
      tab_title = Icon.Progs[process] .. " " .. (other or "")
    end

    local proc = MuxPane:get_foreground_process_name()
    if proc and proc:find "nvim" then
      proc = proc:sub(proc:find "nvim")
    end
    if proc == "nvim" then
      local cwd = fs.basename(MuxPane:get_current_working_dir().file_path)
      tab_title = ("%s ( %s)"):format(Icon.Progs[proc], cwd)
    end
    tab_title = tab_title:gsub(fs.basename(fs.home()), "󰋜 ")

    tab_bar_width = tab_bar_width + strwidth(tab_title) + 3
  end

  local new_tab_button = Config.show_new_tab_button_in_tab_bar and 8 or 0
  tab_bar_width = tab_bar_width + mode_indicator_width + new_tab_button
  --~~ }}}

  local usable_width = pane:get_dimensions().cols - tab_bar_width - 2

  --~ {{{2 MODAL PROMPTS
  if name and modes[name] then
    local mode = modes[name]
    local prompt_bg, map_fg, txt_fg = theme.tab_bar.background, mode.bg, theme.foreground
    local sep = Icon.Sep.sb.modal

    local key_tbl = require("mappings.modes")[2][name]
    for idx = 1, #key_tbl do
      local map_tbl = key_tbl[idx]
      local map, desc = map_tbl[1], map_tbl[3]
      if map:find "%b<>" then
        map = map:gsub("(%b<>)", function(s)
          return s:sub(2, -2)
        end)
      end

      local prompt_len = strwidth(map .. desc) + mode.pad
      if usable_width > 0 and desc ~= "" then
        RightStatus:push(prompt_bg, txt_fg, "<", { "Bold" })
        RightStatus:push(prompt_bg, map_fg, map)
        RightStatus:push(prompt_bg, txt_fg, ">")
        RightStatus:push(prompt_bg, txt_fg, str.pad(desc), { "Normal", "Italic" })

        ---add separator only if it's not the last item and there's enough space
        local next_prompt = key_tbl[idx]
        local next_prompt_len = strwidth(next_prompt[1] .. next_prompt[3]) + 4
        if idx < #key_tbl and usable_width - next_prompt_len > 0 then
          RightStatus:push(prompt_bg, theme.brights[1], sep .. " ", { "NoItalic" })
        end
      end

      usable_width = usable_width - prompt_len
    end

    window:set_right_status(wt_format(RightStatus))
    return ---return early to not render status bar
  end --~ }}}

  --~ {{{2 STATUS BAR

  local battery = wt.battery_info()[1]
  battery.charge = battery.state_of_charge * 100
  battery.lvl_round = mt.toint(mt.mround(battery.charge, 10))
  battery.ico = Icon.Bat[battery.state][tostring(battery.lvl_round)]
  wt.log_info(battery.state, battery.lvl_round)
  battery.lvl = tonumber(math.floor(battery.charge + 0.5))
  battery.full = ("%s %i%%"):format(battery.ico, battery.lvl)

  local cwd, _ = fs.get_cwd_hostname(pane, true) -- current hostname turned to _ because unused.
  local workspace_name = window:active_workspace()

  ---add each cell separator
  RightStatus:push(bg, theme.brights[7], sep_left)
  RightStatus:push(theme.brights[7], theme.ansi[1], stat_ico.folder .. " ")
  RightStatus:push(stat_bg, theme.foreground, " " .. cwd, { "Bold" })
  RightStatus:push(bg, stat_bg, sep_right .. " ")
  ---
  RightStatus:push(bg, theme.brights[6], sep_left)
  RightStatus:push(theme.brights[6], theme.ansi[1], stat_ico.cod_server .. " ")
  RightStatus:push(
    stat_bg,
    theme.foreground,
    " " .. fs.basename(workspace_name),
    { "Bold" }
  )
  RightStatus:push(bg, stat_bg, sep_right .. " ")
  ---
  RightStatus:push(bg, theme.brights[4], sep_left)
  RightStatus:push(theme.brights[4], theme.ansi[1], stat_ico.cal_clock .. " ")
  RightStatus:push(bg, theme.brights[7], "")
  RightStatus:push(
    theme.ansi[1],
    theme.foreground,
    ---@diagnostic disable-next-line: undefined-field
    " " .. wt.strftime "%a %b %-d %H:%M",
    { "Bold" }
  )
  RightStatus:push(bg, stat_bg, sep_right .. " ")
  ---
  RightStatus:push(bg, theme.brights[5], sep_left)
  RightStatus:push(theme.brights[5], theme.ansi[1], stat_ico.charge .. " ")
  RightStatus:push(
    stat_bg,
    theme.foreground,
    " " .. battery.lvl .. "%" .. " " .. battery.ico,
    { "Bold" }
  )
  RightStatus:push(bg, stat_bg, sep_right .. " ")

  window:set_right_status(RightStatus:format())
  -- ~ }}}
  -- }}}
end)

-- luacheck: pop

-- vim: fdm=marker fdl=1
