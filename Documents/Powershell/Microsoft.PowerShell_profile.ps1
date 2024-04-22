function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }

function touch($file) {
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

$DataHome = [IO.Path]::Combine($HOME, "Documents")


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
# regionend



# Load extra functions
@(
  "Functions.ps1",
  "ShellIntegration.ps1",
  "Initialize-Profile.ps1"
) | ForEach-Object {
  $path = "$DataHome/Powershell/Scripts/$_"
  if (Test-Path $path -ErrorAction SilentlyContinue)
  {
    . (Convert-Path $path)
  }
}



# Starship overwrite the prompt. Do this so its available on first open.
# There is a cost for this but it should be minimal.
if (Get-Command 'starship' -ErrorAction SilentlyContinue)
{
  Invoke-Expression (&starship init powershell)
  function Invoke-Starship-PreCommand
  {
    if ($global:profile_initialized -ne $true)
    {
      $global:profile_initialized = $true
      Initialize-Profile
    }
  }


  # Update previous prompt with simpler prompt
  function Invoke-Starship-TransientFunction
  {
    &starship prompt --profile short
  }
  Enable-TransientPrompt
} else
{
  Write-Host "Preparing interactive session for first use..." -ForegroundColor Cyan
  function prompt
  {
    . (Convert-Path "$DataHome/powershell/Scripts/OldPrompt")
    if ($global:profile_initialized -ne $true)
    {
      $global:profile_initialized = $true
      Initialize-Profile
    }
  }
}

Invoke-Expression (&starship init powershell)

# oh-my-posh.exe init pwsh --config "$env:POSH_THEMES_PATH\catppuccin.omp.json" | Invoke-Expression
Set-PSReadLineOption -PredictionViewStyle InlineView
# set wezterm as the TERM env
# $Env:TERM = "wezterm"
# $Env:KOMOREBI_CONFIG_HOME = 'C:\Users\ARK010\.config\komorebi'
# $Env:WHKD_CONFIG_HOME = 'C:\Users\ARK010\.config\komorebi'


