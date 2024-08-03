---@module "events.augment-command-palette"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable: undefined-field

local wt = require "wezterm"
local act = wt.action
local sessionizer = require "sessionizer"

wt.on("augment-command-palette", function(_, _)
  local resurrect = wt.plugin.require "https://github.com/MLFlexer/resurrect.wezterm"
  resurrect.save_state_dir = "C:\\Users\\ARK010\\.config\\wezterm\\state\\" -- Set some directory where wezterm has write access
  local workspace_state = resurrect.workspace_state
  return {
    {
      brief = "Rename tab",
      icon = "md_rename_box",

      action = act.PromptInputLine {
        description = "Enter new name for tab",
        action = wt.action_callback(function(inner_window, _, line)
          if line then
            inner_window:active_tab():set_title(line)
          end
        end),
      },
    },
    {
      brief = "Colorscheme picker",
      icon = "md_palette",
      action = require("picker.colorscheme"):pick(),
    },
    {
      brief = "Font picker",
      icon = "md_format_font",
      action = require("picker.font"):pick(),
    },
    {
      brief = "Font size picker",
      icon = "md_format_font_size_decrease",
      action = require("picker.font-size"):pick(),
    },
    {
      brief = "Font leading picker",
      icon = "fa_text_height",
      action = require("picker.font-leadings"):pick(),
    },
    {
      brief = "Window | Workspace: Rez-Switch Workspace",
      icon = "md_briefcase_arrow_up_down",
      action = wt.action_callback(sessionizer.start),
    },
    {
      brief = "Window | Workspace: Rez-Rename Workspace",
      icon = "md_briefcase_edit",
      action = wt.action.PromptInputLine {
        description = "Enter new name for workspace",
        action = wt.action_callback(function(window, pane, line)
          if line then
            wt.mux.rename_workspace(wt.mux.get_active_workspace(), line)
            resurrect.save_state(workspace_state.get_workspace_state())
          end
        end),
      },
    },
  }
end)
