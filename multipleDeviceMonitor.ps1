# Define the interval and output directory
$intervalSeconds = 3600 # Interval is set to 1 hour
$outputRootDirectory = "." # Outputs to the current directory

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

Write-Host "Continuous ping started. Please do not kill as this script is collecting diagnostic information."
Write-Host "Press Ctrl+C to exit."

while ($true) {
    foreach ($targetIP in $targetDevices) {
        $startTime = Get-Date
        $timestamp = $startTime.ToString("yyyyMMdd_HHmmss") # Timestamp for file naming

        $outputFile = Join-Path $deviceFolders[$targetIP] ("ping_summary_" + $timestamp + ".txt")
        $pingCommand = "ping $targetIP -n $intervalSeconds"

        Write-Host "Running continuous ping for $targetIP for $intervalSeconds seconds."
        $pingResults = Invoke-Expression $pingCommand
        $pingSummary = $pingResults[-4..-1] -join "`n" # Get summary lines from the ping results

        Out-File -InputObject $pingSummary -FilePath $outputFile -Append

        Write-Host "`nElapsed Time: $((Get-Date) - $startTime) `n"
        Write-Host "Last Ping Summary for $targetIP:"
        Write-Host $pingSummary
    }

    Start-Sleep -Seconds $intervalSeconds
}

# 2024 - Chillwave on Github