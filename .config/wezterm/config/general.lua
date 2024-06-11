---@class WezTerm
local wez = require "wezterm"

local icons = require "utils.icons" ---@class Icons
local fun = require "utils.fun" ---@class Fun
------@class Config
local Config = {}
if fun.is_windows() then
  Config.default_prog = { "pwsh", "-NoLogo", "-ExecutionPolicy", "RemoteSigned" } --"-NoProfileLoadTime"
  -- Config.default_prog = { "bash", "-l" }
else
  Config.default_prog = { "bash", "-l" }
end

-- Config.default_prog = { "bash", "-l" }
Config.launch_menu = {
  {
    label = icons.Pwsh .. " PowerShell V7",
    args = {
      "pwsh",
      "-NoLogo",
      "-ExecutionPolicy",
      "RemoteSigned",
    },
    cwd = "~",
  },
  {
    label = icons.Git .. " Git bash",
    args = { "C:/Users/ARK010/scoop/apps/git/current/bin/bash.exe", "-l" },
    cwd = "~",
  },
  { label = "Command Prompt", args = { "cmd.exe" }, cwd = "~" },
}

-- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
Config.wsl_domains = {}

Config.default_cwd = fun.home

-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
Config.ssh_domains = {
  {
    name = "PyA",
    remote_address = "ssh.pythonanywhere.com",
    username = "uwwssi",
    ssh_option = {
      identityfile = "~/.ssh/id_rsa.pub",
    },
    multiplexing = "None",
    default_prog = { "bash" },
    assume_shell = "Posix",
  },
}

-- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
Config.unix_domains = {}

return Config
