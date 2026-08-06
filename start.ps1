# Start

# Admin rights. If not, try self-elevate, or exit if user cancels
  if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "Not running as administrator, please try again with Ctrl + Shift + Enter"
        Start-Sleep -Seconds 3
        #powershell irm https://raw.githubusercontent.com/MrGrappleMan/windosill/main/start.ps1 | iex
        # Want to implement self elevation method here, ofcourse respecting user choice
        exit 
    }

# 📂 Repo directory
    $path = "$env:windir\Temp\windosill"
    if (Test-Path $path) { Remove-Item $path -Recurse -Force }
    New-Item -Path $path -ItemType Directory -Force | Out-Null

# Git checks and installs
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        winget install --id Git.Git -e --source winget
        # Refresh environment variables (PATH)
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path", "User")

        # Re-check Git availability after installation
        if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
            Write-Host "git installation failed. Exiting..." -ForegroundColor Red
            exit
        }
    }

# Clone Repo
    git clone https://github.com/MrGrappleMan/windosill.git $path

# Enter repo directory
    # Everything is intended to run in relation to the repo directory
    Set-Location $path

# Copy over files
    robocopy .\fsroot $env:systemdrive /E

# Start main script
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$path\script\main.ps1`"" -Verb RunAs
