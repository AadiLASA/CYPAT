# #MAIN SCRIPT 

# Write-Host "Goodbye Alt0id"
# Start-Sleep -seconds 5

# #Call Scripts
# #User Auditing
# & './autoUser.ps1'
# #Logging
# & './logger.ps1'
# #File Finder
# & './susFinder.ps1'
# #Application Auditing
# & './appmgmr.ps1'
# #Delete Policies
# & './POLICYWIPE.ps1'
# #Download Hardening Kitty
# & './hardeningkitty.ps1'
# #Run Faraday Script
# & './scriptAutoRun.ps1'
# #Execute LGPO
# ./LGPO.exe /g '../{AC9CB38C-EE4E-46BB-93EC-C655C5CF3138}'
# #Audit Policies
# & './AUDITPOL.ps1'
# #Chrome Appsec
# & './chromesecurity.ps1'
# #Service Config
# & './services.ps1'
# & './servcsv.ps1'

# Write-Host "SCRIPTS COMPLETED GG's. RESTART TO APPLY ALL CHANGES"
# Start-Sleep -seconds 5



function Confirm-Execution {
    while ($true) {
        Write-Host "Press 'R' to run the script or 'E' to exit."
        $input = Read-Host "Your choice"
        if ($input -eq 'R') {
            break
        } elseif ($input -eq 'E') {
            Write-Host "Exiting script."
            exit
        } else {
            Write-Host "Invalid input, please try again."
        }
    }
}

function Invoke-Script {
    param (
        [string]$ScriptPath
    )

    Write-Host "Running $ScriptPath..."
    & $ScriptPath
}

function Show-Menu {
    param (
        [string]$Title = 'Please enter the number corresponding to the action you want to perform:'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host "1: Run User Auditing"
    Write-Host "2: Run Logger"
    Write-Host "3: Run File Finder"
    Write-Host "4: Run Application Auditing"
    Write-Host "5: Run Delete Policies"
    Write-Host "13: Auto Stig Script"
    Write-Host "6: Download Hardening Kitty"
    Write-Host "7: Run Faraday Script"
    Write-Host "14: Win10 Hardening Script"
    Write-Host "8: Execute LGPO"
    Write-Host "9: Run Audit Policies"
    Write-Host "10: Run Chrome Appsec"
    Write-Host "11: Run Service Config"
    Write-Host "12: Run Service CSV"
    Write-Host "Q: Quit"
    Write-Host "=================================================="
}

Confirm-Execution

do {
    Show-Menu

    $input = Read-Host "Select an option"
    switch ($input) {
        '1' { Invoke-Script './autoUser.ps1' }
        '2' { Invoke-Script './logger.ps1' }
        '3' { Invoke-Script './susFinder.ps1' }
        '4' { Invoke-Script './appmgmr.ps1' }
        '5' { Invoke-Script './POLICYWIPE.ps1' }
        '6' { Invoke-Script './hardeningkitty.ps1' }
        '7' { Invoke-Script './scriptAutoRun.ps1' }
        '8' { Invoke-Script './lgpoapply.ps1' }
        '9' { Invoke-Script './AUDITPOL.ps1' }
        '10' { Invoke-Script './chromesecurity.ps1' }
        '11' { Invoke-Script './services.ps1' }
        '12' { Invoke-Script './servcsv.ps1' }
        '13' {Invoke-Script './autoSTIG.ps1'}
        '14' {Invoke-Script './win10hardening.ps1'}
        'Q' {
            Write-Host "Goodbye Alt0id"
            Start-Sleep -seconds 5
            Write-Host "SCRIPTS COMPLETED GG's. RESTART TO APPLY ALL CHANGES"
            break
        }
        default { Write-Host "Invalid option, please try again." }
    }

    Start-Sleep -seconds 2
} while ($input -ne 'Q')

