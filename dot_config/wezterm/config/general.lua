local Icons = require "utils.class.icon"
local wezterm = require "wezterm"
local Config = {}
Config.debug_key_events = false
Config.ssh_domains = wezterm.default_ssh_domains()
for _, dom in ipairs(Config.ssh_domains) do
  dom.assume_shell = "Posix"
  dom.multiplexing = "WezTerm"
end
-- Config.ssh_domains = {
--   {
--     name = "wsl:ssh",
--     remote_address = "localhost:22",
--     ssh_option = {
--       identityfile = "C:\\Users\\aktheat\\.ssh\\id_ed25519.pub",
--     },
--     username = "aktheat",
--     assume_shell = "Posix",
--     multiplexing = "WezTerm",
--   },
-- }
-- Config.default_domain = "SSHMUX:localhost"
Config.default_domain = "WSL:Ubuntu-24.04"
Config.default_prog = { "pwsh" }
Config.launch_menu = {
  {
    label = Icons.Progs["pwsh.exe"] .. " PowerShell V7",
    args = {
      "pwsh",
      "-NoLogo",
      "-ExecutionPolicy",
      "RemoteSigned",
      "-NoProfileLoadTime",
    },
    cwd = "~",
  },
  { label = "Command Prompt", args = { "cmd.exe" }, cwd = "~" },
  { label = "NuShell", args = { "nu.exe" }, cwd = "~" },
  { label = Icons.Progs["git"] .. " Git bash", args = { "bash", "-l" }, cwd = "~" },
}
Config.set_environment_variables = {
  WEZTERM_CONFIG_DIR = "c/Users/aktheat/.config/wezterm",
}
-- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
Config.wsl_domains = {
  {
    name = "WSL:Ubuntu-24.04",
    distribution = "Ubuntu-24.04",
    username = "aktheat",
    default_cwd = "~",
    default_prog = { "bash" },
  },
}

Config.unix_domains = {}

return Config
