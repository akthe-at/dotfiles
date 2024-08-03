local wt = require "wezterm"
local act = wt.action
local fun = require "utils.fn"
local M = {}

-- --- Converts Windows backslash to forwardslash
-- ---@param path string
-- local function normalize_path(path)
--   return fun.fs.platform().is_win and path:gsub("\\", "/") or path
-- end

local home = os.getenv "HOME" .. "/"

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
  file_exists(home .. "/scoop/apps/fd/current/fd.exe")
  or file_exists(home .. "/bin/fd")
  or file_exists "usr/bin/fd"
  or file_exists(home .. "/bin/fd.exe")
)

err_if_not(fd, "fd not found")

local git = (
  file_exists(home .. "/scoop/apps/git/current/bin/git.exe")
  or file_exists "/usr/bin/git"
)
err_if_not(git, "git not found")

local mydocs = home .. "\\Documents"
local dem = home .. "\\DEM"
local plugins = home .. "\\.plugins"
local config = home .. "\\.config"
-- Add More ?,
-------------------------------------------------------

--- Merge numeric tables
---@param t1 table
---@param t2 table
---@return table
local function merge_tables(t1, t2)
  local result = {}
  for index, value in ipairs(t1) do
    result[index] = value
  end
  for index, value in ipairs(t2) do
    result[#t1 + index] = value
  end
  return result
end

M.start = function(window, pane)
  local projects = {}
  local success, stdout, stderr = wt.run_child_process {
    fd,
    "-HI",
    ".git$",
    "--max-depth=4",
    "--prune",
    mydocs,
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
    project = project:gsub("/$", ""):gsub("\\$", "")
    local label = project:gsub(home, "")

    -- extract id. Used for workspace name
    local _, _, id = string.find(project, ".*/(.+)")
    id = id:gsub(".git", "") -- bare repo dirs typically end in .git, remove if so.

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
            act.SwitchToWorkspace { name = pretty_id, spawn = { cwd = home .. label } },
            pane
          )
          for _, mux_win in ipairs(wt.mux.all_windows()) do
            if mux_win:get_workspace() == pretty_id then
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
