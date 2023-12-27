# Define the list of file extensions to search for
$extensions = @("aac", "ac3", "avi", "aiff", "bat", "bmp", "exe", "flac", "gif", "jpeg", "jpg", "mov", "m3u", "m4p",
                "mp2", "mp3", "mp4", "mpeg4", "midi", "msi", "ogg", "png", "txt", "sh", "wav", "wma", "vqf")

# Define the list of tool names to search for
$tools = @("Cain", "nmap", "keylogger", "Armitage", "Wireshark", "Metasploit", "netcat")

# Define the path to the log file
$logFile = "C:\Logs\FileLog.txt"

# Get all user directories under C:\Users
$userDirectories = Get-ChildItem -Path "C:\Users" -Directory

# Search for files with the specified extensions and tool names
foreach ($dir in $userDirectories) {
    # Search for files with specified extensions
    foreach ($ext in $extensions) {
        $files = Get-ChildItem -Path $dir.FullName -Filter "*.$ext" -Recurse -Force -ErrorAction SilentlyContinue
        foreach ($file in $files) {
            # Write the file path to the log file
            Add-Content -Value $file.FullName -Path $logFile
        }
    }
    
    # Search for files that include tool names
    foreach ($tool in $tools) {
        $files = Get-ChildItem -Path $dir.FullName -Filter "*$tool*" -Recurse -Force -ErrorAction SilentlyContinue
        foreach ($file in $files) {
            # Write the file path to the log file
            Add-Content -Value $file.FullName -Path $logFile
        }
    }
}

# Output completion message
Write-Host "File search completed and logged to $logFile."
