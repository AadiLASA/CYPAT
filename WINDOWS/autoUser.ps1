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

# Add missing authorized users
$missingUsers = $authorizedUsers | Where-Object { $currentUserAccounts -notcontains $_ }
foreach ($user in $missingUsers) {
    New-LocalUser -Name $user -NoPassword -AccountNeverExpires -UserMayNotChangePassword -PasswordNeverExpires
}

# Remove unauthorized users
$unauthorizedUsers = $currentUserAccounts | Where-Object { $authorizedUsers -notcontains $_ -and $authorizedAdmins -notcontains $_ }
foreach ($user in $unauthorizedUsers) {
    Remove-LocalUser -Name $user
}

# Ensure only authorized admins are in the Administrators group
$currentAdmins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name
$unauthorizedAdmins = $currentAdmins | Where-Object { $authorizedAdmins -notcontains $_ -and $_ -notmatch "^(Administrator|DefaultAccount|Guest|WDAGUtilityAccount)$" }
foreach ($admin in $unauthorizedAdmins) {
    Remove-LocalGroupMember -Group "Administrators" -Member $admin
}

$missingAdmins = $authorizedAdmins | Where-Object { $currentAdmins -notcontains $_ }
foreach ($admin in $missingAdmins) {
    Add-LocalGroupMember -Group "Administrators" -Member $admin
}

# Output completion message
Write-Host "User accounts have been updated according to the authorized list."
