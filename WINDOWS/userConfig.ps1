
function Compare-UserLists {
    try{}
    catch{
        
    }
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
Compare-UserLists -userList (Read-Host "Enter a list of users (separated by spaces)")


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

# Call the function with a prompt for user input
Compare-AdminLists -adminList (Read-Host "Enter a list of administrators (separated by spaces)")



do {
    Write-Host "
    Type 'exit' to leave script.
    
    14  Add User
    1   Delete user
    2   Add user(s) to administrator group
    3   Remove user(s) from administrator group
    4   Change user's password
    6   Get all filesharing names
    7   Stop filesharing name
    12  enable / disable remote desktop
    
    "

    if($input -eq "1") {
        Write-Host "Type the name of the user you want to remove:"
        $username = Read-host
        Remove-LocalUser -Name $username
    } elseif ($input -eq "2") {
        Write-Host "Type the username(s) you want to add to the admin group. Type 'exit' to go back."
        do {
            $username = Read-host
            if($username -ne "exit") {
                Add-LocalGroupMember -Group "Administrators" -Member $username
            }
        } until ($username -eq "exit")
    } elseif ($input -eq "3") {
        Write-Host "Type the username(s) you want to add to the admin group. Type 'exit' to go back."
        do {
            $username = Read-host
            if($username -ne "exit") {
                Remove-LocalGroupMember -Group "Administrators" -Member $username
            }
        } until ($username -eq "exit")
    } elseif ($input -eq "4") {
        Write-Host "Changing password(s). Type 'exit' at any time to leave."
        do {
            Write-Host "Username:"
            $username = Read-host
            if($username -eq "exit") { break }
            $useraccount = Get-LocalUser -Name $username
            Write-Host "Password:"
            $password = Read-host -AsSecureString
            if($password -eq "exit") { break }
            $useraccount | Set-LocalUser -Password $password
        } until ($username -eq "exit")}


        elseif ($input -eq "6") {
            #Get-WmiObject -Class Win32_UserAccount
            Get-FileShare
        } elseif ($input -eq "7") {
            Write-Host "Enter the name of fileshare to remove:"
            $name = Read-host
            Remove-FileShare -Name $name
        }

        elseif ($input -eq "14") {
            Write-host "Type the name of the new user:"
            $username = Read-host
            Write-host "Type the password for the user:"
            $password = Read-host -AsSecureString
            Write-host "Is the new account an Administrator? (y/n)"
            $admin = Read-host
            Write-host "Creating new account..."
            New-LocalUser $username -Password $password -FullName $username -Description "Description of this account."
            if($admin -eq "y") {
                Add-LocalGroupMember -Group "Administrators" -Member $username
            }
            Write-host "New account created."
        }

        elseif ($input -eq "12") {
            Write-Host "Enable remote desktop? (y/n)"
            $rmd = Read-host
            if($rmd -eq "y") {
                Write-Host "Enabling remote desktop..."
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v AllowTSConnections /t REG_DWORD /d 1 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 1 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f
                REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
                netsh advfirewall firewall set rule group="remote desktop" new enable=yes
                Write-Host "Please select 'Allow connections only from computers running Remote Desktop with Network Level Authentication (more secure)'"
                start SystemPropertiesRemote.exe /wait
                Write-Host "Enabled remote desktop"
            } else {
                Write-Host "Disabling remote desktop..."
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v AllowTSConnections /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
                netsh advfirewall firewall set rule group="remote desktop" new enable=no
                Write-Host "Disabled remote desktop"
            }
        }

}

until ($input -eq "exit")


