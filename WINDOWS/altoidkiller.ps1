#MAIN SCRIPT 

Write-Host "Goodbye Alt0id"
Start-Sleep -seconds 5

#Call Scripts
#User Auditing
& './autoUser.ps1'
#Logging
& './logger.ps1'
#File Finder
& './susFinder.ps1'
#Application Auditing
& './appmgmr.ps1'
#Delete Policies
& './POLICYWIPE.ps1'
#Download Hardening Kitty
& './hardeningkitty.ps1'
#Run Faraday Script
& './scriptAutoRun.ps1'
#Execute LGPO
./LGPO.exe /g '../{AC9CB38C-EE4E-46BB-93EC-C655C5CF3138}'
#Chrome Appsec
& './chromesecurity.ps1'
#Service Config
& './services.ps1'
& './servcsv.ps1'

Write-Host "SCRIPTS COMPLETED GG's. RESTART TO APPLY ALL CHANGES"
Start-Sleep -seconds 5
