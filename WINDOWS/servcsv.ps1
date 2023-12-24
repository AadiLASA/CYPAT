# Path to the CSV file
$csvPath = "services.csv"

# Read the CSV file
$serviceSettings = Import-Csv -Path $csvPath -Header "ServiceName", "StartupType"

# Iterate through each row and set the service configuration
foreach ($service in $serviceSettings) {
    $serviceName = $service.ServiceName
    $startupType = $service.StartupType

    # Check if the service exists
    $serviceExists = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($serviceExists) {
        try {
            # Attempt to set the startup type of the service
            Set-Service -Name $serviceName -StartupType $startupType -ErrorAction Stop
        } catch {
            Write-Warning "Could not set startup type for service $($serviceName)."
        }
    } else {
        Write-Warning "Service $($serviceName) not found."
    }
}

# Output completion message
Write-Host "Service configurations updated."
