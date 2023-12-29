# Define a list of services with their desired state from the CIS benchmark images
    #TlntSvr = telnet  -disabled
    #Msftpsvc = microsoft ftp -disabled
    #ftpsvc = ftp -disabled
    #Smtpsvc = SMTP service -disabled
    #Termservice = remote desktop -disabled
    #LanmanServer = SMB -disabled
    #Windows Firewall = mpssvc - enabled
    #Windows Update Service = WUAUSERV -enabled

$serviceConfigurations = @{
    "BTAGService" = "Disabled"
    "bthserv" = "Disabled"
    "Browser" = "Disabled"
    "MapsBroker" = "Disabled"
    "DPS" = "Disabled"
    "IISADMIN" = "Disabled"
    "irmon" = "Disabled"
    "SharedAccess" = "Disabled"
    "lltdsvc" = "Disabled"
    "LxssManager" = "Disabled"
    "FTPSVC" = "Disabled"
    "MSiSCSI" = "Disabled"
    "ssh" = "Disabled"
    "PNRPSvc" = "Disabled"
    "p2pimsvc" = "Disabled"
    "PNRPAutoReg" = "Disabled"
    "Spooler" = "Disabled"
    "wercplsupport" = "Disabled"
    "RasAuto" = "Disabled"
    "SessionEnv" = "Disabled"
    "TermService" = "Disabled"
    "UmRdpService" = "Disabled"
    "RpcLocator" = "Disabled"
    "RemoteRegistry" = "Disabled"
    "RemoteAccess" = "Disabled"
    "LanmanServer" = "Disabled"
    "simptcp" = "Disabled"
    "SNMP" = "Disabled"
    "sacsvr" = "Disabled"
    "SSDPSRV" = "Disabled"
    "upnphost" = "Disabled"
    "WMSvc" = "Disabled"
    "WerSvc" = "Disabled"
    "Wecsvc" = "Disabled"
    "WMPNetworkSvc" = "Disabled"
    "icssvc" = "Disabled"
    "WpnService" = "Disabled"
    "PushToInstall" = "Disabled"
    "WinRM" = "Disabled"
    "W3SVC" = "Disabled"
    "XboxGipSvc" = "Disabled"
    "XblAuthManager" = "Disabled"
    "XblGameSave" = "Disabled"
    "XboxNetApiSvc" = "Disabled"
}

# Apply the configurations
foreach ($service in $serviceConfigurations.GetEnumerator()) {
    $serviceName = $service.Key
    $desiredState = $service.Value

    # Check if the service exists
    $existingService = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($existingService) {
        try {
            # Attempt to set the startup type of the service
            Set-Service -Name $serviceName -StartupType $desiredState -ErrorAction Stop
            Write-Host "Service $serviceName set to $desiredState."
        } catch {
            Write-Warning "Could not set $serviceName to $desiredState. It might not be changeable or does not exist."
        }
    } else {
        Write-Warning "Service $serviceName does not exist and will be skipped."
    }
}

Write-Host "Service configurations have been applied according to CIS benchmarks."
