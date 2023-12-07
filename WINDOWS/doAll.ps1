Set-ExecutionPolicy unrestricted

function getHardeningKitty(){
    #get latest release
    try{
    $Version = (((Invoke-WebRequest "https://api.github.com/repos/scipag/HardeningKitty/releases/latest" -UseBasicParsing) | ConvertFrom-Json).Name).SubString(2)
    $HardeningKittyLatestVersionDownloadLink = ((Invoke-WebRequest "https://api.github.com/repos/scipag/HardeningKitty/releases/latest" -UseBasicParsing) | ConvertFrom-Json).zipball_url
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest $HardeningKittyLatestVersionDownloadLink -Out HardeningKitty$Version.zip
    Expand-Archive -Path ".\HardeningKitty$Version.zip" -Destination ".\HardeningKitty$Version" -Force
    $Folder = Get-ChildItem .\HardeningKitty$Version | Select-Object Name -ExpandProperty Name
    Move-Item ".\HardeningKitty$Version\$Folder\*" ".\HardeningKitty$Version\"
    Remove-Item ".\HardeningKitty$Version\$Folder\"
    New-Item -Path $Env:ProgramFiles\WindowsPowerShell\Modules\HardeningKitty\$Version -ItemType Directory
    Set-Location .\HardeningKitty$Version
    Copy-Item -Path .\HardeningKitty.psd1,.\HardeningKitty.psm1,.\lists\ -Destination $Env:ProgramFiles\WindowsPowerShell\Modules\HardeningKitty\$Version\ -Recurse
    Import-Module "$Env:ProgramFiles\WindowsPowerShell\Modules\HardeningKitty\$Version\HardeningKitty.psm1"


    #invoke hardeningkitty
    Invoke-HardeningKitty -Mode HailMary -Log -Report -FileFindingList .\lists\finding_list_0x6d69636b_machine.csv
     Write-Host "Hardening Kitty finished."

    }
    catch{
    Write-Host "Hardening Kitty Failed. Do it Manually"
    }


}


function changePassWords(){
./pass.ps1
}


function secureScript(){
./scriptAutoRun.ps1
}

function policySettings(){
./policy.ps1
}

function Compare-UserLists {
    param (
        [Parameter(Mandatory=$true)]
        [string]$userList
    )

    # Split the input string into an array of users
    $inputUsers = $userList -split ' '

    # Get all local users on the system
    $systemUsers = Get-LocalUser | ForEach -Object { $_.Name }

    # Compare the system users with the input users
    $usersNotInList = $systemUsers | Where-Object { $_ -notin $inputUsers }

    # Output the users found on the system but not in the input list
    Write-Output $usersNotInList
}



function Compare-AdminLists {
    param (
        [Parameter(Mandatory=$true)]
        [string]$adminList
    )

    # Split the input string into an array of users
    $inputAdmins = $adminList -split ' '

    # Get all local administrators on the system
    $systemAdmins = Get-LocalGroupMember -Group "Administrators" | ForEach-Object { $_.Name.Split('\')[-1] }

    # Compare the system admins with the input admins
    $adminsNotInList = $systemAdmins | Where-Object { $_ -notin $inputAdmins }
    $nonAdminsInList = $inputAdmins | Where-Object { $_ -notin $systemAdmins }

    # Output the admins found on the system but not in the input list
    Write-Output "Administrators on system but not in list:"
    Write-Output $adminsNotInList

    # Output the users in the input list who are not admins on the system
    Write-Output "Users in list who are not administrators:"
    Write-Output $nonAdminsInList
}


function fullUserAuditing(){
# Call the function with a prompt for user input
Compare-UserLists -userList (Read-Host "Enter a list of users (separated by spaces)")
Compare-AdminLists -adminList (Read-Host "Enter a list of administrators (separated by spaces)")

$continue = $true
while ($continue) {
  Write-Host "Please choose an option:"
  Write-Host "1. Add a user"
  Write-Host "2. Delete a user"
  Write-Host "3. Add someone to the admin group"
  Write-Host "4. Remove someone from the admin group"
  Write-Host "5. End"
  $choice = Read-Host "Enter your choice:"

  switch ($choice) {
    "1" {
      Write-Host "Enter the username you want to add:"
      $username = Read-Host
      New-LocalUser -Name $username
    }
    "2" {
      Write-Host "Enter the username you want to delete:"
      $username = Read-Host
      Remove-LocalUser -Name $username
    }
    "3" {
      Write-Host "Enter the username you want to add to the admin group:"
      $username = Read-Host
      Net LocalGroup Administrators $username /add
    }
    "4" {
      Write-Host "Enter the username you want to remove from the admin group:"
      $username = Read-Host
      Net LocalGroup Administrators $username /delete
    }
    "5" {
      $continue = $false
    }
    default {
      Write-Host "Invalid option. Please choose a valid option."
    }
  }
}

Write-Host "Exiting program..."

}

function importantCommands(){
Start-Job -ScriptBlock { sfc /scannow }
mkdir "logs"
$outputFile = "logs\log.txt"
# Define output file path


# Clear output file
Out-File -FilePath $outputFile -Force

# Get network statistics
$netstatOutput = netstat -a -b -p | Out-GridView -OutputMode Data | Select-Object -ExpandProperty DisplayName, Protocol, LocalAddress, ForeignAddress, State
$netstatOutput | Out-File -FilePath $outputFile -Append -InputObject "**Netstat Output:**" -Prepend

# Get file shares
$fileShares = Get-FileShare -Protocol SMB
$fileSharesOutput = $fileShares | Out-GridView -OutputMode Data | Select-Object -ExpandProperty Name, Path, Status
$fileSharesOutput | Out-File -FilePath $outputFile -Append -InputObject "**File Shares:**" -Prepend

# Get remote connections
$remoteConnections = Get-NetConnection | Where-Object {$_.LocalAddress -ne '127.0.0.1'}
$remoteConnectionsOutput = $remoteConnections | Out-GridView -OutputMode Data | Select-Object -ExpandProperty ComputerName, Username, Protocol, LocalAddress, RemoteAddress
$remoteConnectionsOutput | Out-File -FilePath $outputFile -Append -InputObject "**Remote Connections:**" -Prepend

# Get active network connections
$connections = Get-Connection
$connectionsOutput = $connections | Out-GridView -OutputMode Data | Select-Object -ExpandProperty Name, Protocol, RemoteAddress, State
$connectionsOutput | Out-File -FilePath $outputFile -Append -InputObject "**Active Connections:**" -Prepend

}



function invokeScripts(){
changePasswords
importantCommands
fullUserAuditing
getHardeningKitty
secureScript
policySettings
}

invokeScripts