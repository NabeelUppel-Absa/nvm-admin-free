<#
.SYNOPSIS
  Installs admin-free NVM and Node.js for the current user only.

.DESCRIPTION
  - No admin required
  - No system-wide changes
  - Safe for corporate machines
#>

param (
    [string]$NvmHome = "$Env:USERPROFILE\nvm",
    [string]$NodeVersion = "14.21.3"
)

Write-Host "=== NVM Admin-Free Installer ===" -ForegroundColor Cyan

# --- Ensure script execution works (current session only)
try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force
} catch {
    Write-Error "Failed to set execution policy."
    exit 1
}

# --- URLs
$nvmZipUrl = "https://github.com/coreybutler/nvm-windows/releases/latest/download/nvm-noinstall.zip"
$tempZip   = "$Env:TEMP\nvm-noinstall.zip"

# --- Create NVM directory
Write-Host "Creating NVM directory at $NvmHome"
New-Item -ItemType Directory -Force -Path $NvmHome | Out-Null

# --- Download NVM
Write-Host "Downloading NVM..."
Invoke-WebRequest -Uri $nvmZipUrl -OutFile $tempZip

# --- Extract
Write-Host "Extracting NVM..."
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($tempZip, $NvmHome, $true)

Remove-Item $tempZip -Force

# --- Create settings.txt
$settings = @"
root: $NvmHome
path: $NvmHome\nodejs
arch: 64
proxy: none
"@

$settingsPath = Join-Path $NvmHome "settings.txt"
$settings | Set-Content -Path $settingsPath -Encoding ASCII

# --- Set user environment variables
Write-Host "Configuring environment variables..."

[Environment]::SetEnvironmentVariable("NVM_HOME", $NvmHome, "User")
[Environment]::SetEnvironmentVariable("NVM_SYMLINK", "$NvmHome\nodejs", "User")

# --- Update PATH (user scope only)
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($userPath -notlike "*$NvmHome*") {
    $newPath = "$NvmHome;$NvmHome\nodejs;$userPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
}

# --- Reload environment for current session
$Env:NVM_HOME = $NvmHome
$Env:NVM_SYMLINK = "$NvmHome\nodejs"
$Env:Path = "$NvmHome;$NvmHome\nodejs;$Env:Path"

# --- Verify NVM
Write-Host "Validating NVM install..."
if (-not (Get-Command nvm -ErrorAction SilentlyContinue)) {
    Write-Error "NVM not found on PATH"
    exit 1
}

nvm -v

# --- Install Node.js
Write-Host "Installing Node.js $NodeVersion..."
nvm install $NodeVersion
nvm use $NodeVersion

# --- Sanity check
Write-Host "Verifying Node.js..."
node -v

Write-Host "✅ NVM + Node.js installation complete" -ForegroundColor Green
Write-Host "Restart PowerShell to persist environment changes."
