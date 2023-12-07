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




# Define the services and their recommended settings
$services = @{
    "AXInstSV" = "Disabled"
    "AdobeARMservice" = "Disabled"
    "AxInstSV" = "Disabled"
    "CscService" = "Disabled"
    "Dfs" = "Disabled"
    "ERSvc" = "Disabled"
    "EventSystem" = "Automatic"
    "HomeGroupListener" = "Disabled"
    "HomeGroupProvider" = "Disabled"
    "IPBusEnum" = "Disabled"
    "Iisadmin" = "Disabled"
    "IsmServ" = "Disabled"
    "MSDTC" = "Disabled"
    "MSSQLServerADHelper" = "Disabled"
    "Messenger" = "Disabled"
    "Msftpsvc" = "Disabled"
    "NetTcpPortSharing" = "Disabled"
    "Netlogon" = "Disabled"
    "NtFrs" = "Disabled"
    "PolicyAgent" = "Automatic"
    "RDSessMgr" = "Disabled"
    "RSoPProv" = "Not Change"
    "RasAuto" = "Disabled"
    "RasMan" = "Manual"
    "RemoteAccess" = "Disabled"
    "RpcSs" = "Automatic"
    "SCardSvr" = "Disabled"
    "SENS" = "Automatic"
    "SSDPSRV" = "Disabled"
    "Sacsvr" = "Disabled"
    "Server" = "Automatic"
    "SessionEnv" = "Not Change"
    "SharedAccess" = "Disabled"
    "Smtpsvc" = "Disabled"
    "Spooler" = "Automatic"
    "SysMain" = "Automatic"
    "TabletInputService" = "Manual"
    "TapiSrv" = "Manual"
    "TeamViewer" = "Disabled"
    "TeamViewer7" = "Disabled"
    "TermService" = "Manual"
    "Themes" = "Automatic"
    "TrkWks" = "Automatic"
    "UmRdpService" = "Disabled"
    "VDS" = "Manual"
    "VSS" = "Manual"
    "W3svc" = "Disabled"
    "WAS" = "Disabled"
    "WINS" = "Disabled"
    "WmdmPmSN" = "Disabled"
    "XblAuthManager" = "Disabled"
    "XblGameSave" = "Disabled"
    "XboxGipSvc" = "Disabled"
    "fax" = "Disabled"
    "ftpsvc" = "Disabled"
    "helpsvc" = "Disabled"
    "hidserv" = "Manual"
    "iphlpsvc" = "Automatic"
    "iprip" = "Disabled"
    "lanmanserver" = "Automatic"
    "lltdsvc" = "Disabled"
    "mnmsrvc" = "Disabled"
    "msftpsvc" = "Disabled"
    "nfsclnt" = "Disabled"
    "nfssvc" = "Disabled"
    "p2pimsvc" = "Disabled"
    "remoteregistry" = "Disabled"
    "seclogon" = "Automatic"
    "sessionenv" = "Not Change"
    "simptcp" = "Disabled"
    "snmptrap" = "Disabled"
    "ssdpsrv" = "Disabled"
    "termservice" = "Manual"
    "tlntsvr" = "Disabled"
    "uploadmgr" = "Disabled"
    "upnphos" = "Disabled"
    "upnphost" = "Disabled"
    "xbgm" = "Disabled"
    "xboxgip" = "Disabled"
}

# Apply the recommended settings
foreach ($service in $services.GetEnumerator()) {
    $serviceName = $service.Name
    $serviceSetting = $service.Value

    Write-Host "Setting $serviceName to $serviceSetting..."
    try {
        Set-Service -Name $serviceName -StartupType $serviceSetting
    } catch {
        Write-Host "Failed to set $serviceName to $serviceSetting. Error: $_"
    }
}
