# Start

# Admin rights. If not, try self-elevate, or exit if user cancels
  if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "Not running as administrator, please try again with Ctrl + Shift + Enter"
        Start-Sleep -Seconds 3
        # powershell irm https://raw.githubusercontent.com/MrGrappleMan/windosill/main/start.ps1 | iex
        # Want to implement self elevation method here, ofcourse respecting user choice
        exit
    }

# 📂 Create storage directory
$path = "$env:windir\Temp\windosill"
if (Test-Path $path) { Remove-Item $path -Recurse -Force }
New-Item -Path $path -ItemType Directory -Force | Out-Null

# 🐱 Git presence
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
	Write-Host "Installing Git via winget..." -ForegroundColor Cyan
	winget install --id Git.Git -e --source winget
	Write-Host "Git installation completed. Refreshing environment variables..." -ForegroundColor Yellow

	# Refresh environment variables (PATH)
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
	             [System.Environment]::GetEnvironmentVariable("Path", "User")

	# Double-check Git availability after refresh
	if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
		Write-Host "Restarting PowerShell to load Git into PATH..." -ForegroundColor Cyan
		Start-Process "powershell" -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
		exit
	}
}

# 🦠 Clone Repo
git clone https://github.com/MrGrappleMan/windosill.git $path

# ⏩ Copy over files
robocopy $Env:windir\\Temp\\windosill\\fsroot "C:\" /E

# 🖐️ User Interactive
Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$path\script\main.ps1`"" -Verb RunAs
