###########################################################################################
# Script Name: The Network Monitor
# Script Purpose: The Network Monitor - Monitor Devices by pinging them
# Created By: Woodward.Digital
# Website: https://woodward.digital
# Email: contact@woodward.digital
# Version: v1.0
###########################################################################################
# Set Loop
$Exit = "False"
Do{
# Reset Counter
$AvailableDevices = 0
$UnavailableDevices = 0

Write-Host "The Network Monitor -"(Get-Date -format "dd-MMM-yyyy HH:mm:ss")

# CSV File Import
$DeviceList = Import-Csv -Path "G:\Michael\OneDrive\Desktop\The Network Monitor\DeviceList.csv"

# Ping Devices
Foreach ($Device in $DeviceList){
    $DeviceName = $Device.Name
    $DeviceAddr = $Device.IP

if(Test-Connection -ComputerName $DeviceAddr -Quiet -ErrorAction SilentlyContinue -Count 1){
    # Device is available
    $AvailableDevices ++
    }
Else{
    # Device is not available
    Write-Host "Unavailable host -----> "$DeviceName" " -BackgroundColor Red -ForegroundColor White
    $UnavailableDevices ++
    }
}

# Output results
write-host "-----------------------------------------------------"
write-host "Monitoring summary"
Write-Host "Available device count:"$AvailableDevices
Write-Host "Unavailable device count:"$UnavailableDevices
write-host "-----------------------------------------------------"

# Time between re-tests
Timeout /t 60
Clear-Host
}While ($Exit -ne $True)