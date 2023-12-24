# Path to the CSV file
$csvPath = "path\to\Black Vipers Windows 10 Service Configurations - Black Viper BlackViper.Com.csv"

# Prompt for the configuration to apply
$configurations = @("DEFAULT Windows 10 Home", "DEFAULT Windows 10 Pro", "Safe for DESKTOP", "Safe for LAPTOP or TABLET", "Tweaked for DESKTOP")
$selectedConfig = $host.ui.PromptForChoice("Select Configuration", "Choose the configuration to apply:", $configurations, 0)

# Read the CSV file
$serviceSettings = Import-Csv -Path $csvPath

# Iterate through each row and set the service configuration
foreach ($service in $serviceSettings) {
    $serviceName = $service.'Service Name (Registry)'
    $startupType = $service[$configurations[$selectedConfig]]

    # Skip if the service is not available or if the startup type is not a standard type
    if ($startupType -eq "Not Available" -or $startupType -eq "Not Installed" -or $startupType -like "* *") {
        continue
    }

    # Check if the service exists
    $serviceExists = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($serviceExists) {
        # Set the startup type of the service
        Set-Service -Name $serviceName -StartupType $startupType -ErrorAction SilentlyContinue
    } else {
        Write-Warning "Service $($serviceName) not found."
    }
}

# Output completion message
Write-Host "Service configurations updated."
