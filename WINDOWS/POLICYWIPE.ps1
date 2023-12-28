# PowerShell Script to Reset Local Group Policy to Default

# Check for administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Please run this script as an Administrator!"
    Exit
}

# Reset security settings to default
secedit /configure /db reset.sdb /cfg "$env:windir\inf\defltbase.inf" /overwrite /areas SECURITYPOLICY

# Delete registry.pol files
$registryPolPaths = @("$env:windir\System32\GroupPolicy\Machine\registry.pol", "$env:windir\System32\GroupPolicy\User\registry.pol")
foreach ($path in $registryPolPaths) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Force
    }
}

# Refresh the policy
gpupdate /force

# Output completion message
Write-Host "Group Policy has been reset to default. A system restart might be required." -ForegroundColor Green


        auditpol /set /category:"Account Logon" /success:enable 
        auditpol /set /category:"Account Logon" /failure:enable
        auditpol /set /category:"Account Management" /success:enable
        auditpol /set /category:"Account Management" /failure:enable
        auditpol /set /category:"DS Access" /success:enable
        auditpol /set /category:"DS Access" /failure:enable
        auditpol /set /category:"Logon/Logoff" /success:enable
        auditpol /set /category:"Logon/Logoff" /failure:enable
        auditpol /set /category:"Object Access" /success:enable
        auditpol /set /category:"Object Access" /failure:enable
        auditpol /set /category:"Policy Change" /success:enable
        auditpol /set /category:"Policy Change" /failure:enable
        auditpol /set /category:"Privilege Use" /success:enable
        auditpol /set /category:"Privilege Use" /failure:enable
        auditpol /set /category:"Detailed Tracking" /success:enable
        auditpol /set /category:"Detailed Tracking" /failure:enable
        auditpol /set /category:"System" /success:enable 
        auditpol /set /category:"System" /failure:enable

Write-Host "Additional Audit Policies Applied B)" -ForegroundColor Green
