<#
.SYNOPSIS
    Completely uninstalls Palo Alto Networks GlobalProtect VPN from Windows.

.DESCRIPTION
    Stops services, uninstalls via MSI, removes leftover files and registry keys.
    Must be run as Administrator.
#>

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[ERROR] Please run this script as Administrator." -ForegroundColor Red
    Exit 1
}

$LogFile = "$env:TEMP\GlobalProtect_Uninstall.log"
Function Log($msg) {
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    "$timestamp - $msg" | Tee-Object -FilePath $LogFile -Append
}

Log "=== Starting GlobalProtect Uninstall ==="

# Stop GlobalProtect services
$services = "PanGPS", "PanGPA"
foreach ($svc in $services) {
    if (Get-Service -Name $svc -ErrorAction SilentlyContinue) {
        Log "Stopping service: $svc"
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    }
}

# Find and uninstall GlobalProtect via MSI
Log "Searching for GlobalProtect MSI product code..."
$gpProduct = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*GlobalProtect*" }

if ($gpProduct) {
    Log "Found GlobalProtect: $($gpProduct.Name) [$($gpProduct.IdentifyingNumber)]"
    Log "Uninstalling..."
    Start-Process "msiexec.exe" -ArgumentList "/x $($gpProduct.IdentifyingNumber) /qn /norestart" -Wait
} else {
    Log "GlobalProtect not found in MSI database. It may already be removed."
}

# Remove leftover folders
$paths = @(
    "C:\Program Files\Palo Alto Networks",
    "C:\Program Files (x86)\Palo Alto Networks",
    "$env:ProgramData\Palo Alto Networks",
    "$env:LOCALAPPDATA\Palo Alto Networks"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        Log "Removing folder: $path"
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Remove leftover registry keys
$regKeys = @(
    "HKLM:\SOFTWARE\Palo Alto Networks",
    "HKCU:\SOFTWARE\Palo Alto Networks",
    "HKLM:\SYSTEM\CurrentControlSet\Services\PanGPS",
    "HKLM:\SYSTEM\CurrentControlSet\Services\PanGPA"
)

foreach ($key in $regKeys) {
    if (Test-Path $key) {
        Log "Deleting registry key: $key"
        Remove-Item -Path $key -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Log "=== GlobalProtect Uninstall Completed ==="
Write-Host "GlobalProtect has been removed. A system restart is recommended." -ForegroundColor Green
Write-Host "Log file saved to: $LogFile"
