# PowerShell Script for Security Logging
mkdir "C:\Logs"
# Define log file path
$LogFilePath = "C:\Logs\SecurityAuditLog.txt"

# Function to append text to the log file
function Write-ToLog {
    Param ([string]$Text)
    Add-Content -Path $LogFilePath -Value $Text
}

# Capture current date and time
$DateTime = Get-Date
Write-ToLog "Security Audit Log - $DateTime"

# Log File Shares
Write-ToLog "----- File Shares -----"
Get-SmbShare | ForEach-Object {
    Write-ToLog $_.Name
}

# Check for existence of SMB Shares
Write-ToLog "----- SMB Shares Check -----"
$smbShares = Get-SmbShare
if ($smbShares.Count -eq 0) {
    Write-ToLog "No SMB Shares found."
} else {
    $smbShares | ForEach-Object {
        Write-ToLog $_.Name
    }
}

# Log Instances of Users with Elevated Privileges
Write-ToLog "----- Users with Elevated Privileges -----"
$usersWithAdmin = Get-LocalGroupMember -Group "Administrators" | Select-Object -ExpandProperty Name
foreach ($user in $usersWithAdmin) {
    Write-ToLog $user
}

# Additional Security Checks (Example: Unauthorized Scheduled Tasks)
Write-ToLog "----- Unauthorized Scheduled Tasks -----"
Get-ScheduledTask | Where-Object { $_.Principal.RunLevel -eq 'Highest' } | ForEach-Object {
    Write-ToLog $_.TaskName
}

# Log Instances of Inappropriate User Access to Other User Directories
Write-ToLog "----- Inappropriate User Access to Other User Directories -----"

# Get list of user profiles
$userProfiles = Get-ChildItem C:\Users -Directory

foreach ($profile in $userProfiles) {
    $userDir = $profile.FullName
    $acl = Get-Acl $userDir

    foreach ($access in $acl.Access) {
        if ($access.FileSystemRights -like "*FullControl*" -or $access.FileSystemRights -like "*Modify*") {
            if ($access.IdentityReference -notlike "BUILTIN\Administrators" -and $access.IdentityReference -notlike "NT AUTHORITY\SYSTEM" -and $access.IdentityReference -notlike $profile.Name) {
                $logEntry = "User $($access.IdentityReference) has $($access.FileSystemRights) access to $userDir"
                Write-ToLog $logEntry
            }
        }
    }
}

# PowerShell Script to Log ACLs of User Directories

# Path to the Users directory
$usersDir = "C:\Users"

# Output file
$outputFile = "C:\Logs\USERACLS.txt"

# Get all user directories
$userDirectories = Get-ChildItem -Path $usersDir -Directory

# Write ACLs to the output file
foreach ($dir in $userDirectories) {
    $acl = Get-Acl -Path $dir.FullName
    $acl | Out-File -FilePath $outputFile -Append
    Add-Content -Path $outputFile -Value "`n" # Add a new line for separation
}

Write-Host "ACLs logged to $outputFile"



# End of Script
Write-ToLog "----- End of Security Audit Log -----"
