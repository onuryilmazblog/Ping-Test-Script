$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
#$scriptPath = "C:\Install\IpTester"
$CurrentDate = $(Get-Date -UFormat "%d.%m.%Y-%H.%M.%S")
$ComputerName = $env:COMPUTERNAME

## Get Config Veriable
$Config = "$scriptPath\Config.xml"
if (Test-Path $Config -ErrorAction SilentlyContinue) {
    $Xml = [xml](Get-Content -Path $Config -ErrorAction SilentlyContinue)
    [string]$LogFolderPath = $Xml.Configuration.Option | Select-Object -ExpandProperty LogFolderPath -ErrorAction SilentlyContinue
    $IPTestCount = $Xml.Configuration.Option | Select-Object -ExpandProperty IPTestCount -ErrorAction SilentlyContinue
}

## Create Folder
if (!(Test-Path $LogFolderPath)) { New-Item -Path "$LogFolderPath" -ItemType Directory -Force -ErrorAction Continue | Out-Null }

## Get Check Computer List
$ComputerList = Get-Content -Path "$scriptPath\ComputerIPList.txt"

Foreach ($Computer in $ComputerList) {
    $LogFileName = "$LogFolderPath\$ComputerName" + "_$Computer.log"
    Start -FilePath "cmd" -ArgumentList "/c echo ================================================== >> $LogFileName" -NoNewWindow
    Start-Sleep 3
    Start -FilePath "cmd" -ArgumentList "/c echo $CurrentDate tarihinde baslatildi. >> $LogFileName" -NoNewWindow
    Start-Sleep 3
    Start -FilePath "cmd" -ArgumentList "/c echo ================================================== >> $LogFileName" -NoNewWindow
    Start-Sleep 3
}


Foreach ($Computer in $ComputerList) {
    $LogFileName = "$LogFolderPath\$ComputerName" + "_$Computer.log"
    Start -FilePath "cmd" -ArgumentList "/c ping $Computer -n $IPTestCount >> $LogFileName" -NoNewWindow
}