# Define the path to the input file
$usersFilePath = "users.txt"

# Read the content of the file
$usersFileContent = Get-Content -Path $usersFilePath -ErrorAction SilentlyContinue

# Check if content was read successfully
if ($null -eq $usersFileContent) {
    Write-Error "The file at $usersFilePath could not be found or read."
    return
}

# Separate the content into administrators and users
$adminsStart = $usersFileContent.IndexOf("Authorized Administrators") + 1
$usersStart = $usersFileContent.IndexOf("Authorized Users") + 1

$authorizedAdmins = $usersFileContent[$adminsStart..($usersStart-3)].Trim() | Where-Object { $_ }
$authorizedUsers = $usersFileContent[$usersStart..($usersFileContent.Count-1)].Trim() | Where-Object { $_ }

# Get the list of current user accounts on the system, excluding default accounts
$currentUserAccounts = Get-LocalUser | Where-Object { $_.Name -notmatch "^(Administrator|DefaultAccount|Guest|WDAGUtilityAccount)$" } | Select-Object -ExpandProperty Name

# Ensure only authorized admins are in the Administrators group
$currentAdmins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name
$unauthorizedAdmins = $currentAdmins | Where-Object { $authorizedAdmins -notcontains $_ -and $_ -notmatch "^(Administrator|DefaultAccount|Guest|WDAGUtilityAccount)$" }
foreach ($admin in $unauthorizedAdmins) {
    Write-Host "Removing Admin Priv: $admin"
    Remove-LocalGroupMember -Group "Administrators" -Member $admin -ErrorAction SilentlyContinue
}


# Add missing authorized users
$missingUsers = $authorizedUsers | Where-Object { $currentUserAccounts -notcontains $_ }
foreach ($user in $missingUsers) {
    # Note: Creating user without password; may need to add password creation logic
    Write-Host "Adding: $user"
    New-LocalUser -Name $user -AccountNeverExpires -NoPassword -ErrorAction SilentlyContinue
}

# Remove unauthorized users
$unauthorizedUsers = $currentUserAccounts | Where-Object { $authorizedUsers -notcontains $_ -and $authorizedAdmins -notcontains $_ }
foreach ($user in $unauthorizedUsers) {
    Write-Host "Removing: $user"
    Remove-LocalUser -Name $user -ErrorAction SilentlyContinue
}


$missingAdmins = $authorizedAdmins | Where-Object { $currentAdmins -notcontains $_ }
foreach ($admin in $missingAdmins) {
    Write-Host "Adding Admin: $admin"
    Add-LocalGroupMember -Group "Administrators" -Member $admin -ErrorAction SilentlyContinue
}

# Output completion message
Write-Host "User accounts have been updated according to the authorized list."

Write-Host "Now Changing Passwords:"

$Password = ConvertTo-SecureString "aPASSWORD1234!" -AsPlainText -Force
$UserAccounts = Get-LocalUser

foreach ($UserAccount in $UserAccounts) {
    try {
        $UserAccount | Set-LocalUser -Password $Password
        Write-Output "Password for $($UserAccount.Name) has been changed."
    } catch {
        Write-Output "Failed to change password for $($UserAccount.Name)."
    }
}

