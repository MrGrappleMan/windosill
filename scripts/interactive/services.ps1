$svcset = {
	param($svcName, $choice)
	switch ($choice) {
		"0" {
			Write-Host "→ Disabling and stopping service: $svcName"
			Stop-Service -Name $svcName -ErrorAction Continue
			Set-Service -Name $svcName -StartupType Disabled
		}
		"1" {
			Write-Host "→ Enabling and starting service: $svcName"
			Start-Service -Name $svcName -ErrorAction Continue
			Set-Service -Name $svcName -StartupType Automatic
		}
		default {
			Write-Host "→ Skipping: $svcName"
		}
	}
}
$userask = {
	Write-Host ""
	Write-Host "Options:"
	Write-Host "[Y] Yes | [N] No"

	$timeout = 5
	$stopwatch = [Diagnostics.Stopwatch]::StartNew()
	$choice = "X"  # default if timeout

	while ($stopwatch.Elapsed.TotalSeconds -lt $timeout) {
		if ([Console]::KeyAvailable) {
			$key = [Console]::ReadKey($true).Key
			switch ($key) {
				"Y" { $choice = "1"; break }
				"N" { $choice = "0"; break }
			}
		}
		Start-Sleep -Milliseconds 10
	}

	$stopwatch.Stop()
	Write-Host "→ Selected: $choice"
	return $choice
}

Set-Location "$Env:windir\\Temp\\Fynelium-NT\\"

## 👋 User Prompts

# Xbox
& $toptui
Write-Host "Do you use anything related to Xbox?"
Write-Host ""
Write-Host "Unnecesary services will be disabled if you do not use them"
$choice = & $userask
& $svcset "XblAuthManager" $choice
& $svcset "GameSave" $choice

# Remote Access
& $toptui
Write-Host "Do you use remote desktop or remotely manage your device?"
Write-Host ""
Write-Host "It makes remote control of your computer possible."
Write-Host "However, Microsoft Support could use this to fix issues."
Write-Host "Windows's Remote support won't work if you disable these services."
Write-Host "Disabling these helps improve the security of your device in general"
Write-Host "You may use Parsec or Moonlight without issues"
$choice = & $userask
& $svcset "SessionEnv" $choice
& $svcset "TermService" $choice
& $svcset "UmRdpService" $choice
& $svcset "RemoteRegistry" $choice