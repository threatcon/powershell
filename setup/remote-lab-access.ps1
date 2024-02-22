# Fix script permissions
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

# Enable WinRM
winrm quickconfig

# Enable PSRemoting
Enable-PSRemoting -Force

# Authorize all computers on home network
Set-Item wsman:\localhost\client\trustedhosts *

# Restart WinRM
Restart-Service WinRM

# Test WinRM
Test-WsMan COMPUTERNAME

# Store credentials as variable
$cred = get-credential username

# create a credential file. NAME IT WHATEVER YOU WANT!!!!
$cred | export-clixml credfile.xml

# retrieve credential file
$cred=Import-Clixml \hidden\credfile.xml

# use credential file
enter-pssession -computername server -credential $cred

# store password NAME THE FILE SOMETHING ELSE!!!!!!!!!!!!!!
read-host -assecurestring | convertfrom-securestring | out-file username-password-encrypted.txt

# set username and retrieve passsword
$username = "domain\username"
$password = cat username-password-encrypted.txt | convertto-securestring

# create credential
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
