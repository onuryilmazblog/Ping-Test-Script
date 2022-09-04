''''Way 1
currentdir=Left(WScript.ScriptFullName,InStrRev(WScript.ScriptFullName,"\"))

''''Way 2
With CreateObject("WScript.Shell")
CurrentPath=.CurrentDirectory
End With

''''Way 3
With WSH
CurrentDirr=Replace(.ScriptFullName,.ScriptName,"")
End With

Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "& currentdir &"\IPTest.ps1" , 0 , False
Set WshShell = Nothing