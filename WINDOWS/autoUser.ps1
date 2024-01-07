# Define the path to the users.txt file
$usersFilePath = "users.txt"

# Define the whitelist of users to ignore
$whitelist = @("Administrator", "Guest", "DefaultAccount", "WDAGUtilityAccount")

# Read the content of the users.txt file
$usersFileContent = Get-Content $usersFilePath

# Initialize variables
$authorizedAdmins = @()
$authorizedUsers = @()
$isInAdminSection = $false

# Parse the file
foreach ($line in $usersFileContent) {
    if ($line -eq "Authorized Administrators:") {
        $isInAdminSection = $true
        continue
    } elseif ($line -eq "Authorized Users:") {
        $isInAdminSection = $false
        continue
    }

    if ($isInAdminSection) {
        $authorizedAdmins += $line
    } else {
        $authorizedUsers += $line
    }
}

# Function to manage user account
function Manage-UserAccount {
    param(
        [string]$username,
        [boolean]$isAdmin
    )

    # Check if the user is in the whitelist
    if ($username -in $whitelist) {
        Write-Host "User $username is in the whitelist and will be ignored."
        return
    }

    # Check if the user exists
    $userExists = Get-LocalUser -Name $username -ErrorAction SilentlyContinue

    # If user does not exist, create the user
    if (-not $userExists) {
        Write-Host "Creating user $username..."
        New-LocalUser -Name $username -NoPassword -AccountNeverExpires -UserMayNotChangePassword
        Add-LocalGroupMember -Group "Users" -Member $username -ErrorAction SilentlyContinue
    }

    # Add or remove user from Administrators group
    $adminGroup = Get-LocalGroup -Name "Administrators"
    if ($isAdmin) {
        Add-LocalGroupMember -Group $adminGroup -Member $username -ErrorAction SilentlyContinue
        Write-Host "Added $username to Administrators group."
    } else {
        Remove-LocalGroupMember -Group $adminGroup -Member $username -ErrorAction SilentlyContinue
        Write-Host "Removed $username from Administrators group."
    }

$localUsers = Get-LocalUser

# Loop through each local user
foreach ($user in $localUsers) {
    # Check if the user is not in the authorized list
    if ($user.Name -notin $authorizedUsers) {
    if($user.Name -notin $authorizedAdmins) {     try {
            # Attempt to delete the user
            Remove-LocalUser -Name $user.Name
            Write-Host "User $($user.Name) has been removed."
        } catch {
            # Handle errors, like if the user cannot be removed
            Write-Host "Error removing user $($user.Name): $_"
        }}
   
    }
}



}

# Process each user
foreach ($admin in $authorizedAdmins) {
    Manage-UserAccount -username $admin -isAdmin $true
}

foreach ($user in $authorizedUsers) {
    Manage-UserAccount -username $user -isAdmin $false
}

Write-Host "User account management completed."



$missingAdmins = $authorizedAdmins | Where-Object { $currentAdmins -notcontains $_ }
foreach ($admin in $missingAdmins) {
    Write-Host "Adding Admin: $admin"
    Add-LocalGroupMember -Group "Administrators" -Member $admin -ErrorAction SilentlyContinue
}

# Output completion message
Write-Host "User accounts have been updated according to the authorized list."

Write-Host "Now Changing Passwords:"

$Password = ConvertTo-SecureString "aPASSWORD12345!" -AsPlainText -Force
$UserAccounts = Get-LocalUser

foreach ($UserAccount in $UserAccounts) {
    try {
        $UserAccount | Set-LocalUser -Password $Password
        Write-Output "Password for $($UserAccount.Name) has been changed."
    } catch {
        Write-Output "Failed to change password for $($UserAccount.Name)."
    }
}




# Define new names for the accounts
$newAdminName = "NewAdminName"
$newGuestName = "NewGuestName"

# Rename and disable the Administrator account
$adminAccount = Get-LocalUser -Name "Administrator" -ErrorAction SilentlyContinue
if ($null -ne $adminAccount) {
    Rename-LocalUser -Name "Administrator" -NewName $newAdminName
    Disable-LocalUser -Name $newAdminName
}

# Rename and disable the Guest account
$guestAccount = Get-LocalUser -Name "Guest" -ErrorAction SilentlyContinue
if ($null -ne $guestAccount) {
    Rename-LocalUser -Name "Guest" -NewName $newGuestName
    Disable-LocalUser -Name $newGuestName
}

Write-Host "Default accounts have been renamed and disabled."
