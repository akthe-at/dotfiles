#Set-PSDebug -Trace 1

#function prdb
#{
#  param (
#    [Parameter(ValueFromRemainingArguments=$true)]
#    $args
#  )
#  # Store the current location
#  $initialPath = Get-Location
#  Set-Location -Path "~/Documents/DEM/PeerReview/sqlite_loader/Python"
#  ape
#  set-Location $initialPath
#  python "~/Documents/DEM/PeerReview/sqlite_loader/Python/src/prdb/"
#  python load_sent_cases.py $args
#  deactivate
#}

function gwt
{
  & '~/.scripts/create-wt.ps1' @args
}

function cd($path)
{
  z $path
}

function yy
{
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
  {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}


function touch($file)
{
  "" | Out-File $file -Encoding ASCII
}

function Set-StyleScriptAlias
{
  [alias("StyleScript")]
  param(
    [string[]]$file
  )
  # Call R to style the file
  Rterm.exe --quiet -e "styler::style_file('$file')" 2>&1

}

$global:profile_initialized = $false

# region Copied from Jaykul
trap
{ Write-Warning ($_.ScriptStackTrace | Out-String) 
}
# $InformationPreference = "Continue"
# I wish $Profile was in $Home, but since it's not:
$ProfileDir = $PSScriptRoot

# The XDG standard says use the variable and tells us how to calculate a fallback
$DataHome = if ($ENV:XDG_CONFIG_HOME)
{
  $ENV:XDG_DATA_HOME
} else
{
  [IO.Path]::Combine($HOME, "Documents")
}
$ConfigHome = if ($ENV:XDG_CONFIG_HOME)
{
  $ENV:XDG_CONFIG_HOME
} else
{
  [IO.Path]::Combine($HOME, ".config")
}

if ($Host.UI.RawUI.KeyAvailable)
{
  $Controlled = $false
  while ($Host.UI.RawUI.KeyAvailable -and ($key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown,IncludeKeyUp")))
  {
    if (!$Controlled -and $key.ControlKeyState -match "LeftCtrlPressed")
    {
      $Controlled = $true
    }
  }
  if ($Controlled)
  {
    Write-Host "Skipping Interactive Config. To complete, run:`n. `"$Interactive`"" -ForegroundColor Yellow
    if ($PSVersionTable.PSVersion.Major -gt 5)
    {
      function prompt
      { "`e[36m$($MyInvocation.HistoryId)`e[37m $pwd`e[0m`n❯" 
      }
    } else
    {
      function prompt
      { "$([char]27)[36m$($MyInvocation.HistoryId)$([char]27)[37m $pwd$([char]27)[0m`n$([char]0x276f)" 
      }
    }
    return
  }
}

# Load extra functions
@(
  "Functions.ps1",
  "ShellIntegration.ps1",
  "Initialize-Profile.ps1",
  "GitTools.ps1"
) | ForEach-Object {
  $path = "~/Documents/Powershell/Scripts/$_"
  . (Convert-Path $path)
}



### Starship overwrite the prompt. Do this so its available on first open.
### There is a cost for this but it should be minimal.
#if (Get-Command 'starship' -ErrorAction SilentlyContinue)
#{
#  Invoke-Expression (&starship init powershell)
#  function Invoke-Starship-PreCommand
#  {
#    if ($global:profile_initialized -ne $true)
#    {
#      $global:profile_initialized = $true
#      Initialize-Profile
#    }
#  }
#  # Update previous prompt with simpler prompt 
#  function Invoke-Starship-TransientFunction
#  {
#    &starship prompt --profile short
#  }
#  Enable-TransientPrompt
#} else
#{
#  Write-Host "Preparing interactive session for first use..." -ForegroundColor Cyan
#  function prompt
#  {
#    . (Convert-Path "$DataHome/Powershell/Scripts/OldPrompt")
#    if ($global:profile_initialized -ne $true)
#    {
#      $global:profile_initialized = $true
#      Initialize-Profile
#    }
#  }
#}
########
# OH MY POSH SECTION
########

Invoke-Expression (oh-my-posh init pwsh --config "C:\Users\ARK010\.config\ohmyposh\rosepine.toml")
#if (Get-Command 'oh-my-posh' -ErrorAction SilentlyContinue)
#{
#  Invoke-Expression (oh-my-posh init pwsh --config "C:\Users\ARK010\.config\ohmyposh\rosepine.toml")
#  if ($global:profile_initialized -ne $true)
#  {
#    $global:profile_initialized = $true
#    Initialize-Profile
#  }
#} else
#{
#  Write-Host "'oh-my-posh' command not found. The default prompt will be used." -ForegroundColor Red
#}

# Utility Functions
function Test-CommandExists
{
  param($command)
  $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
  return $exists
}

$EDITOR = if (Test-CommandExists nvim)
{ 'nvim' 
} elseif (Test-CommandExists vim)
{ 'vim' 
} elseif (Test-CommandExists vi)
{ 'vi' 
} elseif (Test-CommandExists code)
{ 'code' 
} elseif (Test-CommandExists notepad++)
{ 'notepad++' 
} else
{ 'notepad' 
}
Set-Alias -Name vim -Value $EDITOR

# Network Utilities
function Get-PubIP
{ (Invoke-WebRequest http://ifconfig.me/ip).Content 
}

function uptime
{
  if ($PSVersionTable.PSVersion.Major -eq 5)
  {
    Get-WmiObject win32_operatingsystem | Select-Object @{Name='LastBootUpTime'; Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Format-Table -HideTableHeaders
  } else
  {
    net statistics workstation | Select-String "since" | ForEach-Object { $_.ToString().Replace('Statistics since ', '') }
  }
}


function docs
{ Set-Location -Path $HOME\Documents 
}

function dtop
{ Set-Location -Path $HOME\Desktop 
}

# Quick Access to Editing the Profile
function ep
{ nvim $PROFILE 
}

#zebar
function zb([string]$arg)
{
  switch ($arg)
  {
    "stop"
    { Stop-Process -Name zebar -ErrorAction SilentlyContinue 
    }
    "start"
    { 
      & "$env:ZEBAR_CONFIG_HOME\start.ps1"
    }
    "restart"
    { zb "stop"; zb "start"
    }
  }
}

function zi
{
  param($param)
  $_zoxide_result = $(zoxide query -i -- $param)
  if ($_zoxide_result)
  {
    Set-Location $_zoxide_result
  }
}

function yasb 
{
  C:\Users\ARK010\.scripts\start-yasb.ps1
}
# oh-my-posh.exe init pwsh --config "$env:POSH_THEMES_PATH\gruvbox.omp.json" | Invoke-Expression
# set wezterm as the TERM env
# $Env:TERM = "wezterm"
$Env:KOMOREBI_CONFIG_HOME = 'C:\Users\ARK010\.config\komorebi'
$Env:WHKD_CONFIG_HOME = 'C:\Users\ARK010\.config\komorebi'

#Set-PSDebug -Trace 0
