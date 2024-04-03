function ActivatePyEnv
{
  [Alias('ape')]
  param()

  if (Test-Path -Path ".\env\Scripts\Activate.ps1")
  {
    . (Join-Path .\env\Scripts\ Activate.ps1)
  } else
  {
    Write-Output "No virtual environment found in this directory"
  }
}
