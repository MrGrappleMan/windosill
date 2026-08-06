# Run other scripts

# 📦 Shell Setup - Variables and Functions
Add-Type -AssemblyName PresentationCore
$VerbosePreference = "SilentlyContinue"
$arch = $env:PROCESSOR_ARCHITECTURE

# User interactive
# to be decided

# Automated
Write-Host "Leave your device idle, save all your work, and the script will automatically restart your device"
Start-Sleep -s 3

Get-ChildItem -Path ".\scripts\auto-exec" -Filter *.ps1 | ForEach-Object { & $_.FullName }
