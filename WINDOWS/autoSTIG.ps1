#install git
choco install git
#create directory
mkdir "Standalone-Windows-STIG-Script"
cd "Standalone-Windows-STIG-Script"
#clone repo in current directory
gh repo clone simeononsecurity/Standalone-Windows-STIG-Script
#run command
.\secure-standalone.ps1 -firefox $false
cd "C:\Cypat-main\Windows"