$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
## Get Config Veriable
$Config = "$scriptPath\Config.xml"
if (Test-Path $Config -ErrorAction SilentlyContinue) {
    $Xml = [xml](Get-Content -Path $Config -ErrorAction SilentlyContinue)
    $InstallFolderPath = $Xml.Configuration.Option | Select-Object -ExpandProperty InstallFolderPath -ErrorAction SilentlyContinue
    $TaskName = $Xml.Configuration.Option | Select-Object -ExpandProperty TaskName -ErrorAction SilentlyContinue
}

## Create Folder
if (!(Test-Path $InstallFolderPath)) { New-Item -Path "$InstallFolderPath" -ItemType Directory -Force -ErrorAction Continue | Out-Null }

## Copy Files
Copy-Item -Path "$scriptPath\IPTest.vbs" -Destination "$InstallFolderPath" -Force
Copy-Item -Path "$scriptPath\IPTest.ps1" -Destination "$InstallFolderPath" -Force
Copy-Item -Path "$scriptPath\ComputerIPList.txt" -Destination "$InstallFolderPath" -Force
Copy-Item -Path "$scriptPath\Config.xml" -Destination "$InstallFolderPath" -Force
Copy-Item -Path "$scriptPath\IPTester_Uninstall.ps1" -Destination "$InstallFolderPath" -Force
Copy-Item -Path "$scriptPath\IPTester_Uninstall.cmd" -Destination "$InstallFolderPath" -Force

## Create Task
$GetUpgradeTask = (Get-ScheduledTask -TaskPath "\" -TaskName "$TaskName" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty TaskName -ErrorAction SilentlyContinue).Count
if ($GetUpgradeTask -eq 0) {
    ## Create Task Scheduler
    $Trigger = New-ScheduledTaskTrigger -Daily -At 7am
    $Set = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
    $User= "NT AUTHORITY\SYSTEM"
    $Action= New-ScheduledTaskAction -Execute "C:\Windows\system32\wscript.exe" -Argument "$InstallFolderPath\IPTest.vbs"
    Register-ScheduledTask -TaskName "$TaskName" -User $User -Action $Action -Trigger $Trigger -Settings $Set –Force
}