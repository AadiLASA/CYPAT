# Function to configure system access settings
function Set-SystemAccessSettings {
    param (
        [int]$MinimumPasswordAge = 30,
        [int]$MaximumPasswordAge = 90,
        [int]$MinimumPasswordLength = 10,
        [int]$PasswordComplexity = 1,
        [int]$PasswordHistorySize = 5,
        [int]$LockoutBadCount = 5,
        [int]$ResetLockoutCount = 30,
        [int]$LockoutDuration = 30,
        [int]$AllowAdministratorLockout = 1,
        [int]$RequireLogonToChangePassword = 0,
        [int]$ForceLogoffWhenHourExpire = 1,
        [string]$NewAdministratorName = "Administrator",
        [string]$NewGuestName = "Guest",
        [int]$ClearTextPassword = 0,
        [int]$LSAAnonymousNameLookup = 0,
        [int]$EnableAdminAccount = 0,
        [int]$EnableGuestAccount = 0
    )

    # Your implementation here...
    # Set the system access settings using the provided parameters
    # Example:
    # Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LSA' -Name 'EnableAdminAccount' -Value $EnableAdminAccount
    # Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LSA' -Name 'EnableGuestAccount' -Value $EnableGuestAccount
    # ...

    Write-Host "System Access settings configured."
}

# Function to configure event audit settings
function Set-EventAuditSettings {
    param (
        [int]$AuditSystemEvents = 3,
        [int]$AuditLogonEvents = 3,
        [int]$AuditObjectAccess = 3,
        [int]$AuditPrivilegeUse = 3,
        [int]$AuditPolicyChange = 3,
        [int]$AuditAccountManage = 3,
        [int]$AuditProcessTracking = 3,
        [int]$AuditDSAccess = 3,
        [int]$AuditAccountLogon = 3
    )

    # Your implementation here...
    # Set the event audit settings using the provided parameters
    # Example:
    # Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Eventlog\Security' -Name 'AuditSystemEvents' -Value $AuditSystemEvents
    # Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Eventlog\Security' -Name 'AuditLogonEvents' -Value $AuditLogonEvents
    # ...

    Write-Host "Event Audit settings configured."
}



# Function to configure additional system settings
function Set-AdditionalSystemSettings {
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Setup\RecoveryConsole' -Name 'SecurityLevel' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Setup\RecoveryConsole' -Name 'SetCommand' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'AllocateDASD' -Value 1,"2"
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'CachedLogonsCount' -Value 1,"4"
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'ForceUnlockLogon' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'PasswordExpiryWarning' -Value 4,5
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name 'ScRemoveOption' -Value 1,"1"
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin' -Value 4,2
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorUser' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DisableCAD' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DontDisplayLastUserName' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableInstallerDetection' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLUA' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableSecureUIAPaths' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableUIADesktopToggle' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableVirtualization' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'FilterAdministratorToken' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'InactivityTimeoutSecs' -Value 4,900
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters' -Name 'SupportedEncryptionTypes' -Value 4,2147483640
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'LegalNoticeCaption' -Value 1,""
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'LegalNoticeText' -Value 7,""
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'MaxDevicePasswordFailedAttempts' -Value 4,10
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'NoConnectedUser' -Value 4,3
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'PromptOnSecureDesktop' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ScForceOption' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ShutdownWithoutLogon' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'UndockWithoutLogon' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ValidateAdminCodeSignatures' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Cryptography' -Name 'ForceKeyProtection' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\Safer\CodeIdentifiers' -Name 'AuthenticodeEnabled' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'AuditBaseObjects' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'CrashOnAuditFail' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'DisableDomainCreds' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'EveryoneIncludesAnonymous' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy' -Name 'Enabled' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'ForceGuest' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'FullPrivilegeAuditing' -Value 3,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'LimitBlankPasswordUse' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'LmCompatibilityLevel' -Value 4,5
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0\allownullsessionfallback' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0' -Name 'NTLMMinClientSec' -Value 4,536870912
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0' -Name 'NTLMMinServerSec' -Value 4,536870912
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'NoLMHash' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa\pku2u' -Name 'AllowOnlineID' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'RestrictAnonymous' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'RestrictAnonymousSAM' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'RestrictRemoteSAM' -Value 1,"O:BAG:BAD:(A;;RC;;;BA)"
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'SCENoApplyLegacyAuditPolicy' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Lsa' -Name 'UseMachineId' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers' -Name 'AddPrinterDrivers' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedExactPaths\Machine' -Name '7,System\CurrentControlSet\Control\ProductOptions,System\CurrentControlSet\Control\Server Applications,Software\Microsoft\Windows NT\CurrentVersion'
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedPaths\Machine' -Name '7,System\CurrentControlSet\Control\Print\Printers,System\CurrentControlSet\Services\Eventlog,Software\Microsoft\OLAP Server,Software\Microsoft\Windows NT\CurrentVersion\Print,Software\Microsoft\Windows NT\CurrentVersion\Windows,System\CurrentControlSet\Control\ContentIndex,System\CurrentControlSet\Control\Terminal Server,System\CurrentControlSet\Control\Terminal Server\UserConfig,System\CurrentControlSet\Control\Terminal Server\DefaultUserConfiguration,Software\Microsoft\Windows NT\CurrentVersion\Perflib,System\CurrentControlSet\Services\SysmonLog'
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Session Manager\Kernel' -Name 'ObCaseInsensitive' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management' -Name 'ClearPageFileAtShutdown' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Session Manager' -Name 'ProtectionMode' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Session Manager\SubSystems' -Name 'optional' -Value 7,""
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters' -Name 'AutoDisconnect' -Value 4,15
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters' -Name 'EnableForcedLogOff' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters' -Name 'EnableS4U2SelfForClaims' -Value 4,2
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters' -Name 'EnableSecuritySignature' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters' -Name 'NullSessionPipes' -Value 7,""
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters' -Name 'NullSessionShares' -Value 7,""
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters' -Name 'RequireSecuritySignature' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters' -Name 'RestrictNullSessAccess' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters' -Name 'SmbServerNameHardeningLevel' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanmanWorkstation\Parameters' -Name 'EnablePlainTextPassword' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanmanWorkstation\Parameters' -Name 'EnableSecuritySignature' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LanmanWorkstation\Parameters' -Name 'RequireSecuritySignature' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\LDAP' -Name 'LDAPClientIntegrity' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name 'DisablePasswordChange' -Value 4,0
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name 'MaximumPasswordAge' -Value 4,30
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name 'RequireSignOrSeal' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name 'RequireStrongKey' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name 'SealSecureChannel' -Value 4,1
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name 'SignSecureChannel' -Value
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters' -Name 'SignSecureChannel' -Value 4,1
}

# Function to configure privilege rights
function Set-PrivilegeRights {
    $privilegeSettings = @{
        'SeNetworkLogonRight' = @('*S-1-5-32-544', '*S-1-5-32-551'),
        'SeBackupPrivilege' = @('*S-1-5-32-544'),
        'SeChangeNotifyPrivilege' = @('*S-1-1-0', '*S-1-5-19', '*S-1-5-20', 'SQLServerSQLAgentUser$DESKTOP-TFPSHUC$MICROSOFTSCM', '*S-1-5-32-544', '*S-1-5-32-545', '*S-1-5-32-551', '*S-1-5-80-4088968713-3996793557-1094459843-3841239138-1846155210'),
        'SeSystemtimePrivilege' = @('*S-1-5-19', '*S-1-5-32-544'),
        'SeCreatePagefilePrivilege' = @('*S-1-5-32-544'),
        'SeDebugPrivilege' = @('*S-1-5-32-544'),
        'SeRemoteShutdownPrivilege' = @('*S-1-5-32-544'),
        'SeAuditPrivilege' = @('*S-1-5-19', '*S-1-5-20'),
        'SeIncreaseQuotaPrivilege' = @('*S-1-5-19', '*S-1-5-20', 'SQLServerSQLAgentUser$DESKTOP-TFPSHUC$MICROSOFTSCM', '*S-1-5-32-544', '*S-1-5-80-4088968713-3996793557-1094459843-3841239138-1846155210'),
        'SeIncreaseBasePriorityPrivilege' = @('*S-1-5-32-544', '*S-1-5-90-0'),
        'SeLoadDriverPrivilege' = @('*S-1-5-32-544'),
        'SeBatchLogonRight' = @('*S-1-5-32-544'),
        'SeServiceLogonRight' = @('*S-1-5-20', 'SQLServer2005SQLBrowserUser$DESKTOP-TFPSHUC', 'SQLServerSQLAgentUser$DESKTOP-TFPSHUC$MICROSOFTSCM', '*S-1-5-80-0', '*S-1-5-80-4088968713-3996793557-1094459843-3841239138-1846155210'),
        'SeInteractiveLogonRight' = @('*S-1-5-32-544', '*S-1-5-32-545'),
        'SeSecurityPrivilege' = @('*S-1-5-32-544'),
        'SeSystemEnvironmentPrivilege' = @('*S-1-5-32-544'),
        'SeProfileSingleProcessPrivilege' = @('*S-1-5-32-544'),
        'SeSystemProfilePrivilege' = @('*S-1-5-32-544', '*S-1-5-80-3139157870-2983391045-3678747466-658725712-1809340420'),
        'SeAssignPrimaryTokenPrivilege' = @('*S-1-5-19', '*S-1-5-20', 'SQLServerSQLAgentUser$DESKTOP-TFPSHUC$MICROSOFTSCM', '*S-1-5-80-4088968713-3996793557-1094459843-3841239138-1846155210'),
        'SeRestorePrivilege' = @('*S-1-5-32-544'),
        'SeShutdownPrivilege' = @('*S-1-5-32-544', '*S-1-5-32-545'),
        'SeTakeOwnershipPrivilege' = @('*S-1-5-32-544'),
        'SeDenyNetworkLogonRight' = @('*S-1-5-113', 'Guest'),
        'SeDenyBatchLogonRight' = @('Guest'),
        'SeDenyServiceLogonRight' = @('Guest'),
        'SeDenyInteractiveLogonRight' = @('Guest'),
        'SeUndockPrivilege' = @('*S-1-5-32-544', '*S-1-5-32-545'),
        'SeManageVolumePrivilege' = @('*S-1-5-32-544'),
        'SeRemoteInteractiveLogonRight' = @('*S-1-5-32-544', '*S-1-5-32-555'),
        'SeDenyRemoteInteractiveLogonRight' = @('*S-1-5-113', 'Guest'),
        'SeImpersonatePrivilege' = @('*S-1-5-19', '*S-1-5-20', '*S-1-5-32-544', '*S-1-5-6'),
        'SeCreateGlobalPrivilege' = @('*S-1-5-19', '*S-1-5-20', '*S-1-5-32-544', '*S-1-5-6'),
        'SeIncreaseWorkingSetPrivilege' = @('*S-1-5-32-545'),
        'SeTimeZonePrivilege' = @('*S-1-5-19', '*S-1-5-32-544', '*S-1-5-32-545'),
        'SeCreateSymbolicLinkPrivilege' = @('*S-1-5-32-544'),
        'SeDelegateSessionUserImpersonatePrivilege' = @('*S-1-5-32-544')
    }

    foreach ($privilege in $privilegeSettings.Keys) {
        $values = $privilegeSettings[$privilege]
        $path = "SeSecurityPolicyPrivilege\$privilege"
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Lsa\$path" -Name "4,0" -Value $values
    }
}

# Call the function to set privilege rights
Set-PrivilegeRights
# Call the function to set additional system settings
Set-AdditionalSystemSettings
# Call the functions without providing any parameters
Set-SystemAccessSettings
Set-EventAuditSettings
