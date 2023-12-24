# Define the path to the input file
$usersFilePath = "users.txt"

# Read the content of the file
$usersFileContent = Get-Content -Path $usersFilePath

# Separate the content into administrators and users
$adminsStart = $usersFileContent.IndexOf("Authorized Administrators") + 1
$usersStart = $usersFileContent.IndexOf("Authorized Users") + 1

$authorizedAdmins = $usersFileContent[$adminsStart..($usersStart-3)].Trim() | Where-Object { $_ -ne "" }
$authorizedUsers = $usersFileContent[$usersStart..($usersFileContent.Count-1)].Trim() | Where-Object { $_ -ne "" }

# Get the list of current user accounts on the system, excluding default accounts
$currentUserAccounts = Get-LocalUser | Where-Object { $_.Name -notmatch "^(Administrator|DefaultAccount|Guest|WDAGUtilityAccount)$" } | Select-Object -ExpandProperty Name

# Add missing authorized users
$missingUsers = $authorizedUsers | Where-Object { $_ -and $currentUserAccounts -notcontains $_ }
foreach ($user in $missingUsers) {
    # Add the user here with appropriate cmdlets, e.g., New-LocalUser
}

# Remove unauthorized users
$unauthorizedUsers = $currentUserAccounts | Where-Object { $authorizedUsers -notcontains $_ -and $authorizedAdmins -notcontains $_ }
foreach ($user in $unauthorizedUsers) {
    # Remove the user here with appropriate cmdlets, e.g., Remove-LocalUser
}

# Ensure only authorized admins are in the Administrators group
$currentAdmins = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name
$unauthorizedAdmins = $currentAdmins | Where-Object { $authorizedAdmins -notcontains $_ -and $_ -notmatch "^(Administrator|DefaultAccount|Guest|WDAGUtilityAccount)$" }
foreach ($admin in $unauthorizedAdmins) {
    # Remove the user from the Administrators group here, e.g., Remove-LocalGroupMember
}

$missingAdmins = $authorizedAdmins | Where-Object { $currentAdmins -notcontains $_ }
foreach ($admin in $missingAdmins) {
    # Add the user to the Administrators group here, e.g., Add-LocalGroupMember
}

# Output completion message
Write-Host "User accounts have been updated according to the authorized list."
