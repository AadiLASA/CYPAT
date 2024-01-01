# Function to Check and Install Chocolatey if it's not already installed
function Ensure-ChocolateyInstalled {
    if (-not (Get-Command "choco" -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
}

# Ensure Chocolatey is Installed
Ensure-ChocolateyInstalled

# Function to Manage Chocolatey Packages
function Manage-ChocoPackage {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Action,
        [Parameter(Mandatory=$true)]
        [string]$PackageName
    )

    switch ($Action) {
        "install" {
            choco install $PackageName -y
        }
        "uninstall" {
            choco uninstall $PackageName -y
        }
        "update" {
            choco upgrade $PackageName -y
        }
    }
}

# Prompt for Applications to Install, Uninstall, and Update
$actions = @("uninstall", "install", "update")
foreach ($action in $actions) {
    do {
        $packageName = Read-Host "Enter a package name to $action (or just press Enter to skip)"
        if ($packageName) {
            Manage-ChocoPackage -Action $action -PackageName $packageName
        }
    } while ($packageName)
}

Write-Host "Chocolatey package management completed."
