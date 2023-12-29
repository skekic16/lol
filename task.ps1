$action = New-ScheduledTaskAction -Execute "powershell.exe" 
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = New-ScheduledTaskPrincipal -UserID 'DOMAIN\user' -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -Hidden -RunOnlyIfNetworkAvailable
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask T1 -InputObject $task -Force -TaskName MicrosoftCleanhouse -User $env:UserName
