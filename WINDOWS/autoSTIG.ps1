#create directory
mkdir "C:\Cypat-main\Windows\Standalone-Windows-STIG-Script" -force
#clone repo in current directory
git repo clone simeononsecurity/Standalone-Windows-STIG-Script
#navigate to directory
cd "C:\Cypat-main\Windows\Standalone-Windows-STIG-Script"
#run command
.\secure-standalone.ps1 -firefox $false
cd "C:\Cypat-main\Windows"
