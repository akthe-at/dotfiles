local wezterm = require "wezterm"
local M = {
  fonts = {},
}

function M.register_fonts(opts)
  for _, v in ipairs(opts or {}) do
    local name = v.name or v.mod
    M.fonts[name] = v
  end
end

function M.select(config, name)
  local font = M.fonts[name]
  require(font.mod)(config, font.opts)
end

function M.selector_action()
  return wezterm.action_callback(function(window, pane)
    local choices = {}
    for k, _ in pairs(M.fonts) do
      table.insert(choices, { label = k })
    end
    table.sort(choices, function(a, b)
      return a.label < b.label
    end)

    window:perform_action(
      wezterm.action.InputSelector {
        action = wezterm.action_callback(function(window, pane, id, label)
          local overrides = window:get_config_overrides() or {}
          M.select(overrides, label)
          window:set_config_overrides(overrides)
        end),
        title = "Font Selector",
        choices = choices,
        fuzzy = true,
      },
      pane
    )
  end)
end

return M
