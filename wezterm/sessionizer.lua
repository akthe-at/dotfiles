local wt = require "wezterm"
local act = wt.action
local fun = require "utils.fn"
local M = {}

local home = "//wsl.localhost/Ubuntu-24.04/home/aktheat/"

--- If name nil or false print err_message
---@param name string|boolean|nil
---@param err_message string
local function err_if_not(name, err_message)
  if not name then
    wt.log_error(err_message)
  end
end
--
--- path if file or directory exists nil otherwise
---@param path string
local function file_exists(path)
  if path == nil then
    return nil
  end
  local f = io.open(path, "r")
  -- io.open won't work to check if directories exist,
  -- but works for symlinks and regular files
  if f ~= nil then
    wt.log_info(path .. " file or symlink found")
    io.close(f)
    return path
  end
  return nil
end

-------------------------------------------------------
-- PATHS
--
local fd = (
  file_exists "C:\\Users\\aktheat\\scoop\\shims\\fd.exe"
  or file_exists(home .. "/usr/bin/fd")
  or file_exists "usr/bin/fdfind"
  or file_exists "usr/bin/fdfind.exe"
  or file_exists(home .. "/bin/fd.exe")
)

err_if_not(fd, "fd not found")

local git = (
  file_exists "C:\\Program Files\\Git\\cmd\\git.exe" or file_exists "/usr/bin/git"
)
err_if_not(git, "git not found")

-- local mydocs = home .. "\\Documents"
local dem = home .. "/work/DEM/"
local plugins = home .. "/projects/"
local config = "C:/Users/aktheat/.config"
-- Add More ?,
-------------------------------------------------------

M.start = function(window, pane)
  local projects = {}
  local success, stdout, stderr = wt.run_child_process {
    fd,
    "-HI",
    ".git$",
    "--max-depth=4",
    "--prune",
    -- mydocs,
    dem,
    plugins,
    config,
  }

  if not success then
    wt.log_error("Failed to run fd: " .. stderr)
    return
  end

  for line in stdout:gmatch "([^\n]*)\n?" do
    -- create label from file path
    local project = line:gsub("/.git.*", ""):gsub("\\.git.*", "")
    project = project:gsub("/$", ""):gsub("\\$", ""):gsub("\\", "/")
    local label = project:gsub("//wsl%.localhost/Ubuntu%-24%.04/home/aktheat/", "~")
    wt.log_info("Found project: " .. label)

    -- extract id. Used for workspace name
    local _, _, id = string.find(project, ".*/(.+)")
    id = id:gsub(".git", "") -- bare repo dirs typically end in .git, remove if so.

    wt.log_info("FOUND ID PROJECT: " .. id)
    table.insert(projects, { label = tostring(label), id = tostring(id) })
  end

  window:perform_action(
    act.InputSelector {
      action = wt.action_callback(function(win, pane, id, label)
        if not id and not label then
          wt.log_info "Cancelled"
        else
          wt.log_info("Selected " .. label)
          local pretty_id = id:match ".*\\(.*)" -- This line is added
          wt.emit("workspace_switcher.selected", window, id, label)

          win:perform_action(
            act.SwitchToWorkspace { name = id, spawn = { cwd = label } },
            pane
          )
          for _, mux_win in ipairs(wt.mux.all_windows()) do
            if mux_win:get_workspace() == id then
              wt.emit("workspace_switcher.switched", mux_win, id, label)
            end
          end
        end
      end),
      fuzzy = true,
      title = "Select project",
      choices = projects,
    },
    pane
  )
end

return M
