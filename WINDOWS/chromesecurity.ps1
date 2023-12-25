# PowerShell Script to Apply Chrome CIS Settings - Section 1

# Define the path for Chrome policies in the registry
$chromePoliciesPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"

# Create the policy path if it doesn't exist
if (-not (Test-Path $chromePoliciesPath)) {
    New-Item -Path $chromePoliciesPath -Force
}

# Function to set a Chrome policy in the registry
function Set-ChromePolicy {
    param (
        [string]$PolicyName,
        [string]$PolicyType,
        $PolicyValue
    )

    $policyPath = Join-Path -Path $chromePoliciesPath -ChildPath $PolicyName

    if ($PolicyType -eq "String") {
        New-ItemProperty -Path $chromePoliciesPath -Name $PolicyName -Value $PolicyValue -PropertyType String -Force
    } elseif ($PolicyType -eq "Dword") {
        New-ItemProperty -Path $chromePoliciesPath -Name $PolicyName -Value $PolicyValue -PropertyType DWord -Force
    }
}

# Apply CIS recommended settings
# 1.1.1 Ensure 'Cross-origin HTTP Authentication prompts' is set to 'Disabled'
Set-ChromePolicy -PolicyName "CrossOriginAuthPrompt" -PolicyType "Dword" -PolicyValue 0

# 1.2.1 Ensure 'Configure the list of domains on which Safe Browsing will not trigger warnings' is set to 'Disabled'
Set-ChromePolicy -PolicyName "SafeBrowsingWhitelistDomains" -PolicyType "String" -PolicyValue ""

# 1.2.2 Ensure 'Safe Browsing Protection Level' is set to 'Enabled: Standard Protection' or higher
# Note: This setting requires manual configuration as it's not directly translatable to a registry key.

# 1.3 Ensure 'Allow Google Cast to connect to Cast devices on all IP addresses' is set to 'Disabled'
Set-ChromePolicy -PolicyName "CastAllowAllIPs" -PolicyType "Dword" -PolicyValue 0

# 1.4 Ensure 'Allow queries to a Google time service' is set to 'Enabled'
Set-ChromePolicy -PolicyName "QuicAllowed" -PolicyType "Dword" -PolicyValue 1

# 1.5 Ensure 'Allow the audio sandbox to run' is set to 'Enabled'
Set-ChromePolicy -PolicyName "AudioSandboxEnabled" -PolicyType "Dword" -PolicyValue 1

# 1.6 Ensure 'Ask where to save each file before downloading' is set to 'Enabled'
Set-ChromePolicy -PolicyName "PromptForDownloadLocation" -PolicyType "Dword" -PolicyValue 1

# 1.7 Ensure 'Continue running background apps when Google Chrome is closed' is set to 'Disabled'
Set-ChromePolicy -PolicyName "BackgroundModeEnabled" -PolicyType "Dword" -PolicyValue 0

# 1.8 Ensure 'Control SafeSites adult content filtering' is set to 'Enabled: Filter top level sites'
# Note: This setting requires a specific value or manual configuration.

# 1.9 Ensure 'Determine the availability of variations' is set to 'Disabled'
# Note: This setting might require manual configuration or a different approach.

# 1.10 Ensure 'Disable Certificate Transparency enforcement for a list of Legacy Certificate Authorities' is set to 'Disabled'
Set-ChromePolicy -PolicyName "CertificateTransparencyEnforcementDisabledForLegacyCas" -PolicyType "Dword" -PolicyValue 0

# Continuation of the PowerShell script for Chrome CIS settings

# ... previous settings ...

# 1.11 Ensure 'Disable saving browser history' is set to 'Disabled'
Set-ChromePolicy -PolicyName "SavingBrowserHistoryDisabled" -PolicyType "Dword" -PolicyValue 0

# 1.12 Ensure 'DNS interception checks enabled' is set to 'Enabled'
Set-ChromePolicy -PolicyName "DnsInterceptionChecksEnabled" -PolicyType "Dword" -PolicyValue 1

# 1.13 Ensure 'Enable component updates in Google Chrome' is set to 'Enabled'
Set-ChromePolicy -PolicyName "ComponentUpdatesEnabled" -PolicyType "Dword" -PolicyValue 1

# 1.14 Ensure 'Enable globally scoped HTTP auth cache' is set to 'Disabled'
Set-ChromePolicy -PolicyName "GloballyScopedHTTPAuthCacheEnabled" -PolicyType "Dword" -PolicyValue 0

# 1.15 Ensure 'Enable online OCSP/CRL checks' is set to 'Disabled'
Set-ChromePolicy -PolicyName "OnlineRevocationChecksEnabled" -PolicyType "Dword" -PolicyValue 0

# 1.16 Ensure 'Enable Renderer Code Integrity' is set to 'Enabled'
Set-ChromePolicy -PolicyName "RendererCodeIntegrityEnabled" -PolicyType "Dword" -PolicyValue 1

# 1.17 Ensure 'Enable security warnings for command-line flags' is set to 'Enabled'
Set-ChromePolicy -PolicyName "CommandLineFlagSecurityWarningsEnabled" -PolicyType "Dword" -PolicyValue 1

# 1.18 Ensure 'Enable third party software injection blocking' is set to 'Enabled'
Set-ChromePolicy -PolicyName "ThirdPartySoftwareInjectionBlocking" -PolicyType "Dword" -PolicyValue 1

# 1.19 Ensure 'Enables managed extensions to use the Enterprise Hardware Platform API' is set to 'Disabled'
Set-ChromePolicy -PolicyName "EnterpriseHardwarePlatformAPIEnabled" -PolicyType "Dword" -PolicyValue 0

# 1.20 Ensure 'Ephemeral profile' is set to 'Disabled'
Set-ChromePolicy -PolicyName "EphemeralProfile" -PolicyType "Dword" -PolicyValue 0

# 1.21 Ensure 'Import autofill form data from default browser on first run' is set to 'Disabled'
Set-ChromePolicy -PolicyName "ImportAutofillFormData" -PolicyType "Dword" -PolicyValue 0

# 1.22 Ensure 'Import of homepage from default browser on first run' is set to 'Disabled'
Set-ChromePolicy -PolicyName "ImportHomepage" -PolicyType "Dword" -PolicyValue 0

# 1.23 Ensure 'Import search engines from default browser on first run' is set to 'Disabled'
Set-ChromePolicy -PolicyName "ImportSearchEngine" -PolicyType "Dword" -PolicyValue 0

# 1.24 Ensure 'List of names that will bypass the HSTS policy check' is set to 'Disabled'
Set-ChromePolicy -PolicyName "HSTSPolicyBypassList" -PolicyType "String" -PolicyValue ""

# 1.25 Ensure 'Origins or hostname patterns for which restrictions on insecure origins should not apply' is set to 'Disabled'
Set-ChromePolicy -PolicyName "InsecureOriginsAllowedForUrls" -PolicyType "String" -PolicyValue ""

# 1.26 Ensure 'Suppress lookalike domain warnings on domains' is set to 'Disabled'
Set-ChromePolicy -PolicyName "LookalikeUrlNavigationSuggestionsEnabled" -PolicyType "Dword" -PolicyValue 0

# 1.27 Ensure 'Suppress the unsupported OS warning' is set to 'Disabled'
Set-ChromePolicy -PolicyName "SuppressUnsupportedOSWarning" -PolicyType "Dword" -PolicyValue 0

# 1.28 Ensure 'URLs for which local IPs are exposed in WebRTC ICE candidates' is set to 'Disabled'
Set-ChromePolicy -PolicyName "WebRtcLocalIpsAllowedUrls" -PolicyType "String" -PolicyValue ""

# 1.29 Ensure 'Update policy override' is set to 'Enabled: Automatic silent updates'
Set-ChromePolicy -PolicyName "UpdatePolicyOverride" -PolicyType "Dword" -PolicyValue 4

# 1.30 Ensure 'Notify a user that a browser relaunch or device restart is recommended or required' is set to 'Enabled'
Set-ChromePolicy -PolicyName "RelaunchNotification" -PolicyType "Dword" -PolicyValue 1

# Output completion message
Write-Host "Chrome CIS Section 1 settings have been applied."

# Continuation of the PowerShell script for Chrome CIS settings - Section 2

# ... previous settings ...

# 2.1.1 Ensure 'DNS interception checks enabled' is set to 'Enabled'
Set-ChromePolicy -PolicyName "DnsInterceptionChecksEnabled" -PolicyType "Dword" -PolicyValue 1

# 2.1.2 Ensure 'Enable component updates in Google Chrome' is set to 'Enabled'
Set-ChromePolicy -PolicyName "ComponentUpdatesEnabled" -PolicyType "Dword" -PolicyValue 1

# 2.1.3 Ensure 'Enable globally scoped HTTP auth cache' is set to 'Disabled'
Set-ChromePolicy -PolicyName "GloballyScopedHTTPAuthCacheEnabled" -PolicyType "Dword" -PolicyValue 0

# 2.1.4 Ensure 'Enable online OCSP/CRL checks' is set to 'Disabled'
Set-ChromePolicy -PolicyName "OnlineRevocationChecksEnabled" -PolicyType "Dword" -PolicyValue 0

# 2.1.5 Ensure 'Enable Renderer Code Integrity' is set to 'Enabled'
Set-ChromePolicy -PolicyName "RendererCodeIntegrityEnabled" -PolicyType "Dword" -PolicyValue 1

# 2.1.6 Ensure 'Enable security warnings for command-line flags' is set to 'Enabled'
Set-ChromePolicy -PolicyName "CommandLineFlagSecurityWarningsEnabled" -PolicyType "Dword" -PolicyValue 1

# 2.1.7 Ensure 'Enable third party software injection blocking' is set to 'Enabled'
Set-ChromePolicy -PolicyName "ThirdPartySoftwareInjectionBlocking" -PolicyType "Dword" -PolicyValue 1

# 2.1.8 Ensure 'Enables managed extensions to use the Enterprise Hardware Platform API' is set to 'Disabled'
Set-ChromePolicy -PolicyName "EnterpriseHardwarePlatformAPIEnabled" -PolicyType "Dword" -PolicyValue 0

# 2.1.9 Ensure 'Ephemeral profile' is set to 'Disabled'
Set-ChromePolicy -PolicyName "EphemeralProfile" -PolicyType "Dword" -PolicyValue 0

# 2.1.10 Ensure 'Import autofill form data from default browser on first run' is set to 'Disabled'
Set-ChromePolicy -PolicyName "ImportAutofillFormData" -PolicyType "Dword" -PolicyValue 0

# 2.1.11 Ensure 'Import of homepage from default browser on first run' is set to 'Disabled'
Set-ChromePolicy -PolicyName "ImportHomepage" -PolicyType "Dword" -PolicyValue 0

# 2.1.12 Ensure 'Import search engines from default browser on first run' is set to 'Disabled'
Set-ChromePolicy -PolicyName "ImportSearchEngine" -PolicyType "Dword" -PolicyValue 0

# 2.1.13 Ensure 'List of names that will bypass the HSTS policy check' is set to 'Disabled'
# Note: This setting requires a specific value or manual configuration.

# 2.1.14 Ensure 'Origins or hostname patterns for which restrictions on insecure origins should not apply' is set to 'Disabled'
Set-ChromePolicy -PolicyName "InsecureOriginsAllowedForUrls" -PolicyType "String" -PolicyValue ""

# 2.1.15 Ensure 'Suppress lookalike domain warnings on domains' is set to 'Disabled'
# Note: This setting might require manual configuration or a different approach.

# 2.1.16 Ensure 'Suppress the unsupported OS warning' is set to 'Disabled'
Set-ChromePolicy -PolicyName "SuppressUnsupportedOSWarning" -PolicyType "Dword" -PolicyValue 0

# 2.1.17 Ensure 'URLs for which local IPs are exposed in WebRTC ICE candidates' is set to 'Disabled'
Set-ChromePolicy -PolicyName "WebRtcLocalIpsAllowedUrls" -PolicyType "String" -PolicyValue ""

# 2.1.18 Ensure 'Update policy override' is set to 'Enabled: Automatic silent updates'
Set-ChromePolicy -PolicyName "UpdatePolicyOverride" -PolicyType "Dword" -PolicyValue 4

# 2.1.19 Ensure 'Notify a user that a browser relaunch or device restart is recommended or required' is set to 'Enabled'
Set-ChromePolicy -PolicyName "RelaunchNotification" -PolicyType "Dword" -PolicyValue 1

# Output completion message
Write-Host "Chrome CIS Section 2 settings have been applied."

# Continuation of the PowerShell script for Chrome CIS settings - Section 3

# ... previous settings ...

# 3.1.1 Ensure 'Configure the required domain names for remote access clients' is set to 'Enabled' with a domain defined
# Note: This setting requires a specific domain value to be set and may need manual configuration.

# 3.1.2 Ensure 'Enable curtaining of remote access hosts' is set to 'Disabled'
Set-ChromePolicy -PolicyName "RemoteAccessHostCurtain" -PolicyType "Dword" -PolicyValue 0

# 3.1.3 Ensure 'Enable firewall traversal from remote access host' is set to 'Disabled'
Set-ChromePolicy -PolicyName "RemoteAccessHostFirewallTraversal" -PolicyType "Dword" -PolicyValue 0

# 3.1.4 Ensure 'Enable or disable PIN-less authentication for remote access hosts' is set to 'Disabled'
Set-ChromePolicy -PolicyName "RemoteAccessHostAllowClientPairing" -PolicyType "Dword" -PolicyValue 0

# 3.1.5 Ensure 'Enable the use of relay servers by the remote access host' is set to 'Disabled'
Set-ChromePolicy -PolicyName "RemoteAccessHostRelayConnection" -PolicyType "Dword" -PolicyValue 0

# 3.1.6 Ensure 'Allow download restrictions' is set to 'Enabled: Block dangerous downloads'
Set-ChromePolicy -PolicyName "DownloadRestrictions" -PolicyType "Dword" -PolicyValue 3

# 3.1.7 Ensure 'Allow proceeding from the SSL warning page' is set to 'Disabled'
Set-ChromePolicy -PolicyName "SSLErrorOverrideAllowed" -PolicyType "Dword" -PolicyValue 0

# 3.1.8 Ensure 'Disable proceeding from the Safe Browsing warning page' is set to 'Enabled'
Set-ChromePolicy -PolicyName "SafeBrowsingProceedAnywayDisabled" -PolicyType "Dword" -PolicyValue 1

# 3.1.9 Ensure 'Enable Chrome Cleanup on Windows' is Configured
# Note: This setting requires specific values or manual configuration.

# 3.1.10 Ensure 'Enable Site Isolation for every site' is set to 'Enabled'
Set-ChromePolicy -PolicyName "IsolateOrigins" -PolicyType "String" -PolicyValue "*"

# 3.1.11 Ensure 'Enable reporting of usage and crash-related data' is set to 'Disabled'
Set-ChromePolicy -PolicyName "MetricsReportingEnabled" -PolicyType "Dword" -PolicyValue 0

# 3.1.12 Ensure 'Automatically sign in with a domain username and password' is set to 'Disabled'
Set-ChromePolicy -PolicyName "AutoFillEnabled" -PolicyType "Dword" -PolicyValue 0

# 3.1.13 Ensure 'Block access to a list of URLs' is set to 'Enabled' and properly configured
# Note: This setting requires a specific list of URLs and may need manual configuration.

# 3.1.14 Ensure 'Configure the list of force-installed apps and extensions' is set to 'Enabled' and properly configured
# Note: This setting requires a specific list of apps and extensions and may need manual configuration.

# 3.1.15 Ensure 'Control which extensions cannot be installed' is set to 'Enabled' and properly configured
# Note: This setting requires a specific list of extensions and may need manual configuration.

# 3.1.16 Ensure 'Define a list of allowed URLs' is set to 'Enabled' and properly configured
# Note: This setting requires a specific list of URLs and may need manual configuration.

# 3.1.17 Ensure 'Disallow incognito mode' is set to 'Enabled'
Set-ChromePolicy -PolicyName "IncognitoModeAvailability" -PolicyType "Dword" -PolicyValue 1

# 3.1.18 Ensure 'Disallow proceeding from the Safe Browsing warning page' is set to 'Enabled'
Set-ChromePolicy -PolicyName "SafeBrowsingProceedAnywayDisabled" -PolicyType "Dword" -PolicyValue 1

# 3.1.19 Ensure 'Do not allow any site to show desktop notifications' is set to 'Enabled'
Set-ChromePolicy -PolicyName "DefaultNotificationsSetting" -PolicyType "Dword" -PolicyValue 2

# 3.1.20 Ensure 'Prevent bypassing Safe Browsing warnings' is set to 'Enabled'
Set-ChromePolicy -PolicyName "SafeBrowsingProceedAnywayDisabled" -PolicyType "Dword" -PolicyValue 1

# ...additional settings as required...

# Output completion message
Write-Host "Chrome CIS Section 3 settings (continuation) have been applied."


# Continuation of the PowerShell script for Chrome CIS settings - Sections 4 and 5

# ... previous settings ...

# Section 4 - Google Cast, Payment Methods, Cookies, etc.
# 4.1.1 Ensure 'Enable Google Cast' is set to 'Disabled'
Set-ChromePolicy -PolicyName "EnableMediaRouter" -PolicyType "Dword" -PolicyValue 0

# 4.2.1 Ensure 'Allow websites to query for available payment methods' is set to 'Disabled'
Set-ChromePolicy -PolicyName "PaymentMethodQueryEnabled" -PolicyType "Dword" -PolicyValue 0

# 4.2.2 Ensure 'Block third party cookies' is set to 'Enabled'
Set-ChromePolicy -PolicyName "BlockThirdPartyCookies" -PolicyType "Dword" -PolicyValue 1

# Continuation of the PowerShell script for Chrome CIS settings - Section 4

# ... previous settings ...

# 4.2.3 Ensure 'Browser sign in settings' is set to 'Enabled: Disabled browser sign-in'
Set-ChromePolicy -PolicyName "BrowserSignin" -PolicyType "Dword" -PolicyValue 0

# 4.2.4 Ensure 'Control how Chrome Cleanup reports data to Google' is set to 'Disabled'
Set-ChromePolicy -PolicyName "SafeBrowsingExtendedReportingOptInAllowed" -PolicyType "Dword" -PolicyValue 0

# 4.2.5 Ensure 'Disable synchronization of data with Google' is set to 'Enabled'
Set-ChromePolicy -PolicyName "SyncDisabled" -PolicyType "Dword" -PolicyValue 1

# 4.2.6 Ensure 'Enable alternate error pages' is set to 'Disabled'
Set-ChromePolicy -PolicyName "AlternateErrorPagesEnabled" -PolicyType "Dword" -PolicyValue 0

# 4.2.7 Ensure 'Enable deleting browser and download history' is set to 'Disabled'
Set-ChromePolicy -PolicyName "AllowDeletingBrowserHistory" -PolicyType "Dword" -PolicyValue 0

# 4.2.8 Ensure 'Enable network prediction' is set to 'Enabled: Do not predict actions on any network connection'
Set-ChromePolicy -PolicyName "NetworkPredictionOptions" -PolicyType "Dword" -PolicyValue 2

# 4.2.9 Ensure 'Enable or disable spell checking web service' is set to 'Disabled'
Set-ChromePolicy -PolicyName "SpellCheckServiceEnabled" -PolicyType "Dword" -PolicyValue 0

# 4.2.10 Ensure 'Enable reporting of usage and crash-related data' is set to 'Disabled'
Set-ChromePolicy -PolicyName "MetricsReportingEnabled" -PolicyType "Dword" -PolicyValue 0

# 4.2.11 Ensure 'Enable Safe Browsing for trusted sources' is set to 'Disabled'
Set-ChromePolicy -PolicyName "SafeBrowsingForTrustedSourcesEnabled" -PolicyType "Dword" -PolicyValue 0

# 4.2.12 Ensure 'Enable search suggestions' is set to 'Disabled'
Set-ChromePolicy -PolicyName "SearchSuggestEnabled" -PolicyType "Dword" -PolicyValue 0

# 4.2.13 Ensure 'Enable Translate' is set to 'Disabled'
Set-ChromePolicy -PolicyName "TranslateEnabled" -PolicyType "Dword" -PolicyValue 0

# 4.2.14 Ensure 'Enable URL-keyed anonymized data collection' is set to 'Disabled'
Set-ChromePolicy -PolicyName "URLKeyedAnonymizedDataCollectionEnabled" -PolicyType "Dword" -PolicyValue 0

# 4.3.1 Ensure 'Allow or deny screen capture' is set to 'Disabled'
Set-ChromePolicy -PolicyName "DefaultScreenCaptureSetting" -PolicyType "Dword" -PolicyValue 2

# 4.3.2 Ensure 'Control use of the Serial API' is set to 'Enable: Do not allow any site to request access to serial ports via the Serial API'
Set-ChromePolicy -PolicyName "DefaultSerialGuardSetting" -PolicyType "Dword" -PolicyValue 2

# 4.3.3 Ensure 'Default Sensors Setting' is set to 'Enabled: Do not allow any site to access sensors'
Set-ChromePolicy -PolicyName "DefaultSensorsSetting" -PolicyType "Dword" -PolicyValue 2

# Output completion message
Write-Host "Chrome CIS Section 4 settings have been applied."


# Section 5 - Printing, Audio/Video Capture, DNS-over-HTTPS, etc.
# 5.1 Ensure 'Enable submission of documents to Google Cloud print' is set to 'Disabled'
Set-ChromePolicy -PolicyName "CloudPrintSubmitEnabled" -PolicyType "Dword" -PolicyValue 0

# 5.2 Ensure 'Allow invocation of file selection dialogs' is set to 'Disabled'
Set-ChromePolicy -PolicyName "AllowFileSelectionDialogs" -PolicyType "Dword" -PolicyValue 0

# 5.3 Ensure 'Allow or deny audio capture' is set to 'Disabled'
Set-ChromePolicy -PolicyName "DefaultAudioCaptureSetting" -PolicyType "Dword" -PolicyValue 2

# 5.4 Ensure 'Allow or deny video capture' is set to 'Disabled'
Set-ChromePolicy -PolicyName "DefaultVideoCaptureSetting" -PolicyType "Dword" -PolicyValue 2

# Continuation of the PowerShell script for Chrome CIS settings - Section 5

# ... previous settings ...

# 5.1 Ensure 'Enable submission of documents to Google Cloud print' is set to 'Disabled'
Set-ChromePolicy -PolicyName "CloudPrintSubmitEnabled" -PolicyType "Dword" -PolicyValue 0

# 5.2 Ensure 'Allow invocation of file selection dialogs' is set to 'Disabled'
Set-ChromePolicy -PolicyName "AllowFileSelectionDialogs" -PolicyType "Dword" -PolicyValue 0

# 5.3 Ensure 'Allow or deny audio capture' is set to 'Disabled'
Set-ChromePolicy -PolicyName "DefaultAudioCaptureSetting" -PolicyType "Dword" -PolicyValue 2

# 5.4 Ensure 'Allow or deny video capture' is set to 'Disabled'
Set-ChromePolicy -PolicyName "DefaultVideoCaptureSetting" -PolicyType "Dword" -PolicyValue 2

# 5.5 Ensure 'Allow user feedback' is set to 'Disabled'
Set-ChromePolicy -PolicyName "UserFeedbackAllowed" -PolicyType "Dword" -PolicyValue 0

# 5.6 Ensure 'Controls the mode of DNS-over-HTTPS' is set to 'Enabled: secure'
Set-ChromePolicy -PolicyName "DnsOverHttpsMode" -PolicyType "String" -PolicyValue "secure"

# 5.7 Ensure 'Enable AutoFill for addresses' is set to 'Disabled'
Set-ChromePolicy -PolicyName "AutofillAddressEnabled" -PolicyType "Dword" -PolicyValue 0

# 5.8 Ensure 'Enable AutoFill for credit cards' is set to 'Disabled'
Set-ChromePolicy -PolicyName "AutofillCreditCardEnabled" -PolicyType "Dword" -PolicyValue 0

# 5.9 Ensure 'Import saved passwords from default browser on first run' is set to 'Disabled'
Set-ChromePolicy -PolicyName "ImportSavedPasswords" -PolicyType "Dword" -PolicyValue 0

# 5.10 Ensure 'List of types that should be excluded from synchronization' is set to 'Enabled: passwords'
Set-ChromePolicy -PolicyName "SyncTypesListDisabled" -PolicyType "String" -PolicyValue "passwords"

# 5.11 Ensure 'Enable guest mode in browser' is set to 'Disabled'
Set-ChromePolicy -PolicyName "BrowserGuestModeEnabled" -PolicyType "Dword" -PolicyValue 0

# 5.12 Ensure 'Incognito mode availability' is set to 'Enabled: Incognito mode disabled'
Set-ChromePolicy -PolicyName "IncognitoModeAvailability" -PolicyType "Dword" -PolicyValue 2

# 5.13 Ensure 'Set disk cache size in bytes' is set to 'Enabled: 250609664'
Set-ChromePolicy -PolicyName "DiskCacheSize" -PolicyType "Dword" -PolicyValue 250609664

# Output completion message
Write-Host "Chrome CIS Section 5 settings have been applied."

#FINISHED
Write-Host "Holy Cuh this long ahh chrome script is finished"

