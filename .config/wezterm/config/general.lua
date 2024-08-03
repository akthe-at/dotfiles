local Icons = require "utils.class.icon"
local fs = require("utils.fn").fs
local env = require("utils.fn").load_env()

------@class Config
local Config = {}
if fs.platform().is_win then
  Config.default_prog = { "pwsh", "-NoLogo", "-ExecutionPolicy", "RemoteSigned" } --"-NoProfileLoadTime"
  -- Config.default_prog = { "bash", "-l" }
else
  Config.default_prog = { "bash", "-l" }
end

-- Config.default_prog = { "bash", "-l" }
Config.launch_menu = {
  {
    label = Icons.Progs["pwsh.exe"] .. " PowerShell V7",
    args = {
      "pwsh",
      "-NoLogo",
      "-ExecutionPolicy",
      "RemoteSigned",
    },
    cwd = "~",
  },
  {
    label = Icons.Progs["git"] .. " Git bash",
    args = { "bash", "-l" },
    cwd = "~",
  },
  { label = "Command Prompt", args = { "cmd.exe" }, cwd = "~" },
}

-- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
Config.wsl_domains = {}

Config.default_cwd = fs.home()

-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
-- TODO: replacing all my hard-coded paths with a local .env file that is read in would probably much better to make my config more interchangable between personal/work compueter
Config.ssh_domains = {
  {
    name = "PyA",
    remote_address = env["remote_address"],
    username = env["username"],
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
