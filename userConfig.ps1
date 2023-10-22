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