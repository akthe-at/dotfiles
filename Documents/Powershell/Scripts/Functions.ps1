# Snagged from the one and only @AndrewPla
# https://github.com/devops-collective-inc/PSHSummit2023/blob/main/andrew-pla-cross-platform-tuis/1%20-%20Basics/Out-ConsoleGridView%20Examples.ps1
function ocgv_history
{
  param(
    [parameter(Mandatory = $true)]
    [Boolean]
    $global
  )

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  if ($global)
  {
    # Global history
    $history = [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems().CommandLine 
    # reverse the items so most recent is on top
    [array]::Reverse($history) 
    $selection = $history | Select-Object -Unique | Out-ConsoleGridView -OutputMode Single -Filter $line -Title "Global Command Line History"

  } else
  {
    # Local history
    $history = Get-History | Sort-Object -Descending -Property Id -Unique | Select-Object CommandLine -ExpandProperty CommandLine 
    $selection = $history | Out-ConsoleGridView -OutputMode Single -Filter $line -Title "Command Line History"
  }

  if ($selection)
  {
    [Microsoft.PowerShell.PSConsoleReadLine]::DeleteLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($selection)
    if ($selection.StartsWith($line))
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor)
    } else
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selection.Length)
    }
  }
}

function Test-Administrator
{
  $CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
  $AdministratorRole = [Security.Principal.WindowsBuiltInRole] "Administrator"
    ([Security.Principal.WindowsPrincipal]$CurrentUser).IsInRole($AdministratorRole)
}


# Aliases
# Use function because it's faster to load

function ll
{ eza $args --long --icons=always
}

function lt
{ eza $args -T --icons=always 
}

function l
{ eza $args --icons=always 
}


function ActivatePyEnv
{
  [Alias('ape')]
  param()

  $envPaths = @(".\env\Scripts\Activate.ps1", ".\.venv\Scripts\Activate.ps1", ".\venv\Scripts\Activate.ps1")
  
  $found = $false
  foreach ($path in $envPaths)
  {
    if (Test-Path -Path $path)
    {
      . $path
      $found = $true
      break
    }
  }

  if (-not $found)
  {
    Write-Output "No virtual environment found in this directory"
  }
}


function Get-GitCheckout
{
  [alias("gco")]
  param()
  git checkout $args
}

function which
{ param($bin) Get-Command $bin 
}

function Watch-Command
{
  [alias('watch')]
  [CmdletBinding()]
  param (
    [Parameter()]
    [ScriptBLock]
    $Command,
    [Parameter()]
    [int]
    $Delay = 2
  )
  while ($true)
  {
    Clear-Host
    Write-Host ("Every {1}s: {0} `n" -F $Command.toString(), $Delay)
    $Command.Invoke()
    Start-Sleep -Seconds $Delay
  }
}
