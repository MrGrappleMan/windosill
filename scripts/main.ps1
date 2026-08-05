# Run other scripts

# 📦 Shell Setup - Variables and Functions
Add-Type -AssemblyName PresentationCore
$mediaPlayer = New-Object System.Windows.Media.MediaPlayer
$VerbosePreference = "SilentlyContinue"
$arch = $env:PROCESSOR_ARCHITECTURE
$sprtor = { Write-Host "_____________________________________________________________________________________________________________________________________________________________________________________________" }

# User interactive

# Automated
Write-Host "Leave your device idle, save all your work, and the script will automatically restart your device"
Start-Sleep -s 3

Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$path\script\main.ps1`"" -Verb RunAs
