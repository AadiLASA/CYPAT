# Apache2 Hardening Script for Windows 10 - Enterprise Standards with STIG References

# Ensure running as an Administrator or with sufficient privileges

# Install Apache if not already installed (V-2246)
# Ensure using a vendor-supported version for security patches and updates

# Update Apache to the latest version
# This can be done manually or through a package manager like Chocolatey

# Define the Apache configuration file path
$apacheConfigPath = "C:\Path\To\Apache\Config\httpd.conf"

# Disable Server Side Includes execution (V-13733)
# The Options directive configures the web server features that are available in particular directories.
$ssiConfig = "Options -Includes -ExecCGI"
Add-Content -Path $apacheConfigPath -Value $ssiConfig

# Remove unnecessary files and directories (V-13621)
# This should be done manually as it involves deleting files and directories
# Example: Remove-Item -Path "C:\Path\To\Apache\htdocs\*" -Recurse -Force

# Limit HTTP Request Size (V-13736, V-13737, V-13738, V-13739)
# Configure limits to prevent buffer overflow attacks
$requestLimitsConfig = @"
<IfModule mod_reqtimeout.c>
    RequestReadTimeout header=20-40,MinRate=500 body=20,MinRate=500
</IfModule>
"@
Add-Content -Path $apacheConfigPath -Value $requestLimitsConfig

# Disable FollowSymLinks (V-13732)
# Prevent the server from following symbolic links
$followSymLinksConfig = "Options -FollowSymLinks"
Add-Content -Path $apacheConfigPath -Value $followSymLinksConfig

# Disable MultiViews (V-13734)
# Prevent content negotiation for MIME types
$multiViewsConfig = "Options -MultiViews"
Add-Content -Path $apacheConfigPath -Value $multiViewsConfig

# Disable Directory Indexing (V-13735)
# Prevent directory listings in absence of an index file
$dirIndexingConfig = "Options -Indexes"
Add-Content -Path $apacheConfigPath -Value $dirIndexingConfig

# End of first part of the script
# Continuing Apache2 Hardening Script for Windows 10 - Enterprise Standards with STIG References

# Define the Apache configuration file path


# Limit HTTP Request Methods (V-26396)
# Disabling methods such as PUT, DELETE, etc.
$httpMethodsConfig = @"
<LimitExcept GET POST HEAD>
    deny from all
</LimitExcept>
"@
Add-Content -Path $apacheConfigPath -Value $httpMethodsConfig

# Disable User Directories (V-26302)
# Prevent access to user directories via Apache
$userDirConfig = "UserDir disabled"
Add-Content -Path $apacheConfigPath -Value $userDirConfig

# Disable WebDAV (V-26287)
# WebDAV can be disabled by ensuring the relevant modules are not loaded
# This may require commenting out or removing the LoadModule directives for mod_dav and mod_dav_fs

# Disable Status and Info Modules (V-26294)
# Ensure mod_status and mod_info are not loaded or enabled
# Comment out or remove LoadModule directives for mod_status and mod_info

# Set KeepAliveTimeout (V-13726)
# Define the number of seconds Apache will wait for a subsequent request
$keepAliveTimeoutConfig = "KeepAliveTimeout 5"
Add-Content -Path $apacheConfigPath -Value $keepAliveTimeoutConfig

# Enable KeepAlive (V-13725)
# Keep connections open to allow multiple requests over the same connection
$keepAliveConfig = "KeepAlive On"
Add-Content -Path $apacheConfigPath -Value $keepAliveConfig

# Set Timeout (V-13724)
# Define a timeout period for requests
$timeoutConfig = "Timeout 300"
Add-Content -Path $apacheConfigPath -Value $timeoutConfig

# Disable TRACE method (V-26325)
# Disabling TRACE method to mitigate XST attacks
$traceMethodConfig = "TraceEnable off"
Add-Content -Path $apacheConfigPath -Value $traceMethodConfig

# Configure minimum file permissions (V-2259, V-2256)
# File permissions should be set correctly in the file system
# Example: Set file permissions for Apache config files to be accessible only by the web server account or administrators

# Disable automatic directory indexing (V-26368)
# Ensure that Indexes option is off to prevent directory listing
$autoIndexConfig = "Options -Indexes"
Add-Content -Path $apacheConfigPath -Value $autoIndexConfig

# Set proper ownership for htpasswd files (V-2255)
# Ensure htpasswd files are owned by the Apache service account or administrators

# Ensure Apache runs under a non-privileged account (V-13619)
# Configure Apache to run under a dedicated, non-privileged service account

# End of second part of the script
# Continuing Apache2 Hardening Script for Windows 10 - Enterprise Standards with STIG References


# Secure the Process ID File (V-26305)
# Ensure the PID file is securely stored and has appropriate permissions
$pidFileConfig = "PidFile `"/path/to/secure/location/httpd.pid`""
Add-Content -Path $apacheConfigPath -Value $pidFileConfig

# Explicitly Deny Access to the OS Root (V-26323)
# Prevent access to the root of the OS file system via Apache
$osRootAccessConfig = @"
<Directory />
    Require all denied
</Directory>
"@
Add-Content -Path $apacheConfigPath -Value $osRootAccessConfig

# Secure the ScoreBoard File (V-26322)
# Ensure the ScoreBoard file is stored in a secure location and has proper permissions
$scoreBoardFileConfig = "ScoreBoardFile `"/path/to/secure/location/apache_runtime_status`""
Add-Content -Path $apacheConfigPath -Value $scoreBoardFileConfig

# Remove Export Ciphers from the Cipher Suite (V-60709)
# Ensure export ciphers are not used in SSL/TLS configuration
# This requires manual configuration in the SSL configuration file

# Secure URL-Path Names (V-26327)
# Ensure URL-path names correspond to actual file system paths for security
# This is a manual check and configuration process

# Listen on Specific IP and Port (V-26326)
# Configure Apache to listen only on specific IP addresses and ports
$listenConfig = "Listen 192.168.1.10:80"
Add-Content -Path $apacheConfigPath -Value $listenConfig

# Disable Web Server Options for the OS Root (V-26324)
# Ensure that options like ExecCGI, Includes, etc., are not enabled for the OS root
$webServerOptionsConfig = @"
<Directory />
    Options None
    AllowOverride None
    Require all denied
</Directory>
"@
Add-Content -Path $apacheConfigPath -Value $webServerOptionsConfig

# Backup Configuration and Content Files (V-6485)
# Implement a routine backup program for Apache configuration and content files
# This process typically involves a system administration task or backup software

# Prohibit Backup Interactive Scripts (V-2230)
# Ensure interactive scripts are not part of backups or are stored securely
# This requires manual configuration and process implementation

# Remove or Disable Unnecessary Utility Programs (V-2251)
# Uninstall or disable utility programs not necessary for operations
# This requires identifying and manually handling such utilities

# Protect Web Server Information (V-6724)
# Configure Apache to minimize information disclosure in HTTP responses
$serverSignatureConfig = "ServerSignature Off"
Add-Content -Path $apacheConfigPath -Value $serverSignatureConfig

# Document Administrative Users and Groups (V-2257)
# Maintain documentation of users and groups with administrative access to the web server
# This is a policy and documentation task, not directly scriptable

# End of script
