# PowerShell Script to Reset Local Group Policy to Default

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Please run this script as an Administrator!"
    break
}


Stop-Service -Name "gpsvc" -Force

$policyPaths = @("$env:windir\System32\GroupPolicy", "$env:windir\System32\GroupPolicyUsers")
foreach ($path in $policyPaths) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force
    }
}

gpupdate /force

Start-Service -Name "gpsvc"

Write-Host "Group Policy has been reset to default." -ForegroundColor Green
