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


 Write-Host "Removing Existing Local GPOs" -ForegroundColor Green
    #Remove and Refresh Local Policies
    Remove-Item -Recurse -Force "$env:WinDir\System32\GroupPolicy" | Out-Null
    Remove-Item -Recurse -Force "$env:WinDir\System32\GroupPolicyUsers" | Out-Null
    secedit /configure /cfg "$env:WinDir\inf\defltbase.inf" /db defltbase.sdb /verbose | Out-Null
    gpupdate /force | Out-Null


# Output completion message
Write-Host "Group Policy has been reset to default. A system restart might be required." -ForegroundColor Green
Write-Host "Doing NETSH RESET"
netsh advfirewall reset
