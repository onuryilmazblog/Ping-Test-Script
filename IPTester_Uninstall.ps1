$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

## Get Config Veriable
$Config = "$scriptPath\Config.xml"
if (Test-Path $Config -ErrorAction SilentlyContinue) {
    $Xml = [xml](Get-Content -Path $Config -ErrorAction SilentlyContinue)
    $InstallFolderPath = $Xml.Configuration.Option | Select-Object -ExpandProperty InstallFolderPath -ErrorAction SilentlyContinue
    $TaskName = $Xml.Configuration.Option | Select-Object -ExpandProperty TaskName -ErrorAction SilentlyContinue
}

## Get Task Function
Function GetTask ($GetTaskName) {
    (Get-ScheduledTask -TaskPath "\" -TaskName "$GetTaskName" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty TaskName -ErrorAction SilentlyContinue).Count
}


## Remove Upgrade Folder
if (Test-Path $InstallFolderPath) {
    Remove-Item -Path "$InstallFolderPath" -Recurse -Force -ErrorAction SilentlyContinue
}
Start-Sleep 5
if (Test-Path $InstallFolderPath) {
    Start-Sleep 10
    Remove-Item -Path "$InstallFolderPath" -Recurse -Force -ErrorAction SilentlyContinue
}


## Remove Task
if ((GetTask $TaskName) -gt 0) {
    Unregister-ScheduledTask -TaskPath "\" -TaskName "$TaskName" -Confirm:$false -ErrorAction SilentlyContinue
}