# powershellPingMonitor
Monitor the status of an IP address and generate summaries based on set intervals

## Description
This PowerShell script was developed to offer managed service providers (MSPs) a lightweight and gratis solution for monitoring troublesome devices. It runs in an endless loop, continuously pinging a specified IP address each second. On a set interval in seconds, it records a summary of the ping statistics to a timestamped text file for review.

## Requirements
- PowerShell 5.0 or higher
- Administrative rights on the machine where the script will be run
- Target device must be reachable over the network

## Features
- Easy to set up and run
- No additional software installation necessary
- Output includes the ping summary and elapsed time, both on the console and saved to a log file
- Automatic hourly summaries saved with a timestamp for easy tracking

## Setup Instructions
1. Open your favorite text editor (e.g., Notepad, Visual Studio Code).
2. Copy the provided PowerShell script into your text editor.
3. Save the file with a `.ps1` extension, for example, `continuous_ping_monitor.ps1`, to a known directory.
4. Right-click on Windows Start and open Windows PowerShell (Admin) to run the script with administrator privileges.
5. Navigate to the directory where you saved your script, e.g., `cd C:\path\to\your\script`
6. To execute the script, type `.\continuous_ping_monitor.ps1` and hit Enter.

## How to Use
Once running, the script will display the elapsed time and the latest summary statistics directly in the PowerShell console. It will save a new timestamped log file in the same directory as the script containing the statistics summary of the last ping batch.

## File Structure
- `continuous_ping_monitor.ps1`: The main script file that you need to run.
- `ping_summary_<timestamp>.txt`: Timestamped output files containing hourly ping summaries.

## Stopping the Script
To stop the script execution, you can press `Ctrl+C` in the PowerShell window or simply close the PowerShell window.

## Customization
You may change the target IP address, ping interval, or output directory by modifying the variables at the top of the script.

## Disclaimer
This script is provided as-is, with no guarantees or warranties. It is intended to be used by professionals who understand the potential impact of continuous network pinging on their environments.
