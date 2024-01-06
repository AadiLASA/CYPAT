# Enhanced PowerShell Script to Harden IIS for Secure Enterprise Environment

# Ensure the script is run with administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run this script as an Administrator!"
    break
}

# Install IIS if not already installed
Import-Module ServerManager
Add-WindowsFeature Web-Server -NoRestart

# Remove Unnecessary IIS Features to Reduce Attack Surface
# Customize this list based on the features you actually need
$featuresToRemove = @("Web-FTP-Server", "Web-WebDAV-Publishing", "Web-CGI", "Web-Server-Side-Includes", "Web-Default-Doc", "Web-Dir-Browsing")
foreach ($feature in $featuresToRemove) {
    Remove-WindowsFeature $feature -NoRestart
}

# Configure Application Pools for Enhanced Security
Import-Module WebAdministration
Get-ChildItem IIS:\AppPools | ForEach-Object {
    $_ | Set-ItemProperty -Name "enable32BitAppOnWin64" -Value $false
    $_ | Set-ItemProperty -Name "managedRuntimeVersion" -Value "v4.0"
    $_ | Set-ItemProperty -Name "processModel.identityType" -Value 3 # Use ApplicationPoolIdentity
    $_ | Set-ItemProperty -Name "processModel.loadUserProfile" -Value $false
    $_ | Set-ItemProperty -Name "processModel.pingingEnabled" -Value $true
    $_ | Set-ItemProperty -Name "processModel.idleTimeout" -Value (New-TimeSpan -Minutes 20)
    $_ | Set-ItemProperty -Name "recycling.periodicRestart.time" -Value (New-TimeSpan -Hours 29)
}

# Enforce SSL and Use Security Headers
# Replace 'yourSiteName' with your actual site name
$siteName = "yourSiteName"
$binding = Get-WebBinding -Name $siteName -Protocol "http"
if ($binding -ne $null) {
    Remove-WebBinding -Name $siteName -Protocol "http"
}
New-WebBinding -Name $siteName -IP "*" -Port 443 -Protocol "https"

# Set Security Headers
$sitePath = "IIS:\Sites\$siteName"
Set-WebConfigurationProperty "$sitePath" -filter "system.webServer/httpProtocol/customHeaders" -name "." -value @{name='Strict-Transport-Security';value='max-age=31536000; includeSubDomains'}
Set-WebConfigurationProperty "$sitePath" -filter "system.webServer/httpProtocol/customHeaders" -name "." -value @{name='X-Content-Type-Options';value='nosniff'}
Set-WebConfigurationProperty "$sitePath" -filter "system.webServer/httpProtocol/customHeaders" -name "." -value @{name='X-Frame-Options';value='SAMEORIGIN'}
Set-WebConfigurationProperty "$sitePath" -filter "system.webServer/httpProtocol/customHeaders" -name "." -value @{name='X-XSS-Protection';value='1; mode=block'}
Set-WebConfigurationProperty "$sitePath" -filter "system.webServer/httpProtocol/customHeaders" -name "." -value @{name='Content-Security-Policy';value="default-src 'self'"}

# Disable Weak SSL Protocols and Ciphers
# Important: Adjust according to your security requirements and compatibility
Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/security/access" -name "sslFlags" -value "Ssl, Ssl128"

# Disable Server Header
Set-WebConfigurationProperty '/system.webServer/security/requestFiltering' -name 'removeServerHeader' -value $true

# Configure Request Limits
Set-WebConfigurationProperty '/system.webServer/security/requestFiltering/requestLimits' -name 'maxAllowedContentLength' -value 30000000
Set-WebConfigurationProperty '/system.webServer/security/requestFiltering/requestLimits' -name 'maxUrl' -value 1024
Set-WebConfigurationProperty '/system.webServer/security/requestFiltering/requestLimits' -name 'maxQueryString' -value 2048

# Restrict File Extensions and HTTP Verbs
# Customize this list based on your application requirements
$deniedExtensions = @(".exe", ".dll", ".so", ".bat", ".cmd", ".vbs", ".js")
foreach ($ext in $deniedExtensions) {
    Add-WebConfigurationProperty -filter "system.webServer/security/requestFiltering/fileExtensions" -name "." -value @{fileExtension=$ext;allowed="False"}
}
Set-WebConfigurationProperty "system.webServer/security/requestFiltering/verbs" -name "allowUnlisted" -value "False"
Set-WebConfigurationProperty "system.webServer/security/requestFiltering/verbs" -name "." -value @{verb="GET";allowed="True"}
Set-WebConfigurationProperty "system.webServer/security/requestFiltering/verbs" -name "." -value @{verb="POST";allowed="True"}

# Restart IIS to apply changes
Restart-Service -Name W3SVC -Force

# End of script
Write-Host "Enhanced IIS Hardening Script Execution Completed." -ForegroundColor Green
