$targetIP = "1.1.1.1"
$intervalSeconds = 3600 # Interval is set to 1 hour
$outputDirectory = "."   # Outputs to the current directory

while ($true) {
    $startTime = Get-Date
    $timestamp = $startTime.ToString("yyyyMMdd_HHmmss") # Timestamp for file naming

    $outputFile = Join-Path $outputDirectory ("ping_summary_" + $timestamp + ".txt")
    $pingCommand = "ping $targetIP -n $intervalSeconds"

    Write-Host "Running continuous ping for $intervalSeconds seconds."
    $pingResults = Invoke-Expression $pingCommand
    $pingSummary = $pingResults[-4..-1] -join "`n" # Get summary lines from the ping results

    Out-File -InputObject $pingSummary -FilePath $outputFile -Append

    Write-Host "`nElapsed Time: $((Get-Date) - $startTime) `n"
    Write-Host "Last Ping Summary:"
    Write-Host $pingSummary

    Start-Sleep -Seconds $intervalSeconds
}
