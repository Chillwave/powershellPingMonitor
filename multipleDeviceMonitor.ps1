# PowershellPingMonitor - Chillwave on GitHub
# Ensure there is an "IPs.txt" file with each address intended to monitor

# Define the interval and output directory
$intervalSeconds = 3600 # Interval is set to 1 hour
$outputRootDirectory = "." # Outputs to the current directory
$elapsedTime = ((Get-Date) - $startTime)

# Read the list of target devices from IPs.txt
$targetDevices = @()
Get-Content -Path "IPs.txt" | ForEach-Object {
    $targetDevices += $_.Trim()
}

# Create a separate folder for each device
$deviceFolders = @{}
foreach ($targetIP in $targetDevices) {
    $deviceFolder = Join-Path $outputRootDirectory $targetIP
    New-Item -ItemType Directory -Path $deviceFolder -Force | Out-Null
    $deviceFolders[$targetIP] = $deviceFolder
}

Write-Host "Continuous ping started. Press Ctrl+C on each window or right click Powershell on the taskbar to close all sessions."

foreach ($targetIP in $targetDevices) {
    $argList = @()
    $argList += "-Command"
    $argList += "& {"
    $argList += "`$intervalSeconds = $intervalSeconds;"
    $argList += "`$outputRootDirectory = '$outputRootDirectory';"
    $argList += "`$deviceFolders = @{ '$targetIP' = '$($deviceFolders[$targetIP])' };"
    $argList += "while (`$true) {"
    $argList += "    `$startTime = Get-Date;"
    $argList += "    `$timestamp = `$startTime.ToString('yyyyMMdd_HHmmss');"
    $argList += "    `$outputFile = Join-Path `$deviceFolders['$targetIP'] ('ping_summary_' + `$timestamp + '.txt');"
    $argList += "    `$pingCommand = 'ping $targetIP -n `$intervalSeconds';"
    $argList += "    Write-Host 'Running continuous ping on $targetIP for $intervalSeconds seconds.';"
    $argList += "    `$pingResults = Invoke-Expression `$pingCommand;"
    $argList += "    `$pingSummary = `$pingResults[-4..-1] -join '`n';"
    $argList += "    Out-File -InputObject `$pingSummary -FilePath `$outputFile -Append;"
    $argList += "    Write-Host '`nElapsed Time: $elapsedTime `n';"
    $argList += "    Write-Host 'Last Ping Summary for $targetIP -';"
    $argList += "    Write-Host `$pingSummary;"
    $argList += "    Start-Sleep -Seconds `$intervalSeconds;"
    $argList += "}"
    $argList += "}"

    Start-Process -FilePath "powershell" -ArgumentList $argList
}
