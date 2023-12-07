try{
# Configure IIS
Stop-Service "W3SVC"
Set-Service -Name "W3SVC" -StartupType Disabled

# Configure SMB
Set-Service -Name "LanmanServer" -StartupType Automatic
Set-Acl -Path "C:\" -FileSystemRights FullControl -Account "Everyone" -Remove
Set-SmbShare -Name "C$" -Path "C:\" -ReadAccess @{} -FullControlAccess @{}

# Configure SMTP
Stop-Service "SmtpSvc"
Set-Service -Name "SmtpSvc" -StartupType Disabled

# Configure FTP (Microsoft)
Stop-Service "MSFTPSVC"
Set-Service -Name "MSFTPSVC" -StartupType Disabled

# Configure FTP (FileZilla)
# Assumes FileZilla server is not running
Stop-Service "FileZilla Server"
Set-Service -Name "FileZilla Server" -StartupType Disabled

# Configure DNS
# This assumes you have configured DNS server addresses manually
Set-Service -Name "DNSServer" -StartupType Automatic

# Configure RDP
Stop-Service "TermService"
Set-Service -Name "TermService" -StartupType Disabled

# Configure firewall rules for services
# Replace with specific rules for each service

New-NetFirewallRule -Name "Allow_IIS" -DisplayName "Allow IIS Traffic" -Profile Any -Direction Inbound -Protocol TCP -LocalPort 80,443 -Action Allow

New-NetFirewallRule -Name "Allow_SMB_FileSharing" -DisplayName "Allow SMB File Sharing" -Profile Any -Direction Inbound -Protocol TCP -LocalPort 445 -Action Allow
New-NetFirewallRule -Name "Allow_SMB_RemoteManagement" -DisplayName "Allow SMB Remote Management" -Profile Any -Direction Inbound -Protocol TCP -LocalPort 139 -Action Allow

# Add additional firewall rules for specific services

# Write a log file with service status
$services = Get-Service -Name "W3SVC","LanmanServer","SmtpSvc","MSFTPSVC","FileZilla Server","DNSServer","TermService"
$logFile = "C:\service_status.log"
Out-File -FilePath $logFile -InputObject $services

Write-Host "Services configured successfully!"
}

catch{
Write-Host "Stopping Services Failed"

}