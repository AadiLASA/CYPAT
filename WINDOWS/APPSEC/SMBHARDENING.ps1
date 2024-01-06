# PowerShell Script to Harden SMB on Windows 10 for Enterprise and STIG/CIS Standards

# Ensure the script is run with administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run this script as an Administrator!"
    break
}

# Disable SMBv1 Client
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10" -Name "Start" -Value 4
# Explanation: SMBv1 is outdated and vulnerable. Disabling it enhances security.

# Disable SMBv1 Server
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "SMB1" -Value 0
# Explanation: Prevents the server from using SMBv1, mitigating security risks.

# Remove SMBv1 Windows Feature
Remove-WindowsFeature FS-SMB1 -NoRestart
# Explanation: Completely removes SMBv1 support from Windows, which is a less secure protocol.

# Adjust Service Settings
Set-Service -Name LanmanWorkstation -StartupType Disabled
# Explanation: Disables the workstation service to prevent the system from creating SMB client connections.

# Harden SMB Client Configuration
Set-SmbClientConfiguration -ConnectionCountPerRssNetworkInterface 4 -DirectoryCacheEntriesMax 16 -DirectoryCacheEntrySizeMax 65536 -DirectoryCacheLifetime 10 -DormantFileLimit 1023 -EnableBandwidthThrottling $true -EnableByteRangeLockingOnReadOnlyFiles $true -EnableInsecureGuestLogons $false -EnableLargeMtu $true -EnableLoadBalanceScaleOut $true -EnableMultiChannel $true -EnableSecuritySignature $true -ExtendedSessionTimeout 1000 -FileInfoCacheEntriesMax 64 -FileInfoCacheLifetime 10 -FileNotFoundCacheEntriesMax 128 -FileNotFoundCacheLifetime 5 -KeepConn 600 -MaxCmds 50 -MaximumConnectionCountPerServer 32 -OplocksDisabled $false -RequireSecuritySignature $true -SessionTimeout 60 -UseOpportunisticLocking $true -WindowSizeThreshold 8 -Force
# Explanation: Optimizes and secures the SMB client with enterprise and STIG/CIS standards.

# Harden SMB Server Configuration
Set-SmbServerConfiguration -AnnounceServer $false -AsynchronousCredits 64 -AuditSmb1Access $false -AutoDisconnectTimeout 15 -AutoShareServer $true -AutoShareWorkstation $true -CachedOpenLimit 10 -DurableHandleV2TimeoutInSeconds 180 -EnableAuthenticateUserSharing $false -EnableDownlevelTimewarp $false -EnableForcedLogoff $true -EnableLeasing $true -EnableMultiChannel $true -EnableOplocks $true -EnableSecuritySignature $true -EnableSMB1Protocol $false -EnableSMB2Protocol $true -EnableStrictNameChecking $true -EncryptData $true -IrpStackSize 15 -KeepAliveTime 2 -MaxChannelPerSession 32 -MaxMpxCount 50 -MaxSessionPerConnection 16384 -MaxThreadsPerQueue 20 -MaxWorkItems 1 -OplockBreakWait 35 -PendingClientTimeoutInSeconds 120 -RejectUnencryptedAccess $true -RequireSecuritySignature $true -ServerHidden $true -Smb2CreditsMax 2048 -Smb2CreditsMin 128 -SmbServerNameHardeningLevel 0 -TreatHostAsStableStorage $false -ValidateAliasNotCircular $true -ValidateShareScope $true -ValidateShareScopeNotAliased $true -ValidateTargetName $true -Force
# Explanation: Secures the SMB server with a focus on encryption, security signatures, and disabling vulnerable protocols.

Write-Host "Settings Applied! Please restart comptuer to see effects" -ForegroundColor Green
