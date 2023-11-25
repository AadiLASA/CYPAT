# Read the users.txt file
$authorized = Get-Content -Path .\users.txt

# Split the file into admins and users
$admins = $authorized[($authorized.IndexOf("Authorized Administrators:") + 1)..($authorized.IndexOf("Authorized Users:") - 1)]
$users = $authorized[($authorized.IndexOf("Authorized Users:") + 1)..$authorized.Count]

# Get the current users and admins from the system
$currentUsers = Get-LocalUser | Where-Object { $_.Enabled -eq $True } | ForEach-Object { $_.Name }
$currentAdmins = Get-LocalGroupMember -Group "Administrators" | ForEach-Object { $_.Name.Split('\')[-1] }

# Determine which users to add, delete, promote, or demote
$usersToAdd = Compare-Object -ReferenceObject $currentUsers -DifferenceObject ($admins + $users) | Where-Object { $_.SideIndicator -eq "=>" } | ForEach-Object { $_.InputObject }
$usersToDelete = Compare-Object -ReferenceObject $currentUsers -DifferenceObject ($admins + $users) | Where-Object { $_.SideIndicator -eq "<=" } | ForEach-Object { $_.InputObject }
$adminsToPromote = Compare-Object -ReferenceObject $currentAdmins -DifferenceObject $admins | Where-Object { $_.SideIndicator -eq "=>" } | ForEach-Object { $_.InputObject }
$adminsToDemote = Compare-Object -ReferenceObject $currentAdmins -DifferenceObject $admins | Where-Object { $_.SideIndicator -eq "<=" } | ForEach-Object { $_.InputObject }

# Output the results
Write-Output "Users to Add: `n$($usersToAdd -join ', ')"
Write-Output "Users to Delete: `n$($usersToDelete -join ', ')"
Write-Output "Admins to Promote: `n$($adminsToPromote -join ', ')"
Write-Output "Admins to Demote: `n$($adminsToDemote -join ', ')"
