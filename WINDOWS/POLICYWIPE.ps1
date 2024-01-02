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
