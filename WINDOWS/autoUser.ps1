# # Define the path to the input file
# $usersFilePath = "users.txt"

# # Read the content of the file
# $usersFileContent = Get-Content -Path $usersFilePath -ErrorAction SilentlyContinue

# # Check if content was read successfully
# if ($null -eq $usersFileContent) {
#     Write-Error "The file at $usersFilePath could not be found or read."
#     return
# }

# # Separate the content into administrators and users
# $adminsStart = $usersFileContent.IndexOf("Authorized Administrators") + 1
# $usersStart = $usersFileContent.IndexOf("Authorized Users") + 1

# $authorizedAdmins = $usersFileContent[$adminsStart..($usersStart-3)].Trim() | Where-Object { $_ }
# $authorizedUsers = $usersFileContent[$usersStart..($usersFileContent.Count-1)].Trim() | Where-Object { $_ }

# # Get the list of current user accounts on the system, excluding default accounts
# $currentUserAccounts = Get-LocalUser | Where-Object { $_.Name -notmatch "^(Administrator|DefaultAccount|Guest|WDAGUtilityAccount)$" } | Select-Object -ExpandProperty Name

# # Ensure only authorized admins are in the Administrators group
# $currentAdmins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name
# $unauthorizedAdmins = $currentAdmins | Where-Object { $authorizedAdmins -notcontains $_ -and $_ -notmatch "^(Administrator|DefaultAccount|Guest|WDAGUtilityAccount)$" }
# foreach ($admin in $unauthorizedAdmins) {
#     Write-Host "Removing Admin Priv: $admin"
#     Remove-LocalGroupMember -Group "Administrators" -Member $admin -ErrorAction SilentlyContinue
# }


# # Add missing authorized users
# $missingUsers = $authorizedUsers | Where-Object { $currentUserAccounts -notcontains $_ }
# foreach ($user in $missingUsers) {
#     # Note: Creating user without password; may need to add password creation logic
#     Write-Host "Adding: $user"
#     New-LocalUser -Name $user -AccountNeverExpires -NoPassword -ErrorAction SilentlyContinue
# }

# # Remove unauthorized users
# $unauthorizedUsers = $currentUserAccounts | Where-Object { $authorizedUsers -notcontains $_ -and $authorizedAdmins -notcontains $_ }
# foreach ($user in $unauthorizedUsers) {
#     Write-Host "Removing: $user"
#     Remove-LocalUser -Name $user -ErrorAction SilentlyContinue
# }


# $missingAdmins = $authorizedAdmins | Where-Object { $currentAdmins -notcontains $_ }
# foreach ($admin in $missingAdmins) {
#     Write-Host "Adding Admin: $admin"
#     Add-LocalGroupMember -Group "Administrators" -Member $admin -ErrorAction SilentlyContinue
# }

# # Output completion message
# Write-Host "User accounts have been updated according to the authorized list."

# Write-Host "Now Changing Passwords:"

# $Password = ConvertTo-SecureString "aPASSWORD12345!" -AsPlainText -Force
# $UserAccounts = Get-LocalUser

# foreach ($UserAccount in $UserAccounts) {
#     try {
#         $UserAccount | Set-LocalUser -Password $Password
#         Write-Output "Password for $($UserAccount.Name) has been changed."
#     } catch {
#         Write-Output "Failed to change password for $($UserAccount.Name)."
#     }
# }




# # Define new names for the accounts
# $newAdminName = "NewAdminName"
# $newGuestName = "NewGuestName"

# # Rename and disable the Administrator account
# $adminAccount = Get-LocalUser -Name "Administrator" -ErrorAction SilentlyContinue
# if ($null -ne $adminAccount) {
#     Rename-LocalUser -Name "Administrator" -NewName $newAdminName
#     Disable-LocalUser -Name $newAdminName
# }

# # Rename and disable the Guest account
# $guestAccount = Get-LocalUser -Name "Guest" -ErrorAction SilentlyContinue
# if ($null -ne $guestAccount) {
#     Rename-LocalUser -Name "Guest" -NewName $newGuestName
#     Disable-LocalUser -Name $newGuestName
# }

# Write-Host "Default accounts have been renamed and disabled."



# Define the path to the users.txt file
$filePath = "users.txt"

# Define the default whitelist of Windows 10 accounts
$whitelist = @("Administrator", "DefaultAccount", "Guest", "WDAGUtilityAccount")

# Function to process the file and update users and admins
function Process-UsersFile {
    param(
        [string]$filePath,
        [string[]]$whitelist
    )

    # Read the file
    $fileContent = Get-Content -Path $filePath

    # Initialize variables
    $admins = @()
    $users = @()
    $isReadingAdmins = $false
    $isReadingUsers = $false

    # Parse the file content
    foreach ($line in $fileContent) {
        if ($line -eq "Authorized Administrators:") {
            $isReadingAdmins = $true
            $isReadingUsers = $false
            continue
        } elseif ($line -eq "Authorized Users:") {
            $isReadingUsers = $true
            $isReadingAdmins = $false
            continue
        }

        if ($isReadingAdmins -and $line -ne "") {
            $admins += $line
        } elseif ($isReadingUsers -and $line -ne "") {
            $users += $line
        }
    }

    # Add to users the admins that are not already in the users list
    $users += $admins | Where-Object { $users -notcontains $_ }

    # Update Administrators and Users
    Update-Administrators -Admins $admins -Whitelist $whitelist
    Update-Users -Users $users -Whitelist $whitelist
}

# Function to add/remove administrators
function Update-Administrators {
    param(
        [string[]]$Admins,
        [string[]]$Whitelist
    )

    # Get all local administrators
    $currentAdmins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name

    # Remove unwanted administrators
    foreach ($admin in $currentAdmins) {
        if ($admin -notin $Admins -and $admin -notin $Whitelist) {
            Remove-LocalGroupMember -Group "Administrators" -Member $admin
        }
    }

    # Add missing administrators
    foreach ($admin in $Admins) {
        if ($admin -notin $currentAdmins) {
            Add-LocalGroupMember -Group "Administrators" -Member $admin
        }
    }
}

# Function to add/remove users
function Update-Users {
    param(
        [string[]]$Users,
        [string[]]$Whitelist
    )

    # Get all local users
    $currentUsers = Get-LocalUser | Select-Object -ExpandProperty Name

    # Remove unwanted users
    foreach ($user in $currentUsers) {
        if ($user -notin $Users -and $user -notin $Whitelist) {
            Remove-LocalUser -Name $user
        }
    }

    # Add missing users
    foreach ($user in $Users) {
        if ($user -notin $currentUsers) {
            New-LocalUser -Name $user -NoPassword
        }
    }
}

# Process the file
Process-UsersFile -filePath $filePath -whitelist $whitelist


